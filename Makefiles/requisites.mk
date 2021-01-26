# Required/supported versions
GOLANG_VERSION := "1.15.7"
GIT_CHLOG_VERSION := "0.10.0"

# Check variables
CHECK_GOLANG := $(shell go version | grep $(GOLANG_VERSION) -o)
CHECK_GITCHGLOG := $(shell git-chglog --version | grep $(GIT_CHLOG_VERSION) -o)