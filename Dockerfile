FROM node:14-alpine as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install -g @vue/cli
RUN npm install
COPY . .
RUN npm run build
# этап production (production-stage)
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
COPY ./.nginx/nginx.conf /etc/nginx/nginx.conf
ENV TZ: "Europe/Moscow"
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
