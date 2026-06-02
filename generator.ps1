function Add-ModsFromFile {
    param (
        [string]$File
    )

    Get-Content $File | Where-Object { $_ -ne "" } | ForEach-Object {
        if ($_ -match "https://www\.curseforge\.com/minecraft/mc-mods/([a-zA-Z\-]+)/download/([0-9]+)") {
            packwiz curseforge add $Matches.1 --file-id $Matches.2
        } elseif ($_ -match "https://www\.curseforge\.com/minecraft/mc-mods/[a-zA-Z\-]+") {
            packwiz curseforge add $Matches.0
        } elseif ($_ -match "https://cdn\.modrinth\.com/data/([a-zA-Z0-9]+)/versions/([a-zA-Z0-9]+)/[a-zA-Z0-9\-.]+") {
            packwiz modrinth add --project-id $Matches.1 --version-id $Matches.2
        } else {
            Write-Host "not a recognized Modrinth/CurseForge mod download link: $_"
        }
    }
}

Add-ModsFromFile .\mods.txt
Add-ModsFromFile .\optional_mods.txt
