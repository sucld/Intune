$requiredVersion = "14.0.7.205"

# Check if Autodesk Design Review is installed and retrieve the version
$installedSoftware = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -eq "Autodesk Design Review" }

if ($installedSoftware) {
    $installedVersion = $installedSoftware.Version

    # Compare the installed version with the required version
    if ($installedVersion -eq $requiredVersion) {
        # Autodesk Design Review is installed and version is correct
        Write-Output "Version $requiredVersion installed."
        exit 0
    } else {
        # Autodesk Design Review is installed but version is different
        Write-Output "Hotfix missing."
        exit 1
    }
} else {
    # Autodesk Design Review is not installed
    Write-Output "Not installed."
    exit 1
}
