# Developer note:
#
# Run `make` or `make help` to display a list of targets and help texts.
#
# If you add a new command, add a help text by adding a comment on the same
# line as the target name. You should use the following structure:
# `<target name>:  ## <help text>`
#
# See also:
# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html

.DEFAULT_GOAL := help

# Variables
TF_CMD := $(shell which terraform)
TOFU_CMD := $(shell which tofu)



# Makefile start
format: ## Formats code with `fmt -recursive`
	${TF_CMD} fmt -recursive

docs: ## Generate documentation for README.md
	terraform-docs markdown table --output-file README.md .

test: ## Runs tests
	${TF_CMD} test

generate-vars: ## Generates an example default.tfvars file
	terraform-docs tfvars hcl . | tee default.tfvars

help:
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage: make \033[36m<target>\033[0m\n\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

