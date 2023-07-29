# Stage 1: Create a temporary image to build the Angular app
FROM node:16 AS build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build -- --configuration=production

# Stage 2: Create NGINX Server and Serve Angular Application
FROM nginx:alpine
COPY --from=build-stage /app/dist/angular-docker-swarm-demo /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
