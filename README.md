# Dockerized Mattermost Server

If you visit [Deploy Mattermost on Docker](https://docs.mattermost.com/install/prod-docker.html)
you would see they didn't produce reliable and official solution for it and the community created 
version of the guide is using `docker-compose` and building the mattermost with it instead of creating an acceptable image. Therefore I decided to create my own image for personal uses.

At the end I will use `docker-compose` for deploying my image, but I
won't build it there. This deployment will only because I want to keep this
guide as simple as possible without concerns of creating
networks and connection containers manually.

## Configuration Settings
Based on [Configuration Settings](https://docs.mattermost.com/administration/config-settings.html)
You can rewrite default settings by environment variables:
1. Find the setting in `config.json`. In this case, ServiceSettings.SiteURL.
2. Add `MM_` to the beginning and convert all characters to uppercase and replace the `.` with `_`.
For example, `MM_SERVICESETTINGS_SITEURL`.

### Database
You have two main choice when it is about the database you want to use for Mattermost.
You only need to set below environment variables.
#### PostgreSQL
```yaml
environment:
  MM_SQLSETTINGS_DRIVERNAME: postgres
  MM_SQLSETTINGS_DATASOURCE: postgres://mattermost:password@mattermost.db:5432/mattermost?sslmode=disable&connect_timeout=10
```
#### MySQL (MariaDB)
```yaml
environment:
  MM_SQLSETTINGS_DRIVERNAME: mysql
  MM_SQLSETTINGS_DATASOURCE: mattermost:password@tcp(mattermost.db:3306)/mattermost?charset=utf8mb4,utf8&readTimeout=30s&writeTimeout=30s
```
## Sample Docker Compose YAML File
```yaml
version: "3.7"

services:
  mattermost.app:
    image: hamidyousefi/mattermost:5.22.1-rev1
    container_name: mattermost.app
    hostname: mattermost.app
    environment:
      MM_SQLSETTINGS_DRIVERNAME: postgres
      MM_SQLSETTINGS_DATASOURCE: postgres://mattermost:password@mattermost.db:5432/mattermost?sslmode=disable&connect_timeout=10
    ports:
      - 127.0.0.1:8065:8065
    depends_on:
      - mattermost.db
    restart: on-failure

  mattermost.db:
    image: postgres:12.2-alpine
    container_name: mattermost.db
    hostname: mattermost.db
    environment:
      POSTGRES_DB: mattermost
      POSTGRES_USER: mattermost
      POSTGRES_PASSWORD: password
    volumes:
      - /mnt/mattermost/db:/var/lib/postgresql/data
    restart: on-failure

networks:
  default:
    name: mattermost
    driver: bridge
```
