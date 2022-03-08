# Only Local Silverlight Reverse Proxy


## Pre-requisites

* Docker, can be any docker installation - Docker desktop, docker inside WSL2. Alternatively local **nginx** (version >= 1.20) can be installed on host


## Setup

Following steps are need to be done to setup reverse proxy using docker, in case of local installation of nginx exists most of steps kind of similar.

* Add 2 hostnames to hosts file (%systemroot%\System32\drivers\etc\hosts):
```bash
127.0.0.1 mun.localcombine.net per.localcombine.net
```
* Combine.Municipality.Silverlight.xap and Combine.Performer.Silverlight.xap are assumed to be located in some folders on local machine. In the example docker-compose.yml file these locations are mapped as volumes pointing to build output folders conatining .xap files and Combine.Classic folder (repository) is lying alongside the folder where compose file is located:
```yaml
volumes:
    - ../combine.classic/Combine.Municipality.Silverlight/Bin/Debug:/var/www/xap/mun
    - ../combine.classic/Combine.Performer.Silverlight/Bin/Debug:/var/www/xap/per
```
* Configure IE mode in Edge. There are 2 files provided Pulsen-Combine.reg and sites-dev.xml. 
The first one modifies registry keys and used by customer for configuration of Edge on client machines. Most importatnt key is:
```
"InternetExplorerIntegrationSiteList"="file://C:/userware-proxy/sites-dev.xml"
```
which points where enterprise mode site list is located - adjust it to location where sites-dev.xml is located!
After appliying keys from Pulsen-Combine.reg you can check if Edge has got configuration from sites-dev.xml by going to `edge://compat/enterprise`:

| Domain                            | Engine | Allow Redirects |
| --------------------------------- | ------ | --------------- |
| *://localcombine.net/classic      | IE11   | True            |
| *://localcombine.net/embedded     | IE11   | True            |
| *://localcombine.net/session/load | IE11   | True            |

## Runnig proxy

From the root of folder of this repository run following shell command: 
```bash
docker-compose -f "docker-compose.yml" up -d
```
**Note.** If you do any changes to Dockerfile or nginx configuration file you may need to run above command with `--build` argument to apply those changes in container.