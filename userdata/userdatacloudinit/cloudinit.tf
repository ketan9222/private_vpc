# Render a part using a `template_file`
data "template_file" "install_apache" {
  template = file("init.cfg")

}

# Render a multi-part cloud-init config making use of the part
# above, and other source files
data "template_cloudinit_config" "install_apache-config" {
  gzip          = false
  base64_encode = false

  # Main cloud-config configuration file.
  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = data.template_file.install_apache.rendered
  }
}