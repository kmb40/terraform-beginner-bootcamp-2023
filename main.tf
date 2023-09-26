## https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
#resource "aws_s3_bucket" "website_bucket" {
#  # Bucket Naming Rules
#  #https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html?icmpid=docs_amazons3_console
#  bucket = var.bucket_name
#
#  tags = {
#    UserUuid = var.user_uuid
#  }
#}

module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
  index_html_filepath = var.index_html_filepath
  error_html_filepath = var.error_html_filepath
}