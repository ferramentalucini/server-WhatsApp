FROM node:20.18.1

# Installa Chromium e librerie necessarie + libvips per sharp
RUN apt-get update && apt-get install -y \
  chromium \
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
  libvips \
  libvips-dev \
  --no-install-recommends && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Evita che puppeteer scarichi Chromium (se non usato direttamente)
ENV PUPPETEER_SKIP_DOWNLOAD=true

# Imposta directory di lavoro
WORKDIR /app

# Copia i file package
COPY package*.json ./

# Installa le dipendenze
RUN npm install --verbose

# Copia il resto del progetto
COPY . .

# Avvia il server
CMD ["npm", "start"]
