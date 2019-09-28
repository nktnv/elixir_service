# Exservice

Welcome!

## Setup

```
 docker-compose up -d
```

```
 docker-compose run --rm web bundle
```

```
 docker-compose run --rm wsl mix local.hex --force
```

```
 docker-compose run --rm wsl mix local.rebar --force
```

```
 docker-compose run --rm wsl mix deps.get
```

```
 docker-compose stop
```

```
 docker-compose up -d
```


## Production running

# build a release
```
 docker-compose run --rm wsl bash -c "MIX_ENV=prod mix release"
```

# stop dev docker compose
```
 docker-compose down
```

# run prod docker compose
```
 docker-compose -f docker-compose.prod.yml up -d
```
