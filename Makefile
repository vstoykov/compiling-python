NAME = vstoykov/compiling-python
VERSION = latest

.PHONY: build no-cache

build:
	docker build -t $(NAME):$(VERSION) .

no-cache:
	docker build --no-cache -t $(NAME):$(VERSION) .
