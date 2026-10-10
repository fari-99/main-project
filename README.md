# main-project
This project is the main of the project, has docker compose, setup env, global env, etc.

# Nginx Proxy Manager

Admin UI: `http://localhost:81`

- Email: `admin@test.com`
- Password: `password`

**Security note:** the password above is a weak placeholder. Change it to something stronger via the Admin UI (`Users` > edit user > `Change Password`) before relying on this for anything beyond local dev, and avoid committing real/production credentials to this file.

## Resetting the admin password

If you get locked out, reset the password directly in the container's sqlite database (there's no built-in CLI reset command):

1. Find the running container name: `docker ps --filter name=proxy-manager`
2. Exec into it and use its bundled `bcrypt` + `knex` to update the `auth` table:
    ```sh
    docker exec <container_name> sh -c "cd /app && node -e \"
    const bcrypt = require('bcrypt');
    const knex = require('knex')({client:'sqlite3', useNullAsDefault:true, connection:{filename:'/data/database.sqlite'}});
    (async () => {
      const hash = await bcrypt.hash('<new_password>', 13);
      await knex('user').where({id:1}).update({email:'<new_email>'});
      await knex('auth').where({user_id:1, type:'password'}).update({secret: hash, modified_on: knex.fn.now()});
      console.log('updated');
      process.exit(0);
    })().catch(e => { console.error(e); process.exit(1); });
    \""
    ```
3. Adjust `id:1` if resetting a different user (check with `knex('user').select('id','email')` first).
4. Verify by logging in, or via the API: `curl -X POST http://localhost:81/api/tokens -H "Content-Type: application/json" -d '{"identity":"<new_email>","secret":"<new_password>"}'`

# go-api RBAC (first-time setup)

go-api enforces permissions with Casbin on most modules. On a fresh install there are no users, roles or policies, so every gated route returns `403` until you seed them.

1. **Bootstrap**: either run the `rbac-seed` command (creates the `admin` role, an allow-all policy and a first admin user), or start the API with `RBAC_ENABLED=false` in `workspace/go-api/.env` to skip permission checks while you set things up through the API. Login is still required, and the app logs a warning at boot.
2. **Restart the API** after seeding. Policies are cached in memory, so changes made outside the API (the seed command, direct SQL) are not picked up until restart.
3. **Re-enable RBAC**: set `RBAC_ENABLED=true` (or remove it) and restart. Never leave it `false` in a shared or production environment.

Other things to know: a user's roles are fixed at login (re-login after changing roles), users with no roles are always denied, and the policy subject format is `{RoleName}-{UserType}` such as `admin-Customer`.

The seed command, the full list of gated and ungated routes and the known issues are documented in [workspace/go-api/README.md](workspace/go-api/README.md#️-rbac--permissions).

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