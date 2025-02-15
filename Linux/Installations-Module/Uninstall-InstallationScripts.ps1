$powerShellModulesPath = "~/.local/share/powershell/Modules"

$grubThemeInstallationPath = Join-Path -Path $powerShellModulesPath -ChildPath "./Install-GrubTheme"
Remove-Item -Path $grubThemeInstallationPath -Force -Recurse

$discordInstallationPath = Join-Path -Path $powerShellModulesPath -ChildPath "./Install-Discord"
Remove-Item -Path $discordInstallationPath -Force -Recurse
