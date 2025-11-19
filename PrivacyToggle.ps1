$key = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\CentraStage"
$value = "DisplayVersion"

# Get installed version
$version = (Get-ItemProperty -Path $key -Name $value).$value

$path = "C:\Windows\System32\config\systemprofile\AppData\Local\CentraStage\CagService.exe_Url_nin2uaxj2lsg1o0rsz2amvmcciusvum4\"
$file = "\user.config"

$combo = "$($path)$($version)$($file)"

# Load the XML configuration
$xml = [xml](Get-Content $combo)

# Toggle PrivacyModeDelayedOn
$nodeDelayed = $xml.configuration.usersettings."CentraStage.Cag.Core.Settings".setting | Where-Object { $_.Name -eq 'PrivacyModeDelayedOn' }

If ($nodeDelayed.value -eq 'NotUsed') {
    $nodeDelayed.value = 'OnForToday'
} else {
    $nodeDelayed.value = 'NotUsed'
}

# Toggle PrivacyMode
$nodePrivacy = $xml.configuration.usersettings."CentraStage.Cag.Core.Settings".setting | Where-Object { $_.Name -eq 'PrivacyMode' }

If ($nodePrivacy.value -eq 'True') {
    $nodePrivacy.value = 'False'
} else {
    $nodePrivacy.value = 'True'
}

# Save the updated XML
$xml.Save($combo)
