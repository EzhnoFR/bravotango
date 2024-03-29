FROM node:lts AS build
WORKDIR .
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx:alpine AS runtime
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=build /dist /usr/share/nginx/html
EXPOSE 8080
