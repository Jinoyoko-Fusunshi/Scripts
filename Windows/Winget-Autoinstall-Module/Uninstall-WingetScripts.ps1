$powerShellModulesPath = "~\Documents\PowerShell\Modules"

$wingetAutoinstallPath = Join-Path -Path $powerShellModulesPath -ChildPath "./Winget-AutoInstall"
Remove-Item -Path $wingetAutoinstallPath -Force -Recurse