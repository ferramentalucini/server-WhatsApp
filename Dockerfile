FROM node:18

# Install Chromium and dependencies
RUN apt-get update && apt-get install -y \
  wget \
  curl \
  gnupg \
  libxss1 \
  libappindicator3-1 \
  libasound2 \
  libatk-bridge2.0-0 \
  libatk1.0-0 \
  libcups2 \
  libdbus-1-3 \
  libgdk-pixbuf2.0-0 \
  libnspr4 \
  libnss3 \
  libxcomposite1 \
  libxdamage1 \
  libxrandr2 \
  libgbm1 \
  libgtk-3-0 \
  libxshmfence1 \
  fonts-liberation \
  xdg-utils \
  --no-install-recommends && \
  rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy project files
COPY package*.json ./
RUN npm install
COPY . .

# Start server
CMD ["npm", "start"]
