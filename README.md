# ruby_chat
Simple Ruby api to handle three different entities. 
- Application
- Chat
- Messages

## How to install

To install you need docker to be installed on your machine. 
and execute the following commands:
```
docker-compose run web rails db:create
docker-compose run web rails db:migrate
docker-compose run web bundle install
docker compose build
docker compose up
```