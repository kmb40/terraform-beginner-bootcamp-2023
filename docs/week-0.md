# Week 0

## Environment Prep
### Gitpod - Cloud Development Environment
Problem
- Terraform cli installation fails to complete during launch.

Resolution
- Add current terraform cli install insctructions into an external script [`install_terraform_cli`](/.bin/install_terraform_cli).   
**Note:** `init` runs the script during the initial workspace where as  `before` runs the script during every workspace instance.