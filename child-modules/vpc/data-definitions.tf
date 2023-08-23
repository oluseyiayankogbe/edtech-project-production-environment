#define the data for your amazon aws account ID. 
#This will call the account id from the console directly without exposing it in the code
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}


#define the data for your amazon ECR image

data "aws_ecr_image" "image" {
  repository_name = var.repository_name 
  image_tag       = var.image_tag 
}


#define the data for the ACM ARN

# Find a certificate issued by (not imported into) ACM
data "aws_acm_certificate" "amazon_issued" {
  domain      = "www.junoeducative.com"
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}

#define the data for your amazon aws hosted zone. 
#This will call the zone id from the console directly without exposing it in the code

data "aws_route53_zone" "route-53-zone" {
  name         = "junoeducative.com"
  
}

data "aws_secretsmanager_secret" "dbcreds" {
 name = "dbcreds"
}

data "aws_secretsmanager_secret_version" "secret_credentials" {
 secret_id = data.aws_secretsmanager_secret.dbcreds.id
}
