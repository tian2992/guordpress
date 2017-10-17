# Guordpress

Docker image to run a no-dependencies Wordpress + SQLite plugin on HHVM's official image.

## How to Use

***Very Important***: be sure to block access to /wp-content/database/.ht.sqlite. This contains all your blog's info.
Might be as simple as: ```location /wp-content/database/.ht.sqlite { return 404; }``` in your nginx site config. ***SRSLY***.

### Run from Dockerfile

This assumes you want to run it in port 8042, behind a reverse HTTP Proxy (nginx, etc). Adjust port accordingly.

```bash
$ git clone https://github.com/tian2992/guordpress.git
$ docker build -t="guordpress" .
$ docker run -d -p 8042:80 guordpress
```

A volume will be created, containing the Wordpress base dir, you can use this to copy files or extract from. ```/wp-content``` works as usual, you can upgrade, install themes, install plugins (with limitations), etc.

### Run from Dockerhub

tian2992/guordpress

## Perf

It's reasonably fast for small sites, mostly reads.

## About

For fun and for profit, instead of a full lamp stack, just the fun bits.

### Links to Stuff:

* Ofc, the OG: https://wordpress.org/
* HHVM, a Sensible PHP-like VM: http://hhvm.com/
* SQLite Integration plugin: thanks for the fish. https://wordpress.org/plugins/sqlite-integration/
* Inspiration / POC: https://github.com/dorwardv/nginx_hhvm_wordpress_sqlite
* Moar info: http://dogwood.skr.jp/wordpress/sqlite-integration/
