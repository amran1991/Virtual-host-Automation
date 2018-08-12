# Virtual-host-Automation

Virtualhost Manage Script
===========

Bash Script to allow create or delete apache/nginx virtual hosts on Ubuntu & RHEL on a quick way.

## Installation ##

1. Download the script
2. Apply permission to execute:

```
$ chmod +x /path/to/virtualhost-apache-rhel.sh
```

```
$ chmod +x /path/to/virtualhost-apache-ubuntu.sh
```

```
$ chmod +x /path/to/virtualhost-nginx-ubuntu.sh
```


3. Optional: if you want to use the script globally, then you need to copy the file to your /usr/local/bin directory, is better
if you copy it without the .sh extension:

```bash
$ sudo cp /path/to/virtualhost-apache-ubuntu.sh /usr/local/bin/virtualhost-apache-ubuntu
```

### For Global Shortcut ###

```bash
$ cd /usr/local/bin
$ wget -O virtualhost-apache-rhel https://raw.githubusercontent.com/Imran1616/Virtual-host-Automation/master/virtualhost-apache-rhel.sh
$ chmod +x virtualhost-apache-rhel
$ wget -O virtualhost-nginx-ubuntu https://raw.githubusercontent.com/Imran1616/Virtual-host-Automation/master/virtualhost-nginx-ubuntu.sh
$ chmod +x virtualhost-nginx-ununtu
$ wget -O virtualhost-apache-ubuntu https://raw.githubusercontent.com/Imran1616/Virtual-host-Automation/master/virtualhost-apache-ubuntu.sh
$ chmod +x virtualhost-apache-ununtu
```

## Usage ##

Basic command line syntax:

```bash
$ sudo sh /path/to/virtualhost-apache-ubuntu.sh [create | delete] [domain] [optional host_dir]
```

With script installed on /usr/local/bin

```bash
$ sudo virtualhost-apache-ubuntu [create | delete] [domain] [optional host_dir]
```

### Examples ###

to create a new virtual host:

```bash
$ sudo virtualhost-apache-ubuntu create mysite.dev
```
to create a new virtual host with custom directory name:

```bash
$ sudo virtualhost-apache-ubuntu create anothersite.dev my_dir
```
to delete a virtual host

```bash
$ sudo virtualhost-apache-ubuntu delete mysite.dev
```

to delete a virtual host with custom directory name:

```
$ sudo virtualhost-apache-ubuntu delete anothersite.dev my_dir
```
### Localization

For Apache:

```bash
$ sudo cp /path/to/locale/<language>/virtualhost.mo /usr/share/locale/<language>/LC_MESSAGES/
```

For NGINX:

```bash
$ sudo cp /path/to/locale/<language>/virtualhost-nginx.mo /usr/share/locale/<language>/LC_MESSAGES/
```

For Apache-Rhel:

Basic command line syntax:

```bash
$ sudo sh /path/to/virtualhost-apache-rhel.sh wwwX.example.com 3
```

With script installed on /usr/local/bin

```bash
$ sudo virtualhost-apache-rhel wwwX.example.com 2
```

### Examples ###

to create a new virtual host:

```bash
$ sudo virtualhost-apache-rhel.sh wwwX.example.com 1
```

