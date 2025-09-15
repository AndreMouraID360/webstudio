# Use a imagem base do Node.js
FROM node:20-alpine

# Instale o pnpm globalmente e o git
RUN npm install -g pnpm
RUN apk add --no-cache git

# Defina o diretório de trabalho principal
WORKDIR /app

# Copie todo o código-fonte do repositório para dentro do container
COPY . .

# Instale as dependências de todos os pacotes do monorepo
RUN pnpm install --frozen-lockfile

# Builda todos os pacotes do monorepo na ordem correta
RUN pnpm -r build

# Exponha a porta que o servidor de desenvolvimento usa
EXPOSE 5173

# Mude para o diretório do builder antes de iniciar
WORKDIR /app/apps/builder

# Defina o comando final para iniciar o servidor do builder
CMD ["pnpm", "run", "dev", "--host", "0.0.0.0"]
