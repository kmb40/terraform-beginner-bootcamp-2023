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
