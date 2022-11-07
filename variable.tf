variable "aws_security_group_name" {
  description = "aws_security_group_name"
  type        =  string
}

variable "region" {
  description = "provider_for region"
  type        = string
  default     = "ap-south-1"                                      
}
variable "access_key" {
  description = "access_key"
  type        = string
  default     = "AKIAR2NW6YMBR2S5UW4C"                          
}

variable "secret_key" {
  description = "secret_key "
  type        = string
  default     = "QX5pnEj7q8xkkPHZpvnUu3hG8VV3DoF8tJPlafku"
}
variable "name_prefix" {
  description = "prefix_name"
  type        = string
}

variable "instance_type" {
  description = "instance_type"
  type        = string
}

variable "elb_http" {
  description = "elb_http"
  type        = string
  
}

variable "Greenalytics_policy_up" {
  description = "Greenalytics_policy_up"
  type        = string
}

variable "cpu_alarm_up" {
  description = "cpu_alarm_up"
  type        = string
}

variable "Greenalytics_policy_down" {
  description = "Greenalytics_policy_down"
  type        = string
}

variable "cpu_alarm_down" {
  description = "cpu_alarm_down"
  type        = string
}


variable "Greenalytics_elb" {
  description = "elb"
  type        = string
}


variable "allow_http" {
  description = "allow_http"
  type        = string
}



