# Terraform Module - Random 

terraform {
  cloud {
     organization = "mayvik"
 
     workspaces {
       name = "Terra-House"
     }
   }    
  
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.16.2"
    }
  }
}

  provider "random" {
    # Configuration options
  }
  
  provider "aws" {
  
  }