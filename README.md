# main-project
This project is the main of the project, has docker compose, setup env, global env, etc.

# Debugging Golang Service

Debugging golang is important, because we have many services using golang right now, so we need a fast way to debug it.

Note: 
- this can be used by GoLand and VSCode (currently only GoLand testable)
- **NEVER** merge `debug` branch to live branch (ex: `master`, `release-candidate`, and `staging`), because debugger open some of security risk.

## How to use (Local GoLand)

### On main-project (this repo)

1. if repo Nusantara branch `debugs` not yet merge to `master`, you can checkout there.
2. on `docker-compose.yml` pick container you want to debug and set
    1. dockerfile: Dockerfile to dockerfile: Dockerfile.debug
    2. on ports: add `-"40001:40000"` (NOTE: `40001` are port exposed to host **YOU CAN CHANGE THIS**, and `40000` are **default** port used for debugger to listen on container **DON’T CHANGE THIS!**)
3. rebuild the container (remember, because we use new docker file on docker compose, we need to rebuild the container)
4. check logs until it show message API server listening at: [::]:40000

### On GoLand

1. open your repo that you want to debug using GoLand
2. on `Run` tab, pick `Edit Configuration` to open `Run/Debug Configurations` windows
3. in `Run/Debug Configuration` windows, click `+` and add `Go Remote` to open new `Go Remote` configuration
4. fill `Name` with whatever you want
5. fill `Host` as `localhost`
6. fill `Port` as `40001` (note: you need to check with the docker compose ports you are using, if not the same it will not connect)
7. click `Apply`
8. click `Ok`
9. On Run tab, pick `Debug <your configuration name>`