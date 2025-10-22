PROJECT_NAME = pizzaria

default: run

run:
	docker-compose up -d

stop:
	docker-compose down

build:
	docker-compose build

clean:
	docker-compose down --rmi all --volumes

logs:
	docker-compose logs -f

status:
	docker-compose ps

# Terraform commands
deploy: checkov infra_provisioning

checkov:
	@echo "Executando Checkov..."
	checkov -d terraform/ --framework terraform

infra_provisioning:
	@echo "Provisionando infraestrutura..."
	cd terraform && terraform init
	cd terraform && terraform plan
	cd terraform && terraform apply -auto-approve

destroy:
	@echo "Destruindo infraestrutura..."
	cd terraform && terraform destroy -auto-approve
