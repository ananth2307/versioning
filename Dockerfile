# Use an official Node.js runtime as the base image
FROM node:14

# Set the working directory in the container
WORKDIR /app

# Copy the package.json and package-lock.json to the container
COPY package*.json ./

# Install project dependencies
RUN npm install

# Copy your application source code into the container
COPY . .

# Expose a port (if your Node.js app listens on a specific port)
# EXPOSE 3000

# Define the command to start your application
CMD ["node", "index.js"]
