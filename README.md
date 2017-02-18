# Docker image for Essi

[Essi](https://github.com/kak-tus/Essi) - automated perl to deb converter.

## How to use this image

```
$ docker run -d --name essi -p 9007:9007 -v /data/:/data/ kaktuss/essi
```

Then you can call api at http://localhost:9007/ or at http://host-ip:9007/. After build complete, *.deb and other
files will be placed in /data folder.

## Configuration

ESSI_DEB_PATH - used to set path to store deb packages.

This can be needed if we using (as example) Hashicorp Nomad. Nomad creates path, that can be used to communicate
between tasks in task groups. Example:

```
$ docker run -d --name essi -p 9007:9007 -e 'ESSI_DEB_PATH=/alloc/data' kaktuss/essi
```

## Github/gitlab/gogs webhooks API

### With clone support thru http

```
http://example-domain:9007/v2/build/github.json
http://example-domain:9007/v2/build/gitlab.json
http://example-domain:9007/v2/build/gogs.json
```

### With clone support thru ssh

```
http://example-domain:9007/v2/build/github-ssh.json
http://example-domain:9007/v2/build/gitlab-ssh.json
http://example-domain:9007/v2/build/gogs-ssh.json
```

If you want to use ssh clone support, you must:
1. Add ssh keys to user with no passphrase to ~/.ssh folder.
2. Add ssh config file to ~/.ssh folder

Example
```
#/home/www-data/.ssh/config
Host git.example.com
IdentityFile /home/www-data/.ssh/git.example.com
User git
Port 10022
```

3. Add yours servers to ~/.ssh/known_hosts file manually or using API method ssh-keyscan.

## Custom API

POST request

```
http://example-domain:9007/v2/build/custom.json
```

with parameter

```
repo=https://github.com/kak-tus/Essi.git
```

Curl example

```
curl -X POST 'http://example-domain:9007/v2/build/custom.json?repo=https://github.com/kak-tus/Essi.git'
```

## File API

Allow to download tar.gz file from cpan (or any other storage) and build it.

POST request

```
http://example-domain:9007/v2/build/file.json
```

with parameter

```
url=https://cpan.metacpan.org/authors/id/K/KA/KAKTUS/Geo-SypexGeo-0.6.tar.gz
```

Curl example

```
curl -X POST 'http://example-domain:9007/v2/build/file.json?url=https://cpan.metacpan.org/authors/id/K/KA/KAKTUS/Geo-SypexGeo-0.6.tar.gz'
```

## ssh-keyscan

When using Essi with ssh clone support you must add yours servers to ~/.ssh/known_hosts file. You can do it manually or using this API method.

POST request

```
http://example-domain:9007/v2/build/ssh-keyscan.json
```

with parameters

```
host=git.example.com (required)
port=10022 (optional, default 22)
```

Curl example

```
curl -X POST 'http://example-domain:9007/v2/build/ssh-keyscan.json?host=git.example.com&port=10022'
```

## Essi with nginx

You can use Essi directly, but the better solution in non-private environment: use nginx (+https) and proxy pass to application like

```
https://example-domain/essi/
```

to

```
http://127.0.0.1:9007/
```
