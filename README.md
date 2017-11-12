Запуск:

cd webmail/
docker build -t webmail .
docker run -t -d -p 80:80 -p 25:25 -p 143:143 -p 443:443 webmail

или

cd webmail/
docker-compose up -d
