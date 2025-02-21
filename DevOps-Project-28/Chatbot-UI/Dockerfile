# Multi-stage build for optimized production image
FROM node:19-alpine AS build

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm ci --only=production

# Copy application code
COPY . .

# Build the application (assuming it's a React/Next.js app that needs building)
RUN npm run build

# Production image with Nginx for serving static files
FROM nginx:alpine

# Copy built files from build stage
COPY --from=build /app/build /usr/share/nginx/html

# Create custom nginx configuration
RUN echo 'server { \
    listen 3000; \
    server_name localhost; \
    \
    location / { \
        root /usr/share/nginx/html; \
        try_files $uri $uri/ /index.html; \
        add_header Cache-Control "no-cache, no-store, must-revalidate"; \
    } \
}' > /etc/nginx/conf.d/default.conf

# Expose the port your app runs on
EXPOSE 3000

# Healthcheck to verify service is responding
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:3000/ || exit 1
