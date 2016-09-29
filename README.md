# Metadata Registry

Metadata Registry is a tool which helps you manage metadata within your organization.

## Prerequisites

### Docker

You have to have Docker installed to run Metadata Registry. Please, follow the instruction for your system - [OS X](https://docs.docker.com/docker-for-mac/),
[Windows](https://docs.docker.com/docker-for-windows/) or [Linux](https://docs.docker.com/engine/getstarted/step_one/#docker-for-linux) if you don't.

### Docker Compose
You have to have Docker Compose installed to run Metadata Registry. Please, follow the [instruction for your system](https://docs.docker.com/compose/install/).

## Running Metadata Registry

You can either clone the Metadata Registry repository with Git

```shell
git clone https://github.com/MetadataRegistry/registry.git registry && cd registry
```

or download the latest release archive from https://github.com/MetadataRegistry/registry/releases/latest
and extract it.

Rename the file `docker.compose.override.example.yml` to `docker.compose.override.yml`.

```shell
mv docker-compose.override.example.yml docker-compose.override.yml 
```

Run the Metadata Registry with Docker Compose command:

```shell
docker-compose up -d
```

Now you can follow the server bootstrap:

```shell
docker-compose logs -f mc
```

When you see line `org.apache.catalina.startup.Catalina.start Server startup in XXX ms`, you can open your browser at
[http://localhost:11179](http://localhost:11179).

There are some default users with different roles initially (username/password)
  * user/user - regular read only user
  * curator/curator - metadata curator with ability to read, create and update data models
  * admin/admin - user with admin access to the application
  * supervisor/supervisor - user with supervisor access to the application (can reindex catalogue, see server stats)

## Customizaton _(optional)_
You can customize the application by editing the `docker-compose.override.yml` file. See the comments inside this file for the
reference.

## Application Upgrade _(optional)_
You can use `upgrade.sh` script to upgrade to latest version of the model catalogue.

```
./upgrade.sh
```

## Initializing the Database _(optional)_
Put your MySQL dump file inside the `data` folder of this repository if you want to preload the Metadata Registry with existing data.
If you preload the database you need to reindex the search engine by running _Reindex Catalogue_ action from the admin menu (cog).
