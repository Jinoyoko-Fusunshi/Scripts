function Install-Discord() {
    param (
       [string]$Source
    )

    # Fetch discord package from their download url
    $discordDownloadUrlDebian = "https://discord.com/api/download?platform=linux&format=deb"
    $downloadedFile = "~/Downloads/Discord.deb"

    curl -L -o $downloadedFile $discordDownloadUrlDebian
    sudo chmod 777 $downloadedFile
    sudo gdebi $downloadedFile

    if ($LastExitCode -eq 0) {
        Write-Output("Applicatoin $themeDirectory was successfully installed!")
    }

    sudo rm $downloadedFile
}
