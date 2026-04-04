# Gunakan base image puppeteer agar otomatis memiliki semua dependency OS untuk browser
FROM ghcr.io/puppeteer/puppeteer:latest

# Set environment agar Puppeteer menghindari instalasi ulang dan menggunakan Chrome dari image
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/google-chrome-stable

# Jalankan sebagai root untuk menginstal bash atau hal lainnya jika perlu, namun default puppeteer image user adalah ppter
WORKDIR /usr/src/app

COPY package*.json ./
RUN npm ci

COPY . .

# Pastikan user memilliki akses baca/tulis di folder aplikasi
USER root
RUN chown -R pptruser:pptruser /usr/src/app
USER pptruser

CMD ["npm", "start"]
