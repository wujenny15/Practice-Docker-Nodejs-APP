# Practice-Docker-Nodejs-APP
 
# Error Troubleshoot
## Error: npm: not found

```
docker build .
[+] Building 3.7s (6/6) FINISHED                                                                             
 => [internal] load build definition from Dockerfile                                                    0.0s
 => => transferring dockerfile: 160B                                                                    0.0s
 => [internal] load .dockerignore                                                                       0.0s
 => => transferring context: 2B                                                                         0.0s
 => [internal] load metadata for docker.io/library/alpine:latest                                        3.3s
 => [auth] library/alpine:pull token for registry-1.docker.io                                           0.0s
 => CACHED [1/2] FROM docker.io/library/alpine@sha256:e1c082e3d3c45cccac829840a25941e679c25d438cc8412c  0.0s
 => ERROR [2/2] RUN npm install                                                                         0.2s
------                                                                                                       
 > [2/2] RUN npm install:
#6 0.228 /bin/sh: npm: not found
------
executor failed running [/bin/sh -c npm install]: exit code: 127
```

To solve this error, we have two ways
* To find a base image which alredy has node npm pre-installed
* Install node

Go to hub.docker.com and Click 'Explore' and find relevant image. It has different tags so you can use it like this, andd the tag name

```

FROM node:alpine

```

## Error: npm ERR! Tracker idealTree already exists

```bash
docker build .
[+] Building 9.0s (5/5) FINISHED                                                                             
 => [internal] load build definition from Dockerfile                                                    0.0s
 => => transferring dockerfile: 165B                                                                    0.0s
 => [internal] load .dockerignore                                                                       0.0s
 => => transferring context: 2B                                                                         0.0s
 => [internal] load metadata for docker.io/library/node:alpine                                          2.2s
 => [1/2] FROM docker.io/library/node:alpine@sha256:1ee1478ef46a53fc0584729999a0570cf2fb174fbfe0370edb  5.5s
 => => resolve docker.io/library/node:alpine@sha256:1ee1478ef46a53fc0584729999a0570cf2fb174fbfe0370edb  0.0s
 => => sha256:65ccf08f9e0e15861e1d241ff90aeb293d86e080b68b5053b888ee38db887289 1.16kB / 1.16kB          0.0s
 => => sha256:d2adab47ce8f2b64403ec60f6d543d3b5cb8e114a28887f5a66fa4386938664a 6.53kB / 6.53kB          0.0s
 => => sha256:540db60ca9383eac9e418f78490994d0af424aab7bf6d0e47ac8ed4e2e9bcbba 2.81MB / 2.81MB          0.5s
 => => sha256:2ccfc847721bd5a61efe0179179ab9944724f4742ec73aed54e9cc9e440b15e0 35.46MB / 35.46MB        3.5s
 => => sha256:0fb557f738857421ec65b07c40ff8443578c7ffd7baffcff0182a4244890eb01 2.35MB / 2.35MB          1.4s
 => => sha256:1ee1478ef46a53fc0584729999a0570cf2fb174fbfe0370edbf09680b2378b56 1.43kB / 1.43kB          0.0s
 => => extracting sha256:540db60ca9383eac9e418f78490994d0af424aab7bf6d0e47ac8ed4e2e9bcbba               0.2s
 => => sha256:2816020507ac6142dd6ae22622faa1440017048a9ad17864ecf6c253b0449c28 281B / 281B              1.1s
 => => extracting sha256:2ccfc847721bd5a61efe0179179ab9944724f4742ec73aed54e9cc9e440b15e0               1.6s
 => => extracting sha256:0fb557f738857421ec65b07c40ff8443578c7ffd7baffcff0182a4244890eb01               0.1s
 => => extracting sha256:2816020507ac6142dd6ae22622faa1440017048a9ad17864ecf6c253b0449c28               0.0s
 => ERROR [2/2] RUN npm install                                                                         1.0s
------                                                                                                       
 > [2/2] RUN npm install:                                                                                    
#5 0.964 npm ERR! Tracker "idealTree" already exists                                                         
#5 0.974 
#5 0.974 npm ERR! A complete log of this run can be found in:
#5 0.974 npm ERR!     /root/.npm/_logs/2021-08-29T06_07_07_738Z-debug.log
```
Solution: add a WORKDIR right after the FROM instruction: 
```
FROM node:alpine
WORKDIR /usr/app
```

## Error: npm ERR! enoent ENOENT: no such file or directory, open /usr/app/package.json

```bash


❯ docker build .
[+] Building 4.1s (7/7) FINISHED                                                                                                                            
 => [internal] load build definition from Dockerfile                                                                                                   0.0s
 => => transferring dockerfile: 183B                                                                                                                   0.0s
 => [internal] load .dockerignore                                                                                                                      0.0s
 => => transferring context: 2B                                                                                                                        0.0s
 => [internal] load metadata for docker.io/library/node:alpine                                                                                         2.9s
 => [auth] library/node:pull token for registry-1.docker.io                                                                                            0.0s
 => CACHED [1/3] FROM docker.io/library/node:alpine@sha256:1ee1478ef46a53fc0584729999a0570cf2fb174fbfe0370edbf09680b2378b56                            0.0s
 => [2/3] WORKDIR /usr/app                                                                                                                             0.0s
 => ERROR [3/3] RUN npm install                                                                                                                        1.1s
------
 > [3/3] RUN npm install:
#6 1.033 npm ERR! code ENOENT
#6 1.033 npm ERR! syscall open
#6 1.034 npm ERR! path /usr/app/package.json
#6 1.034 npm ERR! errno -2
#6 1.035 npm ERR! enoent ENOENT: no such file or directory, open '/usr/app/package.json'
#6 1.035 npm ERR! enoent This is related to npm not being able to find a file.
#6 1.035 npm ERR! enoent 
#6 1.044 
#6 1.044 npm ERR! A complete log of this run can be found in:
#6 1.044 npm ERR!     /root/.npm/_logs/2021-08-29T06_14_23_963Z-debug.log
------
executor failed running [/bin/sh -c npm install]: exit code: 254
```

Solution

```
COPY ./package.json ./
RUN npm install
COPY ./ ./
```

# Build and Run

```
docker build -t 1744576063/nodejsapp .
docker run 1744576063/nodejsapp
docker run -p 8080:8080 1744576063/nodejsapp
```