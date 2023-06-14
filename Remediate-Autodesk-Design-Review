$requiredVersion = "14.0.7.205"
$hotfixURL = "https://help.autodesk.com/sfdcarticles/attachments/ADR2018SP7.msp"

# Check if Autodesk Design Review is installed
$installedSoftware = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -eq "Autodesk Design Review" }

if ($installedSoftware) {
    $installedVersion = $installedSoftware.Version

    # Check if the installed version is already patched
    if ($installedVersion -ge $requiredVersion) {
        # Autodesk Design Review is installed and version is already patched
        Write-Output "Already patched."
        exit 0
    }

    # Create a temporary directory to store the downloaded hotfix
    $tempDir = New-Item -ItemType Directory -Path "$env:TEMP\Hotfix"

    # Download the hotfix to the temporary directory
    $hotfixPath = Join-Path -Path $tempDir.FullName -ChildPath "hotfix.msp"

    try {
        $wc = New-Object System.Net.WebClient
        $wc.DownloadFile($hotfixURL, $hotfixPath)
    } catch {
        Write-Output "Failed to download."
        exit 1
    }

    # Install the hotfix with elevated privileges
    try {
        Start-Process -FilePath "msiexec.exe" -ArgumentList "/p `"$hotfixPath`" /qn" -Verb RunAs -Wait
        $exitCode = $LASTEXITCODE
        if ($exitCode -eq 0) {
            # Hotfix installation successful, delete the hotfix folder
            Remove-Item -Path "$env:TEMP\Hotfix" -Recurse -Force
            Write-Output "Hotfix installed."
        }
        exit $exitCode
    } catch {
        Write-Output "Failed to install."
        exit 1
    }
} else {
    # Autodesk Design Review is not installed
    Write-Output "Not installed."
    exit 1
}
