variable "aws_region" {
    description = "AWS region"
    type        = string
    default     = "us-west-2"
}

variable "oauth_secret" {
    description = "OAuth Client Secret"
    type        = string
    default     = "I7tKklIfhb8n1yexPBBs-69_ldH39QMAqrVcspViAiA"
}

variable "oauth_client" {
    description = "Project name"
    type        = string
    default     = "60172323-250b-44df-bc6f-f8f27b5129fe"
}

variable "working_dir" {
  description = "The path to the working directory."
  type        = object({
    script    = string
  })
    default = {
    script    = "./scripts"
  }
}