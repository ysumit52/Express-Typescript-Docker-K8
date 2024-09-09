# Use the official Node.js image from the Docker Hub
FROM node:18

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./
COPY yarn.* ./

RUN if ! command -v yarn > /dev/null; then npm install -g yarn; fi

# # uninstall the current bcrypt modules
# RUN yarn remove bcrypt

# # install the bcrypt modules for the machine
# RUN yarn add bcrypt

# Install the application dependencies
RUN yarn install

# Copy the rest of the application code
COPY . .

# Expose the application port (adjust if needed)
EXPOSE 3000

# Command to run the application
ENV NODE_ENV development

CMD ["yarn", "dev"]
