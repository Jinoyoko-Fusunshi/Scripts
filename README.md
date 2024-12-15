# Tooling scripts

Here are some scripts to automate some manual tasks, when working with the linux environment.

<br>

## Installation Modules

These are installation scripts to either install software applications or install configurations for existing software.

<table>
    <tr>
        <th>Name</td>
        <th>Description</td>
    </tr>
    <tr>
        <td>Install-Discord</td>
        <td>Command to fetch and install the latest discord debian package. </td>
    </tr>
    <tr>
        <td>Install-GrubTheme</td>
        <td>
            Command to install a tar file which contains a grub graphical theme and update the grub installation to the use the theme on the next boot. 
        </td>
    </tr>
</table>

### 
```PowerShell
Install-Discord
```
Execute the command above and discord will be installed on debian systems. This action will ask for confirmation if you want to install the discord package and root access.

The command first fetches with curl the newest debian package and writes the output file to the download directory as `Discord.deb`. Afterwards gdebi will install the packge and the debian file gets removed.

---

### Install-GrubTheme
```PowerShell
Install-GrubTheme -Source <selected grub theme tar fiel>
```

Execute the command above and the theme will be installed. This action will ask for root access.

The command first extracts the tar file into a directory at the same location. Afterwards the directory gets moved to the grub theme directory at `/boot/grub/themes`. When this operation is done, a sample grub config will be generated with the entry of the copied grub theme directory. This generated file content will then be written into the acutal grub config file replacing all its existing content in `/etc/default/grub`. After the config file was successfully generated, the grub configuration will be applied.