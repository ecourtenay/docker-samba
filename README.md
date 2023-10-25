# docker-samba
Docker container to run a Samba server - based on [original image from Peter Boyd][forked-from]

Image includes [wsdd][wsdd] which enables the Samba server to be found by Web Service Discovery Clients like Windows.


## Usage

```
docker run -t -d --rm \
  --name samba \
  -p "137:137/udp" \
  -p "138:138/udp" \
  -p "139:139" \
  -p "445:445" \
  -v <path/to/config>:/config \
  -v </path/to/share>:/shares \
  edcourtenay/docker-samba:latest
```
This will run a simple Samba server storing the generated smb.conf file at the given _config_ directory and sharing the single _share_ path.

## Parameters

* ```-p "137:137/udp"``` ```-p "138:138/udp"``` ```-p "139:139"``` ```-p "445:445"``` standard samba ports that need to be mapped for this to work.
* ```-v <path/to/config>:/config``` set the path where the samba config will be saved. This allows easy editing of the generated config.
* ```-v </path/to/share>:/shares``` one or more directory mappings that you want to share. Any shares set in the ```SHARES``` environment variable should map to directories made available through similar mappings.
* ```-e SERVERNAME``` set the hostname that will be used for samba shares (default = rancher-samba).
* ```-e USERNAME``` set the username that will be created as a samba user (default = samba).
* ```-e GROUP``` set the group that the ```USERNAME``` will belong to (default = samba).
* ```-e PASSWORD``` set the password that will be created for the samba user account (default = password).
* ```-e SHARES``` set this to a list of paths to create samba shares for (default = /shares).
 * example: ```-e SHARES "/shares/documents /shares/photos"``` would create two shares, sharing the contents of the specified paths. If /shares is a mounted volume then these paths would be shared from the host not the docker container.
* ```-e PUID``` set the user id to use for the samba user (default = 1100). This is used to help with file permissions.
* ```-e PGID``` set the group id to use for the samba user (default = 1100). This is used to help with file permissions.

[forked-from]: https://gitlab.com/MrFlibble/docker-samba
[wsdd]: https://github.com/christgau/wsdd
