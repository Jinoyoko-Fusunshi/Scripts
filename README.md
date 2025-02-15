# Script Tool Modules

Here are some scripts to automate some manual tasks. The script modules functionality varies on the operating system and is designed to mostly work on the specific platform.

<table>
    <tr>
        <th>Module Name</td>
        <th>Platform</td>
        <th>Description</td>
    </tr>
    <tr>
        <td>Installations</td>
        <td>Linux</td>
        <td>Module for automated installation of linux programs. </td>
    </tr>
    <tr>
        <td>Winget Autoinstall</td>
        <td>Windows</td>
        <td>Module for providing a plain text file with listed package ids to install via the Winget CLI. </td>
    </tr>
</table>

<br>

To install a specific module switch to the platform directory, then to the module directory and start the installation script for each module you want to install.

**Installations module**
```PowerShell
.\Linux\Installation-Module\(Un)Install-InstallationScripts.ps1
```

**Winget Autoinstall module**
```PowerShell
.\Windows\Winget-Autoinstall-Module\(Un)Install-WingetScripts.ps1
```

To uninstall the script module activate the uninstall script.

<br>

## Installations Module

Each Script automates a installation for a single linux application.

### Requirements
- PowerShell Core
- Curl
- Gdebi 

### PowerShell Scripts

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

---

#### Install-Discord
```PowerShell
Install-Discord
```
Execute the script above and discord will be installed on debian systems. This action will ask for confirmation if you want to install the discord package and root access.

The command first fetches with curl the newest debian package and writes the output file to the download directory as `Discord.deb`. Afterwards gdebi will install the packge and the debian file gets removed.

---

#### Install-GrubTheme
```PowerShell
Install-GrubTheme -Source <selected grub theme tar file>
```

Execute the script above and the theme will be installed. This action will ask for root access.

The command first extracts the tar file into a directory at the same location. Afterwards the directory gets moved to the grub theme directory at `/boot/grub/themes`. When this operation is done, a sample grub config will be generated with the entry of the copied grub theme directory. This generated file content will then be written into the acutal grub config file replacing all its existing content in `/etc/default/grub`. After the config file was successfully generated, the grub configuration will be applied.

---

<br>

## Winget Autoinstall

Installs sequentially winget progam packages by the given package id of an existing plain text file.

### Requirements
- PowerShell
- Winget

### PowerShell Scripts

<table>
    <tr>
        <th>Name</td>
        <th>Description</td>
    </tr>
    <tr>
        <td>Winget-AutoInstall</td>
        <td>Script to install winget packages. </td>
    </tr>
</table>

---

#### Winget-AutoInstall
```PowerShell
Winget-AutoInstall -PackageSource <packge-file>
```
Execute the script with an existing plain text file and all listed entries will be iterated and installed via the Winget CLI. Name an extension of the file doesn't play a role. The importent thing is to list the package ids and line wise in the file.

**Exmaple package file:**
```
Microsoft.PowerShell
MartiCliment.UniGetUI
Valve.Steam
Discord.Discord
```