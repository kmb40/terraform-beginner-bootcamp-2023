# Week 0

## Environment Prep
### Gitpod - Cloud Development Environment

#### Terraform CLI - Installtion
**Objective:** Install Terraform CLI.
Problem
- Terraform cli installation fails to complete during launch.

Resolution
- Add current terraform cli install insctructions into an external script [`install_terraform_cli`](/.bin/install_terraform_cli).    
**Note:** `init` runs the script during the initial workspace where as  `before` runs the script during every workspace instance.      

#### Set Environmental Variables
**Objective:** Set environmental variables.
1. Created documentation for enviromental variables at `.env.example`
2. Set instance enviromental variable for the workspace using `export PROJECT_ROOT=workspace/terraform-beginner-bootcamp-2023`.
3. Set permananet enviromental variable for the workspace using `gp env PROJECT_ROOT=workspace/terraform-beginner-bootcamp-2023`.
4. Updated script to call enviromental variable for the path at [./bin/install_terraform_cli](/bin/install_terraform_cli).

- To see all environmental varibles, use `env`.
- To see all environmentals associated with "ABC", use `env | grep ABC`.
- To view an environmental variable, use `echo $yourenvvarhere` e.g. echo $PROJECT_ROOT.