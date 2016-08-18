# Docker image for Essi

[Essi](https://github.com/kak-tus/Essi) - automated perl to deb converter.

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
