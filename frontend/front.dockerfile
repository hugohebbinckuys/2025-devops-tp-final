FROM node:20-alpine AS dev
WORKDIR /app
COPY package*.json /app/
RUN npm install
COPY . /app/
CMD [ "npm", "run", "dev", "--", "--host", "0.0.0.0" ]



FROM node:20-bookworm AS test
WORKDIR /app
COPY package*.json ./
RUN npm install
RUN npx playwright install --with-deps chromium
COPY . .
CMD [ "npm", "test" ]


FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json /app/ 
RUN npm install
COPY . .
RUN npm run build


FROM nginx:alpine AS prod 
COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD [ "nginx", "-g", "daemon off;" ]
