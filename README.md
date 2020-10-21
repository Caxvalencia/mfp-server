# MoblieFirst Platform Server
Create an instance of mfp-server provided by IBM DevKit

## Based on
[openjdk:8-jdk-alpine3.9](https://hub.docker.com/_/openjdk/)

## Features
- Java 8
- Alpine 3.9
- Developer kit MFPF 8.0.0.0

## Usage

**Running:**
```bash
docker run --name mfp_server -it -d --rm -p 9080:9080 caxvalencia/mfp-server
```

**View message logs:**
```bash
docker exec -it --privileged mfp_server tail -F ./mfp-server/usr/servers/mfp/logs/messages.log
```

**View console logs:**
```bash
docker exec -it --privileged mfp_server tail -F ./mfp-server/usr/servers/mfp/logs/console.log
```

**Automation**
with alias:
```bash
alias mfp-server="docker run --name mfp_server -it -d --rm -p 9080:9080 caxvalencia/mfp-server"
```

> open http://localhost:9080/mfpconsole/ for view admin page running.

___

## Optional you can create Makefile:

```Makefile
MFP_SERVER=mfp_server

.PHONY: messages-mfp
messages-mfp:
	docker exec -it --privileged $(MFP_SERVER) tail -F ./mfp-server/usr/servers/mfp/logs/messages.log

.PHONY: console-mfp
console-mfp:
	docker exec -it --privileged $(MFP_SERVER) tail -F ./mfp-server/usr/servers/mfp/logs/console.log

.PHONY: up-mfp
up-mfp:
	docker run --name $(MFP_SERVER) -it -d -p 9080:9080 caxvalencia/mfp-server
	@echo " ---------------------------------------------------------------"
	@echo "|    MFP SERVER RUNNING IN http://localhost:9080/mfpconsole/    |"
	@echo " ---------------------------------------------------------------"

.PHONY: down-mfp
down-mfp:
	docker stop $(MFP_SERVER)
```

Now you can running `make up-mfp` for start and `make down-mfp` for stop server
