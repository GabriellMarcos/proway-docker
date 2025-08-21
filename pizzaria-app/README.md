Pizza App — Auto Deploy
Overview

This repository contains a simple Pizza App and an auto-deploy script (deploy_pizzaria.sh) that installs requirements, pulls the repo, and deploys the app via Docker Compose. The script is intended to run on any Linux server and keep the application updated with the GitHub repository.

Ports

Frontend: 8080

Backend: 5001

Features

Installs required packages (Docker, Docker Compose, Git) if missing.

Performs git clone or git pull to update code.

Rebuilds and deploys containers with docker-compose up --build -d.

Ensures script is executable (chmod +x).

Optionally installs a cron job to run the script every 5 minutes (auto-update).

Logs are optionally written to /var/log/deploy_pizzaria.log (if configured).

Files

deploy_pizzaria.sh — the deploy script (make sure it is at proway-docker/pizzaria-app/deploy_pizzaria.sh)

docker-compose.yml — compose file for the app (frontend / backend)

Frontend and backend application folders

Usage
1) Clone repository (on target server)
git clone https://github.com/GabriellMarcos/proway-docker.git
cd proway-docker/pizzaria-app

2) Make script executable (first time only)

If you prefer to make it executable manually:

chmod +x deploy_pizzaria.sh


Note: the script tries to ensure it is executable by running chmod +x "$0" at the start, so you can also run it once with bash without manual chmod.

3) Run deploy script (first run)
# run with bash (works even if not executable yet)
bash deploy_pizzaria.sh

# or if executable
./deploy_pizzaria.sh


The script will:

update the system packages,

install Docker / Docker Compose / Git if necessary,

clone or pull this repo,

rebuild and start the containers,

print docker ps output.

4) (Optional) Install cron to auto-run every 5 minutes

You can allow the script to add itself to crontab automatically if it contains the cron snippet. Or add it manually:

# edit crontab for the current user
crontab -e


Add the line (adjust path if needed, use the absolute path to the script):

*/5 * * * * bash /home/youruser/proway-docker/pizzaria-app/deploy_pizzaria.sh >> /var/log/deploy_pizzaria.log 2>&1


This will run the deploy script every 5 minutes and append logs to /var/log/deploy_pizzaria.log.

How to test the deployment

Check running containers:

docker ps


Test frontend in a browser or curl:

# from the server:
curl -I http://localhost:8080

# from another machine:
curl -I http://<server-ip>:8080


Test backend:

curl -I http://localhost:5001


Check logs if something fails:

# Docker container logs
docker logs <container_name>

# Deploy script log (if using cron log)
sudo tail -n 200 /var/log/deploy_pizzaria.log

Submit to Classroom

Push the changes (README + script) to GitHub:

git add deploy_pizzaria.sh README.md
git commit -m "Add deploy script and README"
git push origin main


