FROM node:18-alpine

WORKDIR /app

# Copy package files
COPY package.json package-lock.json* ./

# Clear npm cache and install dependencies
RUN npm cache clean --force && npm install

# Copy app source code (excluding node_modules)
COPY index.js ./
COPY .env* ./

EXPOSE 5000

CMD ["npm", "start"] 