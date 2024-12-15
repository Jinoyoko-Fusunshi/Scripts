function Install-GrubTheme() {
    param (
       [string]$Source
    )

    # Create extraction directory
    $parentDirectory = Split-Path $Source -Parent
    $themeDirectory = [System.IO.Path]::GetFileNameWithoutExtension($Source)
    $themePath = Join-Path -Path $parentDirectory -ChildPath $themeDirectory
    mkdir $themePath
    tar -xf $Source -C $themePath

    # Move extracted directory to the grub themes directory
    $grubThemeDirectory = "/boot/grub/themes"
    Move-Item -Path $themePath -Destination $grubThemeDirectory -Force
    $grubThemeDestinationDirectory = Join-Path -Path $grubThemeDirectory -ChildPath $themeDirectory
    $grubThemeFilePath = Join-Path -Path $grubThemeDestinationDirectory -ChildPath theme.txt

    # Grub placehodler config with entry for the new installed theme
    $grubTemplatePath = Join-Path -Path $PSScriptRoot -ChildPath "./grub-template.cfg"
    $grubTemplate = Get-Content $grubTemplatePath
    $grubThemeEntry = $grubTemplate + "`nGRUB_THEME=$grubThemeFilePath"

    # Write grub configuration in its config file
    $grubConfig = "/etc/default/grub"
    Write-Output($grubThemeEntry) > $grubConfig;

    # Update the grub configuration
    sudo update-grub

    if ($LastExitCode -eq 0) {
        Write-Output("Grub theme $themeDirectory was successfully installed!")
    }
}
