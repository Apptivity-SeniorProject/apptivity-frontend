FROM node:20-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package files
COPY package.json package-lock.json* ./ 

# Install dependencies
RUN npm install

# Copy source code
COPY . .

# Build the web application
RUN npm run web:build

# --- Production Stage ---
FROM nginx:alpine

# Copy the built output to Nginx's html folder
# Expo web builds to dist/ by default or web-build/ depending on configuration
# We will copy from the web-build or dist directory (Expo SDK 50+ usually uses dist)
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose port (Internal to the container)
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
