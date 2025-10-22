cat > user_data.sh << 'EOF'
#!/bin/bash

# Log de início
exec > >(tee /var/log/user-data.log)
exec 2>&1

echo "=== Iniciando instalação da aplicação Pizzaria ==="

# Atualizar sistema
echo "Atualizando sistema..."
yum update -y

# Instalar Docker
echo "Instalando Docker..."
amazon-linux-extras install docker -y
systemctl start docker
systemctl enable docker

# Adicionar ec2-user ao grupo docker
usermod -aG docker ec2-user

# Instalar Docker Compose
echo "Instalando Docker Compose..."
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# Instalar Git e Make
echo "Instalando Git e Make..."
yum install git make -y

# Clonar repositório
echo "Clonando repositório..."
cd /home/ec2-user
git clone ${git_repo} repo-pizzaria

# Verificar se o clone funcionou
if [ ! -d "repo-pizzaria/pizzaria-app" ]; then
    echo "ERRO: Não foi possível clonar o repositório ou a pasta pizzaria-app não existe!"
    exit 1
fi

# Entrar na pasta do projeto
cd repo-pizzaria/pizzaria-app

# Dar permissões
echo "Ajustando permissões..."
chown -R ec2-user:ec2-user /home/ec2-user/repo-pizzaria

# Executar aplicação como ec2-user
echo "Iniciando aplicação com Docker Compose..."
sudo -u ec2-user /usr/local/bin/docker-compose up -d

# Aguardar containers subirem
sleep 10

# Verificar status
echo "=== Status dos containers ==="
docker-compose ps

# Log de conclusão
echo "=== Aplicação Pizzaria instalada com sucesso! ==="
date > /var/log/pizzaria-install-complete.log
EOF
