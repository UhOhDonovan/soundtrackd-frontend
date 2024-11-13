# Use an official Node.js runtime as a base image
FROM node:latest

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install project dependencies
RUN npm install

# Copy all files from your Vite project to the working directory
COPY . .

# Build the Vite project
RUN npm run build

# Expose the port your application listens on
EXPOSE 3000

# Define the command to run your application
CMD ["npm", "run", "preview"]
