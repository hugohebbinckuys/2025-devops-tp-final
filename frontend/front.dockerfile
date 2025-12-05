FROM node:20-alpine AS dev
WORKDIR /app
COPY package*.json /app/
RUN npm install
COPY . /app/
CMD [ "npm", "run", "dev" ]

FROM node:20-alpine AS builder
WORKDIR /app
COPY  package*.json /app/ 
RUN npm install
COPY . .
RUN npm run build

FROM nginx:alpine AS prod 
COPY --from=builder /app/dist /usr/share/nginx/html
CMD [ "nginx", "-g", "daemon off;" ]
# -g daemon off c pour mettre nginx en 1e plan sinon conteneur se stop


#commande pour build l'image de dev : 
    # docker build --target dev -t final-devops-front-dev-image -f front.dockerfile .
#commande pour build l'image de prod : 
    # docker build --target prod -t final-devops-front-prod-image .

#commande pour run le container de dev : 
    # docker run -p 5173:5173 --name final-devops-front-dev-container --rm final-devops-front-dev-image
#commande pour run le container de prod : 
    # docker run -p 80:80 --name final-devops-front-dev-container --rm final-devops-prod-image
