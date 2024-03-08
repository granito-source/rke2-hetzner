data "remote_file" "kubeconfig" {
    path = "/etc/rancher/rke2/rke2.yaml"
    conn {
        host        = hcloud_server.master0.ipv4_address
        user        = "root"
        private_key = tls_private_key.root.private_key_openssh
    }
}

locals {
    kubeconfig             = yamldecode(data.remote_file.kubeconfig.content)
    cluster_ca_certificate = local.kubeconfig.clusters[0].cluster.certificate-authority-data
    client_certificate     = local.kubeconfig.users[0].user.client-certificate-data
    client_key             = local.kubeconfig.users[0].user.client-key-data
}

resource "local_file" "kubeconfig" {
    filename        = "config-${var.cluster_name}.yaml"
    file_permission = "0600"
    content         = <<-EOT
    apiVersion: v1
    kind: Config
    clusters:
    - cluster:
        certificate-authority-data: ${local.cluster_ca_certificate}
        server: https://${local.fqdn}:6443
      name: ${var.cluster_name}
    contexts:
    - context:
        cluster: ${var.cluster_name}
        user: ${var.cluster_name}-admin
      name: ${var.cluster_name}
    current-context: ${var.cluster_name}
    preferences: {}
    users:
    - name: ${var.cluster_name}-admin
      user:
        client-certificate-data: ${local.client_certificate}
        client-key-data: ${local.client_key}
    EOT
}