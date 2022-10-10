
# Request region definition

variable "region" {
  description = "Region where resources will be created"
  type        = string
  default     = "us-central1"
}

variable "project_id" {
  type    = string
  default = "modular-scout-345114"
}

variable "access_token"{
    type = string
    sensitive   = true
}

variable "labels"{
    type = map
}

variable "access_token"{
    type = string
    sensitive   = true
}
