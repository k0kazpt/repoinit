.generic: .generic-setup-pre-commit

.generic-setup-pre-commit:
	@cp $(PRECOMMITS_DIR)pre-commit-config.yaml.generic ../.pre-commit-config.yaml
