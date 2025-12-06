BASHLY = docker run --rm -it --user $$(id -u):$$(id -g) --volume "$$PWD:/app" dannyben/bashly

.PHONY: generate

generate:
	$(BASHLY) generate
