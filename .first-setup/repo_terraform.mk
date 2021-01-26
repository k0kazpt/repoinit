.terraform: .terraform-install .terraform-install-tflint .terraform-install-terraform-docs .terraform-install-tflint-azure-rules .terraform-setup-pre-commit

.terraform-install:
	@sudo apt-get install -y terraform

.terraform-install-tflint:
	@curl -L "$$(curl -Ls https://api.github.com/repos/terraform-linters/tflint/releases/latest | grep -o -E "https://.+?_linux_amd64.zip")" -o tflint.zip && unzip tflint.zip && rm tflint.zip && sudo mv tflint /usr/bin/

.terraform-install-terraform-docs:
	@GO111MODULE="on" go get github.com/terraform-docs/terraform-docs@v$(TERRAFORM_DOCS_VERSION)

.terraform-install-tflint-azure-rules:
	@wget https://github.com/terraform-linters/tflint-ruleset-azurerm/releases/download/v$(TFLINT_AZURE_RULES_VERSION)/tflint-ruleset-azurerm_linux_amd64.zip -O ~/tflint-ruleset-azurerm_linux_amd64.zip
	@unzip ~/tflint-ruleset-azurerm_linux_amd64.zip -d ~/
	@mkdir -p ~/.tflint.d/plugins/
	@mv ~/tflint-ruleset-azurerm ~/.tflint.d/plugins
	@echo 'plugin "azurerm" {' > ~/.tflint.hcl
	@echo '	enabled = true' >> ~/.tflint.hcl
	@echo '}' >> ~/.tflint.hcl
	@rm -f ~/tflint-ruleset-azurerm_linux_amd64.zip

.terraform-setup-pre-commit:
	@cp .pre-commit-config.yaml.terraform ../.pre-commit-config.yaml
