# MODX Backend Project
=====================

The Backend is backed out of MODX Revolution, a creative freedom CMF.
With the customization done it becomes a perfect CMS.
The workflow uses Gitify from modMore which is a CLI-App used
through CLI/SSH for transferring/migrating MODX DB-data.

> Abstract requirement:
This project uses premium plugins from modMore. To use their service-provider
we need to provide a `.modmore.com.key` file with api-credentials.

## Local Deployment 2.0
### Requirements
- Vagrant
- Ansible

### Setup
Run: 
```
./setup-local.sh
```

### Commands
To manually start the vm or bring it back up: 
`vagrant up`

Check status of machine: 
`vagrant status`

Update the box of the vm: 
`vagrant box update`

To log in to local server: 
`vagrant ssh`

Stop the machine:
`vagrant halt`

Destroy the machine:
`vagrant destroy`

Inside the machine you could need the following: 

- `sudo -su www-data php -d date.timezone=Europe/Berlin ./index.php --installmode=new`
- `sudo -su www-data php -d date.timezone=Europe/Berlin ./index.php --installmode=new --core_path=/path/to/core/ --config_key=config`
- `sudo -su www-data php -d date.timezone=Europe/Berlin ./index.php --installmode=upgrade`
- `mysqlshow --user=xvModxUser --password=xvModxPassword xvModxDatabase`


## Local & Remote Deployment 1.0
### Requirements
- Lamp/Xamp/Wamp setup
- Install Composer
- Install Gitify

### Backend Installation
Change into public directory:
`cd www`

Get the latest MODX:
```
Gitify modx:install
```

Get a specified MODX:
```
Gitify modx:install 2.5.6-pl -vvv
```

> Note:
Install used MODX version first and upgrade from there.

Build MODX Base:
```
Gitify package:install --all
```
```
Gitify build --force --no-backup
```

Secure MODX core:
```
mv core/ht.access core/.htaccess
```

Make writable directories:
```
chmod 777 assets
```
```
chmod 777 -R assets/components assets/image-cache core/cache core/components core/packages
```

Useful Gitify commands: 
- Gitify build
- Gitify backup filename
- Gitify extract
- Gitify restore

Shortcuts:
```
Gitify modx:install && Gitify package:install --all && Gitify build --no-backup
Gitify modx:install && Gitify package:install --all && Gitify build --no-backup --force
  
// Then again?
Gitify build --no-backup
  
Gitify modx:install
Gitify package:install --all
Gitify build --no-backup --force
Gitify build --no-backup
```


Directory-Overview
----
- **/** 
  :: Root / Configuration Files / Scripts
- **/\_backup** 
  :: Gitify Backup Directory
- **/\_data** 
  :: Gitify Object Directory
- **/\_server** 
  :: Ansible Directory for Vagrant VM
- **/www** 
  :: Webroot / MODX Directory (only necessary files get versioned/transferred) 

Written by Sebastian G. Marinescu 
