FROM node:18

# Installa Chromium e dipendenze
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

# Imposta la cartella del progetto
WORKDIR /app

# Installa le dipendenze
COPY package*.json ./
RUN npm install

# Copia i file
COPY . .

# Avvia il server
CMD ["node", "index.js"]
