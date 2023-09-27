# Week 1

## Root Module Structure
```
PROJECT_ROOT
│
├── main.tf                 # everything else.
├── variables.tf            # stores the structure of input variables
├── terraform.tfvars        # the data of variables we want to load into our terraform project
├── providers.tf            # defined required providers and their configuration
├── outputs.tf              # stores our outputs
└── README.md               # required for root modules

```
**Note:** In the event that changes are made in the wrong branch outside of github, do the following:
- [ ] `git fetch` to grab current branch
- [ ] `git checkout <desired branch>` - to pull the desired branch where changes should go
- [ ] `git merge <incorrect branch>` merges the desired and incorrect branches together. Conflict resolution may be required.

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Steps 
1. Setup files with contents.
2. Set environmental variables at TF cloud for AWS access and secret keys, region, and user UUID.

## Terraform and Input Variables

### Terraform Cloud Variables

Variables Types:   
1. Environment Variables - those you would set in your bash terminal eg. AWS credentials   
2. Terraform Variables - those that you would normally set in your tfvars file   

**Note:** Terraform Cloud variables can be set to be "sensitive" so they are not shown visiblity in the UI.   

### Loading Terraform Input Variables

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)   

**Note:** We can use the `-var` flag to set an input variable or override a variable in the tfvars file eg. `terraform -var user_ud="my-user_id"`

### terraform.tvfars
This is the default file to load in terraform variables.  

## Configuration Drift

## What happens if we lose our state file?
* If a statefile is lost, you most likley have to tear down all your cloud infrastructure manually.
* `terraform import` won't work for all cloud resources. You need check the terraform providers documentation for which resources support import.

### Fix Missing Resources with Terraform Import
`terraform import aws_s3_bucket.bucket bucket-name`

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)
[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

### Fix Manual Configuration
* If a cloud resource is manually modified or deleted through ClickOps. 
* `Terraform plan` should put our infrastructure back into the expected state, fixing the Configuration Drift.

## Terraform Modules
### Terraform Module Structure
It is recommend to place modules in a `modules` directory when locally developing modules but you can name it whatever you like.

### Passing Input Variables
**Note:** Variables should be present in both the top level `variables.tf` and the `module/terrahouse_aws`
* Variables can be passed into the module.
* The module has to declare the terraform variables in its own `variables.tf` as follows:

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```

### Modules Sources
Using the source we can import the module from various places eg:
- locally
- Github
- Terraform Registry

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
}
```
[Modules Sources](https://developer.hashicorp.com/terraform/language/modules/sources)

## Working with Files in Terraform
**Note:** During `tf plan` in Gitpod, I encountered a path not found error for both public/index.html and public/error.html. I corrected this issue by shortening the path in `terraform.tfvars` from `index_html_filepath="/workspace/terraform-beginner-bootcamp-2023/public/index.html"` to `index_html_filepath="public/index.html"`. After which I was able to init, plan, and apply successfully.   

### Fileexists function
This is a built-in terraform function to check the existence of a file.
```tf
condition = fileexists(var.error_html_filepath)
```

https://developer.hashicorp.com/terraform/language/functions/fileexists

### Filemd5
https://developer.hashicorp.com/terraform/language/functions/filemd5

### Path Variable
In terraform there is a special variable called `path` that allows us to reference local paths:
- path.module = get the path for the current module
- path.root = get the path for the root module
[Special Path Variable](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)

resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "${path.root}/public/index.html"
}

## Terraform Locals
* Locals allows us to define local variables.
* It can be very useful when we need transform data into another format and have referenced a variable.

```tf
locals {
  s3_origin_id = "MyS3Origin"
}
```
[Local Values](https://developer.hashicorp.com/terraform/language/values/locals)

## Terraform Data Sources
* This allows us to source data from cloud resources.
* This is useful when we want to reference cloud resources without importing them.

```tf
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```
[Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)

## Working with JSON
JSON encode can be used to create the JSON policy inline in the hcl.

```tf
> jsonencode({"hello"="world"})
{"hello":"world"}
```

[jsonencode](https://developer.hashicorp.com/terraform/language/functions/jsonencode)

### Changing the Lifecycle of Resources
[Meta Arguments Lifcycle](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)

## Terraform Data
Plain data values such as Local Values and Input Variables don't have any side-effects to plan against and so they aren't valid in replace_triggered_by. You can use terraform_data's behavior of planning an action each time input changes to indirectly use a plain value to trigger replacement.

https://developer.hashicorp.com/terraform/language/resources/terraform-data

## Provisioners
Provisioners allow the execution of commands on compute instances eg. a AWS CLI command.
**Note:** Not recommended for use by Hashicorp because Configuration Management tools such as Ansible are a better fit, but the functionality exists.

[Provisioners](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax)

### Local-exec
This will execute command on the machine running the terraform commands eg. plan apply

```tf
resource "aws_instance" "web" {
  # ...

  provisioner "local-exec" {
    command = "echo The server's IP address is ${self.private_ip}"
  }
}
```

https://developer.hashicorp.com/terraform/language/resources/provisioners/local-exec

### Remote-exec
This will execute commands on a machine which you target. You will need to provide credentials such as ssh to get into the machine.

```tf
resource "aws_instance" "web" {
  # ...

  # Establishes connection to be used by all
  # generic remote provisioners (i.e. file/remote-exec)
  connection {
    type     = "ssh"
    user     = "root"
    password = var.root_password
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "puppet apply",
      "consul join ${aws_instance.web.private_ip}",
    ]
  }
}
```
https://developer.hashicorp.com/terraform/language/resources/provisioners/remote-exec

## Terraform Console
1. Reach the Terraform Console with `terraform console`.

## For Each Expression
For each allows us to enumerate complex data types

```sh
[for s in var.list : upper(s)]
```

Useful when creating multiples of a cloud resource and you want to reduce the amount of repetitive terraform code.

[For Each Expressions](https://developer.hashicorp.com/terraform/language/expressions/for)

**Note:** When engaging the ExampPro Platform validation tool - when it comes to permission, be sure to tear down any existing CloudFormation stacks, and Build a new stack using the provided AWS CLI commands provided. Failure to do so may result in multiple failures even if all elements of the infrastructure are correct.

## Misc
### FYI
1. https://terratowns.cloud/ has been launched.
2. Additional diagrams have been created and are stored @ https://lucid.app/lucidchart/e3f15b1a-2211-4ddb-8c95-f144c2504db4/edit?invitationId=inv_0873b3c6-c652-463f-9f2b-fa0f1b420823&page=0_0#
3. What is ClickOps (do this before IaC) - Manually clicking through an app to figure out how it works. https://bard.google.com/chat/ea912fda7a2193e1
4. UUID - Universal Unique Identifier for computer systems - # https://en.wikipedia.org/wiki/Universally_unique_identifier
5. Markdown TOC Generator - https://ecotrust-canada.github.io/markdown-toc/

### Live Stream Excercise (Optional) - Building Static web page and hosting on AWS S3
1. Built static web page at `/public/index.html`.
2. Install `npm install http-server`.
3. Launch with `http-server`.
4. Used Aws Cli to upload the static web page to S3 bucket.
5. Create a CloudFront Distribution.
6. Create an origin access control setting.
**Note:** This needs to be done during the CloudFront distribution setup
