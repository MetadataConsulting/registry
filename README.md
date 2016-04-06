# Metadata Registry

Metadata Registry is a tool which helps you manage metadata within your organization.

## Prerequisites

You have to have Docker installed to run Metadata Registry. Please, follow the instruction for your system - [OS X](https://docs.docker.com/mac/step_one/),
[Windows](https://docs.docker.com/windows/step_one/) or [Linux](https://docs.docker.com/linux/step_one/).

You need to know the hostname or IP of your Docker host before you launch Metadata Registry. We'll refer to these IP or hostname as `<METADATA HOST>` in the following instructions. If you know the hostname or IP of machine running Docker you can simply use it.
Otherwise you need to find out the IP and remember it for future reference.

### Getting IP Address with Docker Machine (OS X, Windows)

While running using Docker Machine on OS X or Windows you can obtain your Docker IP by running inside *Docker Quickstart Terminal*

```shell
docker-machine ip default
```

Where `default` is the name of your docker machine and also the name of the default docker machine which should be present after installation.

### Getting IP Address on Linux

There are serval ways how to find out your IP on Linux. If your machine is accessible from the external IP
you can get it with following command.

```shell
echo $(dig +short myip.opendns.com @resolver1.opendns.com)
```

If you only need IP on internal network use

```shell
echo $(ip route get 8.8.8.8 | head -1 | cut -d' ' -f8)
```

or

```shell
echo $(ip a s|sed -ne '/127.0.0.1/!{s/^[ \t]*inet[ \t]*\([0-9.]\+\)\/.*$/\1/p}')
```


## Running Metadata Registry

[Docker Compose](https://docs.docker.com/compose/) is preferred way how to run
Metadata Registry on your Docker instance. Docker Compose is installed
with Docker Toolbox for OS X. For installation on other systems, please, follow
the instructions at https://github.com/docker/compose/releases/latest.

You can either clone the Metadata Registry repository with Git

```shell
git clone https://github.com/MetadataRegistry/registry.git registry && cd registry
```

or download the latest release archive from https://github.com/MetadataRegistry/registry/releases/latest
and extract it.

Using terminal go into the registry folder (cloned or extracted) and run `./ip.sh`
command. When the command fails or if you want to set the hostname of the registry
yourself then edit the `ip.env` file manually. Replace `localhost` string with
the desired host or the `<METADATA HOST>` IP address obtained from the initial step.

User registration requires having mail server setup properly. Follow instruction in `mail.evn` file
to setup the mail server properly.

When the host for metadata registry is set you can run the docker compose command:

```shell
docker-compose up
```

This will start all the required services such as database inside Docker.
Starting up the catalogue takes about one or two minutes. After than you
will be able to navigate to `<METADATA HOST>` address in your favorite browser.

There are three default users with different roles initially (username/password)
  * user/user - regular read only user
  * curator/curator - metadata curator with ability to read, create and update data models
  * admin/admin - user with full admin access

<!--- ## Running against Existing Database --->
<!--- ## Discourse Integration --->
<!--- ## S3 Integration --->
<!--- ## OAuth 2.0 Integration --->
<!--- ## Further Customization using mc-config.groovy -->
<!--- ## Creating Custom Image using mc-config.groovy -->

## Deploying to Google Compute Engine

With Docker Machine you can create multiple machines which can point to other computers.
Docker Machine comes together with Docker Toolbox for OS X and Windows and you can easily
[install it on Linux as well](https://docs.docker.com/machine/install-machine/).
You can pick any of [available drivers](https://docs.docker.com/machine/drivers/) but
[Google Compute Engine Driver](https://docs.docker.com/machine/drivers/gce/) is preferred as
it is very generous on memory (3.75 GB of RAM per CPU instead of usual 1 GB per CPU).

Follow the instructions at https://docs.docker.com/machine/drivers/gce/ but use
`--google-machine-type n1-standard-2` while creating the new machine. We also assume
you call the machine `metadata-registry` in later instructions.
Created instance will have enough memory to run the metadata registry and will
cost you about $70 per month while running.

Run `docker-machine env metadata-registry` in the terminal and follow the instructions
printed. After that, you will be using the docker commands against this particular machine on Google Compute Engine.

Follow the instructions from [Running Metadata Registry](#Running_Metadata_Registry) as you would for a local machine.

Last thing is to allow port 80 in Firewall Rules. Replace the `<your project id>` placeholder
with your own Google project ID and open the URL in the browser.

```
https://console.developers.google.com/networking/firewalls/list?project=<your project id>
```

Click `Create a firewall rule` and create new rule with *Name* `http`,
*Source IP ranges* `0.0.0.0/0` and *Allowed protocols and ports* `tcp:80`.

After that you should be able to navigate to `<METADATA HOST>` in your browser
and see the application running.
