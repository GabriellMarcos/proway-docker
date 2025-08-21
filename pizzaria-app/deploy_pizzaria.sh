#!/bin/bash

# ===============================
# Pizzaria Auto-Deploy Script
# ===============================

# Garantir que o script tem permissão de execução
chmod +x "$0"

# Variáveis
REPO_URL="https://github.com/GabriellMarcos/proway-docker.git"
APP_DIR="$HOME/proway-docker/pizzaria-app"

# -------------------------------
# 1. Atualizar o sistema e instalar Docker e Git
# -------------------------------
echo "Updating system..."
sudo apt update -y && sudo apt upgrade -y

# Instalar pacotes se não existirem
if ! command -v docker &> /dev/null
then
    echo "Installing Docker..."
    sudo apt install -y docker.io
    sudo systemctl enable docker
    sudo systemctl start docker
fi

if ! command -v docker-compose &> /dev/null
then
    echo "Installing Docker Compose..."
    sudo apt install -y docker-compose
fi

if ! command -v git &> /dev/null
then
    echo "Installing Git..."
    sudo apt install -y git
fi

# -------------------------------
# 2. Clonar ou atualizar o repositório
# -------------------------------
if [ ! -d "$APP_DIR" ]; then
    echo "Cloning repository..."
    git clone $REPO_URL $APP_DIR
else
    echo "Updating repository..."
    cd $APP_DIR
    git pull origin main
fi

# -------------------------------
# 3. Subir containers SEMPRE
# -------------------------------
cd $APP_DIR
echo "Deploying containers..."
docker-compose down
docker-compose up --build -d

# -------------------------------
# 4. Exibir status
# -------------------------------
echo "Containers running:"
docker ps

