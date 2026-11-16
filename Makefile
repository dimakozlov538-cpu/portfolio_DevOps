IMAGE_NAME = portfolio
CONTAINER_NAME = portfolio-site
HOST_PORT = 8080
CONTAINER_PORT = 8080

.PHONY: build build-prod run stop restart logs status clean

build:
	docker build -t $(IMAGE_NAME) .

build-prod:
	docker buildx build --platform linux/amd64 -t $(IMAGE_NAME):prod .

run:
	docker run -d -p $(HOST_PORT):$(CONTAINER_PORT) --name $(CONTAINER_NAME) $(IMAGE_NAME)

stop:
	-docker stop $(CONTAINER_NAME)
	-docker rm $(CONTAINER_NAME)

restart: stop build run

logs:
	docker logs -f $(CONTAINER_NAME)

status:
	docker ps --filter "name=$(CONTAINER_NAME)"

clean: stop
	-docker rmi $(IMAGE_NAME)
