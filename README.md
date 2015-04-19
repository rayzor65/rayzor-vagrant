Vagrant and Laravel Setup
========

Steps
- vagrant up
- Install mcrypt extension (required by laravel) if necessary
- composer install
- Make storage folder writeable if necessary
$ chmod -R 777 storage
- Add to your hosts
192.168.14.4 local.laravel.com
- go to http://local.laravel.com/ in your browser

And that's it!