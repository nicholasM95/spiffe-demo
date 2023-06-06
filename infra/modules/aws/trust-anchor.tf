data "local_file" "ca_bundle" {
  filename = "ca.crt"
}

resource "aws_rolesanywhere_trust_anchor" "trust_anchor" {
  name    = "nicholas_meyers_home_k8s"
  enabled = true
  source {
    source_data {
      x509_certificate_data = data.local_file.ca_bundle.content
    }
    source_type = "CERTIFICATE_BUNDLE"
  }
}