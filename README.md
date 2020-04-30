# Dockerized Mattermost Server Team Edition

If you visit [Deploy Mattermost on Docker](https://docs.mattermost.com/install/prod-docker.html)
you would see they didn't produce reliable and official solution for it and the community created 
version of the guide is using `docker-compose` and building the mattermost with it instead of creating an acceptable image. Therefore I decided to create my own image for personal uses.

At the end I will use `docker-compose` for deploying my image, but I
won't build it there. This deployment will only because I want to keep this
guide as simple as possible without concerns of creating
networks and connection containers manually.

## Database
You have two main choice when it is about the database you want to use for Mattermost. For know, I am only
maintained this image for using with PostgreSQL!

You only need to set related environment variables. You can see the list in next section.

## Environment Variables
### `DB_DRIVER`:
*Default*: `postgres`

It is only accessible option for know. I will try to add mysql to supported list as soon as I can.

### `DB_HOSTNAME`:
*Default*: `mattermost.db`

You may choose this one by your own decision. Personally I prefer to keep all the containers names and
hostnames in the way I can find it without any unnecessary complexity, therefore I suggest this pattern.

### `DB_PORT`:
*Default*: `5432`
PostgreSQL default port. I prefer to keep it that way.

### `DB_NAME`:
*Default*: `mattermost`

### `DB_USERNAME`:
*Default*: `mattermost`

### `DB_PASSWORD`:
*Default*: `mattermost`

It is better to change this value to something more complex.
