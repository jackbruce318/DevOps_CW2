# Use Node.js official image as base
FROM node:14-alpine

# Create app directory
WORKDIR /home/ubuntu/DevOps_CW2

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy app source code
COPY . .

# Expose port 9000
EXPOSE 9000

# Command to run the application
CMD [ "node", "server.js" ]
