# URL of the certificate
$certUrl = "https://github.com/sve0901/deploy-box/raw/main/SX-Virtual-Link.cer"

# Local path to save the downloaded certificate
$localCertPath = "$env:TEMP\SX-Virtual-Link.cer"

# Download the certificate
Invoke-WebRequest -Uri $certUrl -OutFile $localCertPath

# Load the certificate
$cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2
$cert.Import($localCertPath)

# Open the Trusted Publishers store on Local Machine
$store = New-Object System.Security.Cryptography.X509Certificates.X509Store("TrustedPublisher","LocalMachine")
$store.Open("ReadWrite")

# Add the certificate to the store
$store.Add($cert)

# Close the store
$store.Close()

Write-Host "Certificate installed successfully to Trusted Publishers for Local Computer."
