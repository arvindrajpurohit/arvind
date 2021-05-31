variable "image_id" {
  type = "string"
  default = "ami-0ee02acd56a52998e"
}

variable "bucket_name" {
  type = "string"
  default = "logs-2906738831"
}

variable "availability_zone_names" {
  type    = list(string)
  default = ["us-west-1a"]
}


variable "index" {
  description = "Index to create. adds a timestamp to index. Example: elblogs-2016.03.31"
  default     = "elblogs"
}

variable "doctype" {
  description = "doctype"
  default     = "elb-access-logs"
}
