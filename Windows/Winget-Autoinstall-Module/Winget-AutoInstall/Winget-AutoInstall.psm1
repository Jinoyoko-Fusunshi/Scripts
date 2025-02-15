function Winget-AutoInstall() {
    param (
       [string]$PackageSource
    )

    Write-Output "Installing packages.."
    $configContent = Get-Content -Path $PackageSource

    foreach ($entry in $configContent) {
        Write-Output "Installing package by id '$entry'..."
        winget install $entry  
        Write-Output "Finished package installation."
    }
}