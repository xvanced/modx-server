MODX Local Development Server
=====================
*virtual MODX development-environment cooked in **Vagrant**, 
<br>provisioned with **Ansible**, powered by **Gitify*** 

The workflow uses [Gitify](https://github.com/modmore/Gitify) from modmore which is a CLI-App for transferring/migrating MODX DB-data.

> Currently this server expects to be inside a Gitify project, like this: 

**Directory-Overview**

- **`/`** 
  :: Root / Configuration Files / Scripts
- **`/_backup`** 
  :: Gitify Backup Directory
- **`/_data`** 
  :: Gitify Object Directory
- **`/server`** :arrow_backward: <small>*(you are here)*</small>
  :: Directory for MODX Local Development Server
- **`/www`** 
  :: Webroot / MODX Directory <small>(only necessary files should get versioned/transferred)</small> 

> This means it expects a valid `.gitify` configuration-file inside `/www`

**What does it do?**
1. Creates a VM
    - Vagrant box based on ubuntu-16.04
2. Provisions VM
    - Installs and configures:
        - mysql
        - apache
        - php-fpm
        - phpmyadmin (*work-in-progress*)
        - composer
        - git
        - unzip
        - Gitify
3. Download and install newest OpenSSL
4. Creates self-signed certificate
5. Upgrade Apache2 to newest version
6. Enable Apache2-modules <small>(headers-module, expires-module, ssl-module, http2-module)</small>
7. Creates MySQL database and user
8. Installs MODX and Extras
9. Builds MODX `_data`
10. Opens the browser when done

## Setup
### Requirements
- Vagrant
- Ansible

### Installation
Add as sub-module to your project: 
```
git submodule add https://github.com/xvanced/modx-server server
cd server
```

Initialize: 
```
./init.sh
```

## Commands
### On the VM

To manually start the vm or bring it back up: 
`./vm-start.sh` or `vagrant up`

Stop the machine:
`./vm-halt.sh` or `vagrant halt`

Destroy the machine and delete MODX files:
`./vm-halt.sh`

Destroy only the machine:
`vagrant destroy`

Check status of machine: 
`vagrant status`

Update the box of the vm: 
`vagrant box update`


### Working inside the VM
1. SSH into the local server: 
`vagrant ssh`

2. Change into public directory:
`cd /var/www/html`

You should be inside your mapped web-root.

---

Inside the machine, if the setup fails, you might need one the following: 

- `sudo -su www-data php -d date.timezone=Europe/Berlin ./index.php --installmode=new`
- `sudo -su www-data php -d date.timezone=Europe/Berlin ./index.php --installmode=new --core_path=/path/to/core/ --config_key=config`
- `sudo -su www-data php -d date.timezone=Europe/Berlin ./index.php --installmode=upgrade`
- `mysqlshow --user=xvModxUser --password=xvModxPassword xvModxDatabase`

### Working with Gitify
Inside your public directory you can use Gitify for the follow tasks:

Get the latest MODX:
```
Gitify modx:install
```

Get a specified MODX:
```
Gitify modx:install 2.5.6-pl -vvv
```

Upgrade to a specified MODX:
```
Gitify modx:upgrade 2.6.0-pl
```

> Note:
Install MODX used in your project first and upgrade from there to every patch version until you reach the most current.


Install all packages specified in your `.gitify` config: 
```
Gitify package:install --all
```

Extract MODX Data:
```
Gitify extract
```

Build MODX Data:
```
Gitify build
```

Backup MODX Data:
```
Gitify backup filename
```

Restore MODX Data:
```
Gitify restore
```

One-Liner with options:
```
Gitify modx:install && Gitify package:install --all && Gitify build --no-backup --force
```

---

Written by Sebastian G. Marinescu 
