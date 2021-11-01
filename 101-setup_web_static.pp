# Redo the task #0 but by using Puppet.
$config="# Default nginx configuration
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    add_header X-Served-By \$hostname;
    root /var/www/html;
    index index.html index.htm;
 
    location /hbnb_static {
        alias /data/web_static/current;
        index index.html index.htm;
    }
    location =/redirect_me {
        return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
    }
    error_page 404 /404.html;
}
"

exec { 'update packages':
    command => '/usr/bin/apt update'
}
-> package { 'nginx':
    ensure => 'installed'
}
-> exec { 'create shared folder':
    command => '/bin/mkdir -p /data/web_static/shared/'
}
-> exec { 'create releases folder':
    command => '/bin/mkdir -p /data/web_static/releases/test/'
}
-> file { 'create ndex.html':
    ensure  => 'present',
    name    => 'index.html',
    path    => '/data/web_static/releases/test/index.html',
    content => 'Holberton School for the win!\n'
}
-> exec { 'remove symbolic link':
    command => '/bin/rm -rf /data/web_static/current'
}
-> exec { 'creatensimbolic link for current release':
    command => '/bin/ln -s /data/web_static/releases/test/ /data/web_static/current'
}
-> exec { 'change owner':
    command => '/bin/chown -R ubuntu /data'
}
-> exec { 'change group':
    command => '/bin/chgrp -R ubuntu /data'
}
-> file { 'update nginx config':
    ensure  => 'present',
    name    => 'default',
    path    => '/etc/nginx/sites-available/default',
    content => $config
}
-> service { 'nginx':
    ensure => 'running'
}
