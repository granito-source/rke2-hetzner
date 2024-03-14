variable "fqdn" {
    type        = string
    description = "cluster FQDN"
}

variable "cert_manager_version" {
    type        = string
    default     = "v1.14.4"
    description = "cert-manager Helm chart version"
}

variable "acme_email" {
    type    = string
    default = "Let's Encrypt ACME registration e-mail"
}

variable "longhorn_version" {
    type        = string
    description = "Longhorn Helm chart version"
}

variable "longhorn_user" {
    type        = string
    default     = "longhorn"
    description = "Longhorn UI user"
}

variable "headlamp_version" {
    type        = string
    description = "Headlamp Helm chart version"
}
