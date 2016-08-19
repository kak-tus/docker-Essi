# Docker image for Essi

[Essi](https://github.com/kak-tus/Essi) - automated perl to deb converter.

## How to use this image

```
$ docker run -d --name essi -p 9007:9007 -v /data/:/data/ kaktuss/essi
```

Then you can call api at http://localhost:9007/ or at http://host-ip:9007/. After build complete, *.deb and other files will be placed in /data folder.

## Github/gitlab API

```
http://example-domain:9007/v1/build/github.json
```

or

```
http://example-domain:9007/v1/build/gitlab.json
```

But the better solution in non-private environment: use nginx (+https) and proxy pass to application like

```
https://example-domain/essi/
```

to

```
http://172.17.0.1:9007/
```

## Custom API

POST request

```
http://example-domain:9007/v1/build/github.json
```

with parameter

```
repo=https://github.com/kak-tus/Essi.git
```

Curl example

```
curl -X POST 'http://example-domain:9007/v1/build/custom.json?repo=https://github.com/kak-tus/Essi.git
```
