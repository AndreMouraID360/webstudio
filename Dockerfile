# Use a imagem base do Node.js
FROM node:20-alpine

# Instale o pnpm globalmente e o git
RUN npm install -g pnpm
RUN apk add --no-cache git

# Defina o diretório de trabalho principal
WORKDIR /app

# Copie todo o código-fonte do repositório para dentro do container
COPY . .

# Mude para o diretório do aplicativo "builder"
WORKDIR /app/apps/builder

# Instale as dependências do projeto usando pnpm
RUN pnpm install --frozen-lockfile

# Faça o build do projeto
RUN pnpm build

# Exponha a porta que o servidor de desenvolvimento usa
EXPOSE 5173

# Defina o comando final para iniciar o servidor
CMD ["pnpm", "run", "dev", "--host", "0.0.0.0"]
