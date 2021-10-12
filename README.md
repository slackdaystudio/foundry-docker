# foundry-docker
This project was created to simplify a Foundry deployment with SSL enabled.  Ideally, just change the values
in `.env` file, drop the zipped foundry file into the `files` folder and do a `sudo docker-compose up --build -d`.

letsencrypt was used to generate valid SSL certificates.

## Prerequistes
Make sure these are installed on your server:

1. Docker
1. docker-compose (https://docs.docker.com/compose/install/)
1. A valid DNS entry that resolves to your hostname

## Setup
Setup is designed to be as straightforward as possible.

1. Drop your zipped Foundry file into the `files` directory
1. Modify you `.env` file

## Installing
1. Execute `sudo docker-compose up --build -d`
1. Visit `https://<YOUR_DOMAIN>/` to configure your Foundry

## PRs Welcome
Please help make this project better by submitting a PR.