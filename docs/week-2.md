# Terraform Beginner Bootcamp 2023 - Week 2

**Objective:** Download, Install, and configure a mock web server. Create a custom TerraForm provider.

## Download mock web server.
1. Clone repo located at https://github.com/ExamProCo/terratowns_mock_server using the `HTTPS` option.
2. Run `git clone git@github.com:ExamProCo/terratowns_mock_server.git`.
4. That should creatre a new directory named `terratowns_mock_server`.`cd` into the terratowns_mock_server directory.
5. From that direcotry, remove the `.git` direcotry using `rm -rf .git`.
**Note:** The command line will show the branch as `main`. This is the main branch of the terratowns_mock_server repo that was cloned in step #2 and NOT the `main` branch of the terraform-beginner-bootcamp-2023. 
6. Visit `terratowns_mock_server/gitpod.yml` and cut all of the content minus `tasks:` and pasted it into the top-level `gitpod.yml` file.
7. Add `cd terratowns_mock_server` above `bundle install` and change `init` to `before`. The code snippet that is being pasted, should look like the following:
```
  - name: sinatra
    before: | 
      cd terratowns_mock_server
      bundle install
      bundle exec ruby server.rb 
```
8. Delete the `terratowns_mock_server/gitpod.yml` file.

## Working with Ruby
### Bundler
The primary way to install ruby packages (aka Gems) is using the Bundler package manager for ruby.

#### Install Gems
1. Create a Gemfile and define the gems in that file.

```rb
source "https://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'
```
2. Run the `bundle install` command to install the gems on the system globally (unlike nodejs which install packages in place in a folder called node_modules)
A Gemfile.lock should be created to lock down the gem versions used in this project.

#### Executing ruby scripts in the context of bundler
Run the `bundle exec` command to tell future ruby scripts to use the gems that you installed.  

### Sinatra
Sinatra is a micro web-framework for ruby to build web-apps. Its great for mock or development servers or for very simple projects.
It can be used to create a web-server in a single file.

https://sinatrarb.com/

## Terratowns Mock Server
### Running the web server
1. Run the web server by executing the following commands:
```rb
bundle install
bundle exec ruby server.rb
```

**Note:** All of the code for the server is stored in the `server.rb` file.

## Custom TerraForm Provider    
### Build a custom TerraForm provider for Terratowns Pt 1    
# Lesson - https://www.youtube.com/watch?v=pU8-AOhrIV8    
1. Create a new directory `terraform-provider-terratowns`.
2. In that directory, build the [`main.go`](/terraform-provider-terratowns/main.go) file which is a special file in Go, it's where the execution of the program starts.
3. **Important** In that directory, create a go.mod file by changing into the `terraform-provider-terratowns` directory and running, `go mod init terraform-provider-terratowns`.
4. A new file named `go.mod` should be created containing three lines as follows:
```
module terraform-provider-terratowns

go 1.21.1
```
5. Comment or remove those and replace with the following code.
```
module github.com/ExamProCo/terraform-provider-terratowns

go 1.20

replace github.com/ExamProCo/terraform-provider-terratowns => /workspace/terraform-beginner-bootcamp-2023/terraform-provider-terratowns

require (
	github.com/google/uuid v1.3.0
	github.com/hashicorp/terraform-plugin-sdk/v2 v2.29.0
)

require (
	github.com/agext/levenshtein v1.2.2 // indirect
	github.com/apparentlymart/go-textseg/v15 v15.0.0 // indirect
	github.com/fatih/color v1.13.0 // indirect
	github.com/golang/protobuf v1.5.3 // indirect
	github.com/google/go-cmp v0.5.9 // indirect
	github.com/hashicorp/errwrap v1.0.0 // indirect
	github.com/hashicorp/go-cty v1.4.1-0.20200414143053-d3edf31b6320 // indirect
	github.com/hashicorp/go-hclog v1.5.0 // indirect
	github.com/hashicorp/go-multierror v1.1.1 // indirect
	github.com/hashicorp/go-plugin v1.5.1 // indirect
	github.com/hashicorp/go-uuid v1.0.3 // indirect
	github.com/hashicorp/go-version v1.6.0 // indirect
	github.com/hashicorp/hcl/v2 v2.18.0 // indirect
	github.com/hashicorp/logutils v1.0.0 // indirect
	github.com/hashicorp/terraform-plugin-go v0.19.0 // indirect
	github.com/hashicorp/terraform-plugin-log v0.9.0 // indirect
	github.com/hashicorp/terraform-registry-address v0.2.2 // indirect
	github.com/hashicorp/terraform-svchost v0.1.1 // indirect
	github.com/hashicorp/yamux v0.0.0-20181012175058-2f1d1f20f75d // indirect
	github.com/mattn/go-colorable v0.1.12 // indirect
	github.com/mattn/go-isatty v0.0.14 // indirect
	github.com/mitchellh/copystructure v1.2.0 // indirect
	github.com/mitchellh/go-testing-interface v1.14.1 // indirect
	github.com/mitchellh/go-wordwrap v1.0.0 // indirect
	github.com/mitchellh/mapstructure v1.5.0 // indirect
	github.com/mitchellh/reflectwalk v1.0.2 // indirect
	github.com/oklog/run v1.0.0 // indirect
	github.com/vmihailenco/msgpack v4.0.4+incompatible // indirect
	github.com/vmihailenco/msgpack/v5 v5.3.5 // indirect
	github.com/vmihailenco/tagparser/v2 v2.0.0 // indirect
	github.com/zclconf/go-cty v1.14.0 // indirect
	golang.org/x/net v0.13.0 // indirect
	golang.org/x/sys v0.12.0 // indirect
	golang.org/x/text v0.13.0 // indirect
	google.golang.org/appengine v1.6.7 // indirect
	google.golang.org/genproto/googleapis/rpc v0.0.0-20230525234030-28d5490b6b19 // indirect
	google.golang.org/grpc v1.57.0 // indirect
	google.golang.org/protobuf v1.31.0 // indirect
)
```
6. Run `go mod tidy` at which point a `go.sum` file should be created AND a set of files should be downloaded.
7. Run `go build -o terraform-provider-terratowns_v1.0.0`.
8. A 20.87mb binary named `terraform-provider-terratowns_v1.0.0` should be created and you should be returned to the prompt.
9. Add the file to .gitignore to keep from sending it back to the Github repo by adding `terraform-provider-terratowns/terraform-provider-terratowns_v*`.

### Build a custom TerraForm provider for Terratowns Pt 2    
# Lesson - https://www.youtube.com/watch?v=PivvxGseOwk    
1. Update`gitpod.yml` with TF_LOG: Debug for extended log generation.
2. Set env var with `export TF_LOG=DEBUG`.t
3. Comment out all conents of `outputs.tf` in main directory.
4. Run `tf init`.