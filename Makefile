#
# Variables
#
NAME=$(shell basename $(PWD))
FILTERED_NAME=$(shell echo $(NAME) | tr -d '-')
STARTER=go
PORT=8080
NAMESPACE=default
GIT_PROTO=git@github.com
ORG=myspotontheweb
STARTER_URL=$(GIT_PROTO):$(ORG)/helm-$(STARTER)-starter.git
STARTER_HOME=$(HELM_HOME)/starters/$(STARTER)

#
# Command targets (not dependent on files)
#
.PHONY: generate clean clean-files clean-starter clean-all

#
# Default target
#
generate: chart Dockerfile .travis.yml

#
# File oriented targets
#
$(STARTER_HOME):
	git clone $(STARTER_URL) $@
	@rm -rf $@/.git

chart: $(STARTER_HOME)
	@helm create --starter=$(STARTER) $(FILTERED_NAME)
	@mv $(FILTERED_NAME) chart
	@find chart -type f -exec sed "s/__NAME__/$(NAME)/g" {} --in-place \;
	@find chart -type f -exec sed "s/__PORT__/$(PORT)/g" {} --in-place \;
	@find chart -type f -exec sed "s/__NAMESPACE__/$(NAMESPACE)/g" {} --in-place \;
	@find chart -type f -exec sed "s/__FILTERED_NAME__/$(FILTERED_NAME)/g" {} --in-place \;

Dockerfile: chart/.ci/Dockerfile
	cp $< $@

.travis.yml: chart/.ci/.travis.yml
	cp $< $@

#
# Clean targets
#
clean-files:
	rm -rf chart
	rm -f Dockerfile
	rm -f .travis.yml

clean-starter:
	rm -rf $(STARTER_HOME)

clean-all: clean-files clean-starter

clean: clean-files

