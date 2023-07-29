# Stage 1: Build Angular Application
FROM node:18.16.1 as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Create NGINX Server and Serve Angular Application
FROM nginx:alpine
COPY --from=build-stage /app/dist/angular-app /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
