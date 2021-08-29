# Specify a base image
FROM node:alpine
WORKDIR /usr/app

# Install some dependencies
# Copy from source to destination,./ specifies this project root dir
COPY ./package.json ./
RUN npm install
COPY ./ ./

# Default command
CMD ["npm","start"]

# Docker build and run

