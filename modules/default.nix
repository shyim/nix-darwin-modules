{ config, lib, pkgs, ... }:

{
  imports = [
    ./caddy
    ./blackfire
    ./elasticsearch
    ./mysql
    ./php-fpm
    ./rabbitmq
    ./mas
  ];
}
