# Use Node.js official image as base
FROM node:latest

# Create app directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy app source code
COPY . .

# Expose port 8081
EXPOSE 8081

# Command to run the application
CMD [ "node", "server.js" ]
