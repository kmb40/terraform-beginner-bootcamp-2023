# Week 0

## Environment Prep
### Gitpod - Cloud Development Environment

#### Terraform CLI - Installtion
**Objective:** Install Terraform CLI.
Problem
- Terraform cli installation fails to complete during launch.

Resolution

- Add current terraform cli install insctructions into an external script [`install_terraform_cli`](/bin/install_terraform_cli).   
**Note:** `init` runs the script during the initial workspace where as  `before` runs the script during every workspace instance.    

#### Set Environmental Variables
**Objective:** Set environmental variables.
1. Created documentation for environmental variables at `.env.example`
2. Set instance environmental variable for the workspace using `export PROJECT_ROOT=workspace/terraform-beginner-bootcamp-2023`.
3. Set permanent environmental variable for the workspace using `gp env PROJECT_ROOT=workspace/terraform-beginner-bootcamp-2023`.
4. Updated script to call environmental variable for the path at [./bin/install_terraform_cli](https://github.com/kmb40/terraform-beginner-bootcamp-2023/commit/c3f91b5859b0f9a9155bee648c1b3d6bc3464f92).

- To see all environmental variables, use `env`.
- To see all environmental associated with "ABC", use `env | grep ABC`.
- To view an environmental variable, use `echo $yourenvvarhere` e.g. echo $PROJECT_ROOT.

#### AWS CLI - Installtion
**Objective:** Install AWS CLI.
Problem
- AWS cli installation pauses and requests user feedback when existing AWS CLI files are found.

Resolution
1. Created script [`install_aws_cli`](/bin/install_aws_cli).
**Note:** You may need to create an AWS account (If required).

2. Check whether aws cli is installed by running:
```sh
aws sts get-caller-identity
```

If this command is successful, the following data structure should appear(x's used to conceal actual data):
```
{
    "UserId": "AIDA2WELSIAB32VXXXXXXX,
    "Account": "XXXXX2107779",
    "Arn": "arn:aws:iam::734732107779:user/<username here>"
}
```
3. Launch the Gitpod workspace to test that the AWS CLI loads without interruption.

### Terraform - Random Provider Init, Plan, Apply
**Objective:** Run init and set up a provider.    

####  Installed the Terraform random provider module. [Ref](https://registry.terraform.io/providers/hashicorp/random/latest/docs)
1. Updated existing `main.tf` with the following (obtained from the "use provider" dropdown):
```
terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

provider "random" {
  # Configuration options
}
```
**Note:** This file is now considered a root-level module.
**Note:** Confirm that the (git ignore)[/.gitignore] file is updated to prevent files from being pushed to github.   

2. Ran the terraform init command with `terraform init`.
    - This command initializes the directory and pulls down providers.
3. Ran the terraform plan command with `terraform plan`.
    - This will generate a changeset, about the state of your infrastructure and what will be changed.
4. Ran the terraform approve command with `terraform apply --auto--approve`.
    - **Note:** `--auto--approve` automates the prompt for a Yes or No approval at the command prompt.
5. A random bucket name should have been generated.

Resources:   
- Terraform Modules (collection of templates of terraform code, like a plugin) and Providers (integrated service providers).
    - https://registry.terraform.io/ 

### Create an S3 bucket 
**Objective:** Create an AWS S3 bucket with Terraform.

1. Run `terraform init` to setup and create the terraform folder.
2. Run `terraform apply --auto--approve` to create a random bucket name.
3. Update/Append `main.tf` file to include provider AWS using:
```tf
terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
    aws = {
      source = "hashicorp/aws"
      version = "5.16.2"
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
resource "random_string" "bucket_name" {
  lower = true
  upper = false
  length   = 32
  special  = false
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "example" {
  # Bucket Naming Rules
  #https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html?icmpid=docs_amazons3_console
  bucket = random_string.bucket_name.result
}
```
4. Run `terraform init` to set up and create the aws provider within the TerraForm folder.
5. Run `terraform plan`.
**Note:** Failures could be caused by environmental variables not being set in each CLI (e.g. terraform, AWS, etc).
6. Run `terraform apply`. An AWS s3 bucket should have been created with the `random_bucket_name` generated by Terraform.
7. Run `terraform destroy` to remove the s3 bucket.

### Terraform Backend Config
**Objective:** Configure Terraform Cloud.

**Note**
* Workspaces contain configurations, settings, and infrastructure state.
* Projects are a collection of Workspaces.

1. Launch Gitpod workspace.
2. To return to the previous state, run `terraform init` and then run `terraform apply --auto--approve`.
3. Launch Terraform at https://app.terraform.io/app/.
4. As a first-time user, creating a new project is necessary.
5. Create a CLI workspace.
6. After the CLI workspace has been created, copy and append the example code provided which should look like the following:
```
terraform {
  cloud {
    organization = "<your org here>"

    workspaces {
      name = "Terra-House"
    }
  }
  # existing content here if applicable
}
```
7. Run `terraform login`.
**Note:** If using Gitpod, you may be prompted to read and approve. If you are working locally you may not have this experience that is noted.
a. Then presented with a screen as seen in Fig. TerraForm Login Result.   
<img src="/assets/terra-login-2023-09-20_11-26-15.png" width=450>
<figcaption>TerraForm Login Result</figcaption>   
<br/><br/>

b. Press "p" for print and a new screen should appear as shown in Fig. TerraForm Login Print. Alternatively, you can visit https://app.terraform.io/app/settings/tokens?source=terraform-login    
<img src="/assets/terraform-login-click-2023-09-20_11-28-03.png" width=450>
<figcaption>TerraForm Login Print</figcaption>   
<br/><br/>

c. Click+CMD on the url to the right of "Document:" and you should be taken to the terraform workspace and presented with a token lifetime popup.   
d. Select, then create the token.   
e. Press 'q' to leave that screen.   
f. Create a file by running `touch /home/gitpod/.terraform.d/credentials.tfrc.json`.   
g. Run `open /home/gitpod/.terraform.d/credentials.tfrc.json` to open the file.   
h. Add the following to the file:   
```
{
    "credentials":{
        "app.terraform.io":{
            "token": "<your token here>"
        }
    }
}
```
i. Run `terraform init`.   
**Note:** If you are curious and ran `terraform plan`, you may have gotten an error related to AWS credentials. If so it may be due to missing environmental variables at Terraform. A solution to this would be to visit https://app.terraform.io/app/mayvik/workspaces/Terra-House/settings/general and set the "Default Execution Mode" to "local" instead of "remote".   
j. Run `terraform apply --auto--approve`

### Terraform Login Bashscript
**Objective:** Configure Gitpod to login to Terraform Cloud automatically.   
1. Generate an API token at TF - https://app.terraform.io/app/settings/tokens.
2. Create file `/bin/generate_tfrc_credentials` [Ref](/bin/generate_tfrc_credentials). Be sure to set permissions with `chmod u+x`.      
3. Set environmental variables for "TERRAFORM_CLOUD_TOKEN" for the API token in Gitpod (if applicable) using `export` and `gp env`.   
4. Test the success of the script by running `./bin/generate_tfrc_credentials`.   
5. Verify the results by running `cat /home/gitpod/.terraform.d/credentials.tfrc.json` to view the file.
6. Run `terraform init` to confirm there are no errors.
7. Add `source ./bin/generate_tfrc_credentials` to the existing `gitpod.yml`.   
8. This task should be completed.   

### Terraform Alias  
**Objective:** Configure Terraform alias in Gitpod to shorten commands syntax. 

#### Mac cli
1. Launch cli.   
2. Enter the following `open ~/.bash_profile`.   
3. A file named ".bash_profile /home/gitpod" should open in Gitpod. Append `alias tf="terraform"` to that file.
4. Create a new bash script name (`/bin/set_tf_alias`)[/bin/set_tf_alias] to set the new alias on future launches. And set permissions.
5. Update the gitpod.yml file for both terraform and aws with `source ./bin/set_tf_alias`.   
6. Commit changes and restart the Gitpod workspace to apply.
7. Run `tf` and the command line to test. If usage information is returned then the task is completed.

#### Gitpod
1. Launch Gitpod.   
2. Enter the following `open ~/.bash_profile`.   
3. A file named ".bash_profile should open. Append `alias tf="terraform"` to that file.
4. Update the .bash_profile in real-time with `source ~/.bash_profile`.   
7. Run `tf` and the command line to test. If usage information is returned then the task is completed.
