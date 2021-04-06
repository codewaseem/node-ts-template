DOCKER_COMPOSE = docker-compose
DOCKER_EXEC = docker exec -it
LOG_TAIL = logs --tail=20 -f

help:
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

pull: ## pull the required images
	${DOCKER_COMPOSE} pull

build-dev: ## Builds the docker-image for development
	${DOCKER_COMPOSE} -f docker-compose.yml -f docker-compose.dev.yml build

dev: ## Run the development application in container 
	${DOCKER_COMPOSE}  -f docker-compose.yml -f docker-compose.dev.yml  up

build-test: ## Builds the docker image for testing
		${DOCKER_COMPOSE} -f docker-compose.yml -f docker-compose.test.yml build

test: ## Run tests in the container
		${DOCKER_COMPOSE} -f docker-compose.yml -f docker-compose.test.yml up

build-prod: ## builds the production image
	${DOCKER_COMPOSE} -f docker-compose.yml  build

run: ## Run the production application container
	${DOCKER_COMPOSE} -f docker-compose.yml  up -d

logs: ## Show logs
	${DOCKER_COMPOSE} ${LOG_TAIL}

start: ## Starts the application
	${DOCKER_COMPOSE} start

stop: ## Stops the application
	${DOCKER_COMPOSE} stop

down: ## Kill the application
	${DOCKER_COMPOSE} down

restart: ## Restarts the application
	${DOCKER_COMPOSE} restart

# destroy: ## Destroy the app, containers and images, except volumes
# 	${DOCKER_COMPOSE} down --rmi all


# 	docker image prune

# prune-all-images:
# 	docker image prune -a

# prune-containers:
# 	docker container prune

# prune-volumes:
# 	docker volume prune

# prune-networks:
# 	docker network prune

# prune-system:
# 	docker system prune

# destroy-all: ## Destroys everything with data - DANGER
# 	${DOCKER_COMPOSE} down --rmi all -v --remove-orphans