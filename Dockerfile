# Use a specific Node.js version instead of just "latest"
FROM node:18.19-alpine3.19 AS base

# Create a non-root user and group for the application
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app

# Copy package files
COPY package.json package-lock.json* ./

# Install only production dependencies with clean cache in same layer to reduce image size
RUN npm ci --only=production && \
    npm cache clean --force && \
    rm -rf /tmp/* /var/cache/apk/*

# Copy app source code (excluding node_modules)
COPY index.js ./

# Set correct ownership for application files
RUN chown -R appuser:appgroup /app

# Switch to non-root user
USER appuser

# Set NODE_ENV explicitly for better performance
ENV NODE_ENV=production \
    # Disable npm update notifications
    NPM_CONFIG_UPDATE_NOTIFIER=false \
    # Reduce Node.js memory usage
    NODE_OPTIONS="--max-old-space-size=256"

EXPOSE 5000

# Use direct command rather than npm to reduce layers and improve performance
CMD ["node", "index.js"]