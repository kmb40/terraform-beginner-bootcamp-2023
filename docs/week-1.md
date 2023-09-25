# Week 1

## Building

### Misc
#### FYI
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
