# Use Node LTS
FROM node:20-alpine

# Set working directory inside container
WORKDIR /app

# Copy package.json and package-lock.json to install dependencies first (cache)
COPY package.json package-lock.json ./

# Install dependencies
RUN npm ci

# Copy the rest of the code
COPY . .

# Expose Vite dev server port
EXPOSE 5173

# Start Vite dev server, accessible from host machine
CMD ["npm", "run", "dev", "--", "--host"]