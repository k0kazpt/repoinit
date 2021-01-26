# Default goal
#.DEFAULT_GOAL := help


# Repository metadata folder
REPO_METADATA := ../.repo_metadata/


# TODO: implement package manager detection
PKGMANINST := apt-get install -y
PKGMANUPD := apt-get update
COREPKGSTOINSTALL := python3 python3-pip unzip rename


# Requisites and versions
include requisites.mk


# Include specific dependencies
include repo_*.mk


# FULL SETUP
# Skip if already done!
ifeq ("$(wildcard $(REPO_METADATA).DONE)","")
# Based on what the desired repo type will be (input on start script)
# the target dependencies will dynamically adjust!
REPO_TYPE := $(shell ls $(REPO_METADATA).repo_* | head -1 | awk -F "/" '{print $$NF}' | sed 's/repo_//')
repository: .install-core-requisites $(REPO_TYPE) .repo-init .done
# If no repo metafile found, make default target will do nothing and print help message!
help: .help-message
else
already-done:
	@echo "!! First setup already done!"
	@echo "-> To reset setup, please rerun"
	@echo "-> ./first-setup/start.sh and"
	@echo "-> choose the Reset config option!"
	@echo ""
endif


# Default target! If any of the above conditions fails, this will be
# the default make target.
default: .help-message

# Help message
.help-message:
	@echo "!! DO NOT run make directly, unless you know what you are doing!"
	@echo "!! Run ./first-setup/start.sh instead!"
	@echo ""

# Reset config
.force-reset:
	@echo "-> Resetting repository metadata:"
	rm -f $(REPO_METADATA).DONE 2>/dev/null
	rm -f $(REPO_METADATA).repo_* 2>/dev/null
	@echo "-> To reconfigure, run ./first-setup/start.sh again!"


# CORE dependencies
.install-core-requisites: .install-base-packages .install-golang .install-pre-commit .install-commitizen .install-git-chlog

.install-base-packages:
	sudo $(PKGMANUPD)
	sudo $(PKGMANINST) $(COREPKGSTOINSTALL)
	# Update Python links to newer version
	sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 10 --slave /usr/bin/pip pip /usr/bin/pip3
	@update-alternatives --display python

.install-golang:
	@wget https://golang.org/dl/go$(GOLANG_VERSION).linux-amd64.tar.gz -O golang.tar.gz
	sudo tar -C /usr/local -xzf golang.tar.gz 2>/dev/null
	sudo [ ! -f /usr/bin/go ] && ln -s /usr/local/go/bin/go* /usr/bin/ || true
	@rm -f golang.tar.gz

.install-pre-commit:
	@pip install pre-commit

.install-commitizen:
	@pip install -U Commitizen

.install-git-chlog:
	@wget https://github.com/git-chglog/git-chglog/releases/download/v$(GIT_CHLOG_VERSION)/git-chglog_$(GIT_CHLOG_VERSION)_linux_amd64.tar.gz -O git-chglog.tar.gz
	@tar zxvf git-chglog.tar.gz git-chglog
	sudo mv git-chglog /usr/bin/
	@rm git-chglog.tar.gz


# Initialization commands
.repo-init:
	@mv README_$(REPO_TYPE).md ../README.md
	@pre-commit install
	@pre-commit install --hook-type commit-msg
	@rm -rf ../.chglog
	@git-chglog -init
	@mv .chglog ../


# Finish and cleanup
.done:
	@echo "-> Repo setup successfull!"
	@touch $(REPO_METADATA).DONE
