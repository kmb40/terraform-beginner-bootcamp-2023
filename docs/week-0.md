# Week 0

## Environment Prep
### Gitpod

Problem
- Terraform installation fails to complete during launch.

Resolution
- Add current terraform install insctructions into an external script [`install_terraform_cli`](/.bin/install_terraform_cli). 
**Note:** `init` runs the script during the initial workspace where as  `before` runs the script during every workspace instance.