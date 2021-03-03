# Required/supported versions
TERRAFORM_DOCS_VERSION := "0.11.2"
TFLINT_VERSION := "0.24.0"
TFLINT_AZURE_RULES_VERSION := "0.8.1"

# Check variables
CHECK_TERRAFORM_DOCS := $(shell terraform-docs --version | grep $(TERRAFORM_DOCS_VERSION) -o)
CHECK_TFLINT := $(shell tflint --version | grep TFLint | grep $(TFLINT_VERSION) -o)
CHECK_TFLINT_AZURE_RULES := $(shell tflint --version | grep azurerm | grep $(TFLINT_AZURE_RULES_VERSION) -o)

.terraform: .terraform-install .terraform-install-tflint .terraform-install-terraform-docs .terraform-install-tflint-azure-rules .terraform-setup-pre-commit

.terraform-install:
	@sudo apt-get install -y terraform

.terraform-install-tflint:
ifeq ($(CHECK_TFLINT),)
	@wget https://github.com/terraform-linters/tflint/releases/download/v$(TFLINT_VERSION)/tflint_linux_amd64.zip -O tflint.zip && unzip tflint.zip && rm tflint.zip && sudo mv tflint /usr/bin/
else
	@echo "-> tflint already in the expected version! Skipping..."
endif

.terraform-install-terraform-docs:
ifeq ($(CHECK_TERRAFORM_DOCS),)
	@GO111MODULE="on" go get github.com/terraform-docs/terraform-docs@v$(TERRAFORM_DOCS_VERSION)
else
	@echo "-> terraform-docs already in the expected version! Skipping..."
endif

.terraform-install-tflint-azure-rules:
ifeq ($(CHECK_TFLINT_AZURE_RULES),)
	@wget https://github.com/terraform-linters/tflint-ruleset-azurerm/releases/download/v$(TFLINT_AZURE_RULES_VERSION)/tflint-ruleset-azurerm_linux_amd64.zip -O ~/tflint-ruleset-azurerm_linux_amd64.zip
	@unzip ~/tflint-ruleset-azurerm_linux_amd64.zip -d ~/
	@mkdir -p ~/.tflint.d/plugins/
	@mv ~/tflint-ruleset-azurerm ~/.tflint.d/plugins
	@echo 'plugin "azurerm" {' > ~/.tflint.hcl
	@echo '	enabled = true' >> ~/.tflint.hcl
	@echo '}' >> ~/.tflint.hcl
	@rm -f ~/tflint-ruleset-azurerm_linux_amd64.zip
else
	@echo "-> tflint azurerm ruleset already in the expected version! Skipping..."
endif

.terraform-setup-pre-commit:
	@cp $(PRECOMMITS_DIR)pre-commit-config.yaml.terraform ../.pre-commit-config.yaml
