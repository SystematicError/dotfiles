This guide is mainly a reference for me to setup void linux and my dotfiles across different devices. This guide is heavily adapted to my needs specifically.

### Installer

Login as root and run `void-installer`. [Scale swap according to RAM size](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/managing_storage_devices/getting-started-with-swap_managing-storage-devices).

| Partition | Size      | Format | Mount point |
|-----------|-----------|--------|-------------|
| /dev/xyz1 | 100 MB    | vfat   | /boot/efi   |
| /dev/xyz2 | 12GB      | swap   | [SWAP]      |
| /dev/xyz3 | Remaining | ext4   | /           |


### Remove password for sudo

Run `sudo visudo` and change some lines to make it look like this:

```
# %wheel ALL=(ALL) ALL
%wheel ALL=(ALL) NOPASSWD: ALL
```


### Create swap

Run the following commands to setup swap, take note of the uuid provided by `mkswap`

```
mkswap /dev/xyz2
swapon /dev/xyz2
````

Add the follow line to `/etc/fstab`, replace `[uuid]` with the previously noted uui

```
UUID=[uuid] none swap defaults 0 0"
````

### Autoboot grub

Change this line in `/etc/default/grub`:

```
GRUB_TIMEOUT = 0
```

Run the `sudo update-grub` command to apply the config.


### Autologin to tty


### Setup github ssh key


### Install software


### Setup dotfiles

