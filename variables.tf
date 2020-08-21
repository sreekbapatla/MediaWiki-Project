variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AMI_ID" {}
variable "AWS_REGION" {}
variable "INSTANCE_TYPE" {}
variable "AZS"{
    type    = list(string)
}
variable "AWS_CIDR_VPC" {}
variable "AWS_CIDR_SUBNET1" {}
variable "AWS_CIDR_SUBNET2" {}
variable "AWS_CIDR_SUBNET3" {}
variable "PATH_TO_PRIVATE_KEY" {}
variable "PATH_TO_PUBLIC_KEY" {}
variable "INSTANCE_USERNAME" {}