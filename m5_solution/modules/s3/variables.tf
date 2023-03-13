variable "bucket_name" {
  type        = string
  description = "Name of the bucket"
}

variable "elb_service_account_arn" {
  type        = string
  description = "ARN of ELB service account"
}

variable "common_tags" {
  type        = map(string)
  description = "Map of tags"
  default = {
  }
}