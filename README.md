# Nix Darwin Modules

The repository contains some Nix Darwin modules.

## Install

- Go to your `darwin-configuration.nix` and add a additional import like:

```nix
imports = [
  <nix-darwin-modules>
];
```

- Add the `nix-channel` with `nix-channel --add https://github.com/shyim/nix-darwin-modules/archive/main.tar.gz nix-darwin-modules`
- Create a `/opt/nix` folder and make it writeable for you (used by the services to write)
  - `sudo mkdir /opt/nix`
  - `sudo chown $(whoami) /opt/nix`


## Caddy

Available Options:

```nix
# bool: Enables the Caddy service
services.caddy.enable

# string: Create a vhost 
services.caddy.virtualHosts.{httpHost}.extraConfig
```

Example:

Serves at localhost a specified document root

```nix
services.caddy.enable = true;
services.caddy.virtualHosts."http://localhost" = {
  extraConfig = ''
    root * /Users/shyim/Code/project
    file_server
  '';
};
```

## PHP-FPM

The PHP-FPM config is similar to the [Nixos one](https://nixos.wiki/wiki/PHP)

Example:


```nix
services.phpfpm.pools.php80 = {
  settings = {
    "pm" = "dynamic";
    "pm.max_children" = 32;
    "pm.max_requests" = 500;
    "pm.start_servers" = 2;
    "pm.min_spare_servers" = 2;
    "pm.max_spare_servers" = 5;
    "php_admin_value[error_log]" = "stderr";
    "php_admin_flag[log_errors]" = true;
    "catch_workers_output" = true;
  };
};


services.caddy.enable = true;
services.caddy.virtualHosts."http://sw6.dev.localhost" = {
  extraConfig = ''
    root * /Users/shyim/Code/project
    php_fastcgi unix/${config.services.phpfpm.pools.php80.socket}
    encode gzip
    file_server
  '';
};
```

## MySQL

The server starts without authentification, you should run `mysql_secure_installation` to set a root password

Available Options:

```nix
# bool: Enables the MySQL service
services.mysql.enable

# string|null: Bind to IP, default null
services.mysql.bind

# int: Port, default 3306
services.mysql.port

# int: Data dir, default /opt/nix/mysql
services.mysql.dataDir

# int: Socket file, default /tmp/mysql.sock
services.mysql.socketFile

# string: Define additional mysql server configs
services.mysql.extraOptions

# string: Define additional mysql server configs
services.mysql.extraClientOptions
```

Example:

```nix
services.mysql.enable = true;
services.mysql.extraOptions = ''
  sql-require-primary-key=ON
'';
```

## Elasticsearch

Available options:

```nix
# bool: Enables the Elasticsearch service
services.elasticsearch.enable

# package: Specifiy Elasticsearch package
services.elasticsearch.package

# string: overwrite Elasticsearch config
services.elasticsearch.extraConf
```

Example:

```nix
services.elasticsearch.enable = true;
services.elasticsearch.package = pkgs.elasticsearch7;
services.elasticsearch.extraConf = ''
  xpack.ml.enabled: false
'';
```

## Blackfire Agent

Available Options:

```nix
# bool: Enable Blackfire agent
services.blackfire.enable

# string: Blackfire server id
services.blackfire.server-id

# string: Blackfire server token
services.blackfire.server-token
```