Copy repository URL (e.g. https://github.com/GabriellMarcos/proway-docker).

Open Google Classroom assignment → Add or create → Link → paste the GitHub repo URL → Turn in / Mark as done.

Notes / Considerations

The script uses docker-compose commands. If your server uses newer Docker Compose v2, docker compose (space) works as well; adjust if needed.

If you need immediate update on push (no 5-minute delay), consider setting up a webhook receiver (or GitHub Actions) to trigger the deploy script. For the course requirement, the cron-based auto-update is sufficient.

Ports are fixed to 8080 (frontend) and 5001 (backend) per assignment requirement.


# PENDENCIAS TÉCNICAS (JÁ FEITAS)
Prezado ilustre DevOps, Não consegui criar o DockerFile para o projeto backend, pode me ajudar?

Objetivos:
- Criar o Dockerfile para o projeto Backend 
- Usar imagem modelo python:3.9 ou python:3.9-slim
- Instalar os pacotes do python necessários dentro da imagem
- Expor porta 5000
- *O comando para executar é:* python app.py

Depois monta um docker-compose.yml ok? 


# Pizzaria App

Um sistema completo para gerenciamento de pizzaria com frontend em HTML/CSS/JavaScript e backend em Python/Flask, executando em containers Docker.

## Visão Geral

O Pizzaria App é uma aplicação web que permite aos clientes visualizar o cardápio de pizzas, adicionar itens ao carrinho e realizar pedidos. A aplicação é composta por:

- **Frontend**: Interface de usuário responsiva desenvolvida com HTML, CSS e JavaScript puro
- **Backend**: API RESTful desenvolvida com Python e Flask
- **Docker**: Containers para facilitar a implantação e execução do sistema

## Estrutura do Projeto

```
pizzaria-app/
├── frontend/                 # Aplicação frontend
│   ├── public/               # Arquivos estáticos
│   │   ├── index.html        # Página principal
│   │   └── images/           # Imagens das pizzas
│   └── Dockerfile            # Configuração do container frontend
├── backend/                  # API Flask
│   ├── app.py                # Aplicação principal
│   ├── requirements.txt      # Dependências Python
│   └── Dockerfile            # Configuração do container backend
└── docker-compose.yml        # Configuração dos serviços Docker
```

## Funcionalidades

### Frontend

- **Visualização do Cardápio**: Exibição de pizzas com imagens, descrições e preços
- **Carrinho de Compras**: Adição e remoção de itens com atualização dinâmica
- **Finalização de Pedido**: Envio do pedido para o backend
- **Interface Responsiva**: Design adaptável para diferentes dispositivos
- **Integração com API**: Comunicação com o backend para obter dados e enviar pedidos

### Backend

- **API RESTful**: Endpoints para gerenciamento de pizzas e pedidos
- **Dados Simulados**: Informações de pizzas e pedidos armazenados em memória
- **CORS Habilitado**: Permite requisições do frontend
- **Validação de Dados**: Verificação dos dados recebidos nas requisições

## Endpoints da API

### Pizzas

- `GET /api/pizzas`: Retorna a lista de todas as pizzas disponíveis
- `GET /api/pizzas/<id>`: Retorna os detalhes de uma pizza específica

### Pedidos

- `GET /api/pedidos`: Retorna a lista de todos os pedidos
- `POST /api/pedidos`: Cria um novo pedido
- `PUT /api/pedidos/<id>/status`: Atualiza o status de um pedido

## Requisitos

- Docker
- Docker Compose

## Executando o Projeto

1. Clone o repositório:

```bash
git clone <url-do-repositorio>
cd pizzaria-app
```

2. Execute o projeto com Docker Compose:

```bash
docker-compose up --build
```

3. Acesse o frontend em: http://localhost:8080
4. A API estará disponível em: http://localhost:5001

## Desenvolvimento

### Frontend

Para desenvolvimento local do frontend:

```bash
cd frontend
# Você pode usar qualquer servidor HTTP simples para servir os arquivos estáticos
# Por exemplo, com Python:
python -m http.server 8080
```

### Backend

Para desenvolvimento local do backend:

```bash
cd backend
pip install -r requirements.txt
python app.py
```

## Estrutura de Dados

### Pizza

```json
{
  "id": 1,
  "nome": "Margherita",
  "ingredientes": "Molho de tomate, mussarela, manjericão",
  "preco": 35.90,
  "imagem": "https://example.com/margherita.jpg"
}
```

### Pedido

```json
{
  "id": 1,
  "data": "2025-07-18 20:00:00",
  "itens": [
    {
      "pizza_id": 1,
      "quantidade": 2
    }
  ],
  "cliente": "Nome do Cliente",
  "endereco": "Endereço de Entrega",
  "telefone": "(99) 99999-9999",
  "status": "Recebido",
  "total": 71.80
}
```

## Configuração dos Containers

### Frontend (Nginx)

O frontend é servido por um servidor Nginx que também atua como proxy reverso para a API:

- Porta: 8080 (host) -> 80 (container)
- Configuração: Redireciona requisições para `/api` para o serviço backend

### Backend (Python/Flask)

O backend executa uma aplicação Flask:

- Porta: 5001 (host) -> 5000 (container)
- Ambiente: Desenvolvimento (debug ativado)
- Dependências: Flask, Flask-CORS, etc.

## Detalhes Técnicos

### Frontend

O frontend é uma aplicação web simples construída com HTML, CSS e JavaScript puro. Ele utiliza:

- **HTML5**: Para estruturar o conteúdo da página
- **CSS3**: Para estilização e layout responsivo
- **JavaScript (ES6+)**: Para interatividade e comunicação com a API
- **Fetch API**: Para realizar requisições HTTP ao backend
- **Nginx**: Como servidor web para servir os arquivos estáticos

#### Estrutura do Frontend

- **index.html**: Contém toda a estrutura da página, estilos CSS e código JavaScript
- **Estilo**: Definido diretamente no cabeçalho do HTML usando tags `<style>`
- **JavaScript**: Definido no final do HTML usando tags `<script>`

#### Fluxo de Dados no Frontend

1. Ao carregar a página, o JavaScript faz uma requisição para `/api/pizzas` para obter a lista de pizzas
2. As pizzas são renderizadas na página como cards com imagens, descrições e preços
3. O usuário pode adicionar pizzas ao carrinho, que é gerenciado pelo JavaScript no navegador
4. Ao finalizar o pedido, o JavaScript envia os dados do carrinho para `/api/pedidos` via POST

### Backend

O backend é uma API RESTful construída com Python e Flask. Ele utiliza:

- **Python 3.9**: Como linguagem de programação
- **Flask**: Como framework web
- **Flask-CORS**: Para habilitar CORS (Cross-Origin Resource Sharing)
- **JSON**: Para serialização e deserialização de dados

#### Estrutura do Backend

- **app.py**: Contém toda a lógica da aplicação, incluindo rotas, controladores e dados simulados
- **requirements.txt**: Lista as dependências Python necessárias

#### Fluxo de Dados no Backend

1. O servidor Flask recebe requisições HTTP dos clientes
2. As rotas definidas em `app.py` processam as requisições e retornam respostas
3. Os dados são armazenados em memória (variáveis `pizzas` e `pedidos`)
4. As respostas são enviadas como JSON para o cliente

### Docker

A aplicação é containerizada usando Docker e orquestrada com Docker Compose:

- **Dockerfile (Frontend)**: Define como construir a imagem do frontend usando Nginx
- **Dockerfile (Backend)**: Define como construir a imagem do backend usando Python
- **docker-compose.yml**: Define como os serviços devem ser executados e como se comunicam

#### Rede Docker

Os containers são conectados através de uma rede Docker chamada `pizzaria-network`, permitindo que eles se comuniquem usando os nomes dos serviços como hostnames (por exemplo, o frontend pode acessar o backend usando `http://backend:5000`).

## Personalização

### Adicionando Novas Pizzas

Para adicionar novas pizzas, edite o array `pizzas` no arquivo `backend/app.py`:

```python
pizzas = [
    {
        "id": 7,  # Use um ID único
        "nome": "Nova Pizza",
        "ingredientes": "Ingredientes da nova pizza",
        "preco": 39.90,
        "imagem": "URL da imagem da pizza"
    },
    # ...
]
```

### Modificando o Frontend

O frontend é construído com HTML, CSS e JavaScript puros, facilitando a personalização:

- Estilo: Edite as regras CSS no cabeçalho do arquivo `index.html`
- Comportamento: Modifique as funções JavaScript no final do arquivo `index.html`
- Estrutura: Altere a estrutura HTML conforme necessário

### Modificando o Backend

Para adicionar novas funcionalidades ao backend:

1. Adicione novas rotas no arquivo `app.py`
2. Implemente a lógica necessária
3. Atualize a documentação da API

## Considerações de Segurança

- A aplicação atual não implementa autenticação ou autorização
- Em um ambiente de produção, seria necessário adicionar:
  - Autenticação de usuários
  - Autorização baseada em funções
  - Validação mais rigorosa de entrada
  - HTTPS para criptografar as comunicações
  - Proteção contra ataques comuns (CSRF, XSS, etc.)

## Considerações de Produção

Para um ambiente de produção, considere:

1. Implementar um banco de dados persistente (como PostgreSQL ou MongoDB)
2. Adicionar autenticação e autorização
3. Configurar HTTPS
4. Implementar testes automatizados
5. Configurar CI/CD para implantação contínua
6. Otimizar as imagens Docker para produção
7. Implementar monitoramento e logging
8. Configurar backups regulares
9. Implementar cache para melhorar o desempenho
10. Configurar um balanceador de carga para alta disponibilidade

## Solução de Problemas

### Problemas Comuns

1. **O frontend não consegue acessar o backend**:
   - Verifique se ambos os containers estão em execução (`docker ps`)
   - Verifique se o backend está escutando na porta correta
   - Verifique se o proxy reverso no Nginx está configurado corretamente

2. **Erros ao construir as imagens Docker**:
   - Verifique se os Dockerfiles estão corretos
   - Verifique se todas as dependências estão listadas nos arquivos de requisitos

3. **Problemas de CORS**:
   - Verifique se o Flask-CORS está configurado corretamente no backend

### Logs

Para visualizar os logs dos containers:

```bash
# Logs do frontend
docker logs pizzaria-frontend

# Logs do backend
docker logs pizzaria-backend
```

## Licença

Este projeto está licenciado sob a licença MIT - veja o arquivo LICENSE para detalhes.
