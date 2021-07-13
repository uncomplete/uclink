Let your starting position determine the path you take more than the path that looks most 'desirable'.

## Linode

I use [Linode's][linode console] cloud hosting services.

Administrative setup commands when creating a new Linode:

* update system packages.  
CentOS: `yum update`  
Ubuntu: `sudo apt update && sudo apt upgrade`
* set the timezone for logs, etc.  
`timedatectl set-timezone 'America/New_York'`  
* add a limited user account - password not as important as root's  
check user defaults first : `useradd -D`.  
CentOS: `useradd rick && passwd rick`  
Ubuntu: `adduser rick && adduser rick sudo`.  
* ssh keys:
  * On the linode create a ssh directory and make it issuing user readable:  
  `mkdir -p ~/.ssh && sudo chmod -R 700 ~/.ssh/`
  * Add the public key to the authorized_keys file if it already exists, else create the file:  
  `scp ~/.ssh/id_rsa.pub example_user@203.0.113.10:~/.ssh/authorized_keys`
  * Test passwordless access by logging out and then back in as your new user.  
  * Disable root logins and password authentication by editing `/etc/ssh/sshd_config`.  

  ```
  # ...
  PermitRootLogin no
  PasswordAuthentication no
  ```
  * Restart the ssh daemon with systemd:  
  `sudo systemctl restart sshd`


## Development

We will use docker during development so as not to pollute our development environment with extraneous python packages and everything else as well as to maintain a reproducible development environment.

We start by creating a basic Hello World flask application with development Dockerfile on our local machine and then create a github repository with it.

### Git

Create a git repository and add it to our account.

In the top-level project directory run git init to create a .git directory.

`$> git init`

Create the repo and add it to your account.

`$> gh auth login --with-token < gh-patoken.txt`

Create the first commit.

```
$> git add README.md ...
$> git commit -m "initial commit"
```

## Deployment

We will deploy an app using [Flask][flasklink] as the web-app framework, [NGINX][nginxlink] as the web server and reverse proxy, [Gunicorn][gunicornlink] as the web server gateway interface (WSGI) application server, and [Supervisor][supervisorlink] for monitoring and auto-reloading Gunicorn should it go down.

Important configs:

* nginx: /etc/nginx/sites-enabled/flask_app  
server_name must be changed
* flask: /etc/config.json  
This has flask's config, not for source control


[linode console]: https://cloud.linode.com/linodes/27781186/networking
[flasklink]: https://blog.miguelgrinberg.com/post/the-flask-mega-tutorial-part-i-hello-world
[nginxlink]: https://www.linode.com/docs/web-servers/nginx/nginx-installation-and-basic-setup/
[gunicornlink]: https://gunicorn.org/
[supervisorlink]: http://supervisord.org/