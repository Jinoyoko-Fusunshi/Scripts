$powerShellModulesPath = "~/.local/share/powershell/Modules"

$grubThemeInstallationPath = Join-Path -Path $powerShellModulesPath -ChildPath "./Install-GrubTheme"
Remove-Item -Path $grubThemeInstallationPath -Force -Recurse
