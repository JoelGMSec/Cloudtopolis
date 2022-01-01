[Console]::OutputEncoding = [System.Text.Encoding]::GetEncoding("utf-8") ; Set-StrictMode -Off
$ProgressPreference = "SilentlyContinue" ; $ErrorActionPreference = "SilentlyContinue" ; $localpath = $pwd
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
Start-Process powershell -ArgumentList "cd $localpath ; $PSCommandPath $args" -Verb RunAs ; exit }

# Design
$Host.UI.RawUI.WindowTitle = "Cloudtopolis v3.0 [Server] - by @JoelGMSec" ; $Host.UI.RawUI.BackgroundColor = 'Black'
Invoke-Expression (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/JoelGMSec/Cloudtopolis/master/Resources/Design/Disable-Close.ps1')
Invoke-Expression (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/JoelGMSec/Cloudtopolis/master/Resources/Design/CloudtopoliStyle.ps1')
(New-object System.net.webclient).DownloadFile("https://raw.githubusercontent.com/JoelGMSec/Cloudtopolis/master/Resources/Design/Set-ConsoleIcon.ps1","Set-ConsoleIcon.ps1")
(New-object System.net.webclient).DownloadFile("https://raw.githubusercontent.com/JoelGMSec/Cloudtopolis/master/Resources/Design/Cloudtopolis.ico","Cloudtopolis.ico")
.\Set-ConsoleIcon.ps1 $localpath\Cloudtopolis.ico ; del Set-ConsoleIcon.ps1,Cloudtopolis.ico 

# Banner
function Show-Banner { Clear-Host ; $Host.UI.RawUI.ForegroundColor = 'Blue'
    Write-Host
    Write-Host "   ____ _                 _ _                    _ _       "
    Write-Host "  / ___| | ___  _   _  __| | |_ ___  _ __   ___ | (_)___   "
    Write-Host " | |   | |/ _ \| | | |/ _' | __/ _ \| '_ \ / _ \| | / __|  "
    Write-Host " | |___| | (_) | |_| | (_| | || (_) | |_) | (_) | | \__ \  "
    Write-Host "  \____|_|\___/ \__,_|\__,_|\__\___/|  __/ \___/|_|_|___/  "
    Write-Host "                                    |_|                    "
    Write-Host
    Write-Host ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::" -ForegroundColor White
    Write-Host ":: " -ForegroundColor White -NoNewLine ; Write-Host "Created by @JoelGMSec " -ForegroundColor Blue -NoNewLine
    Write-Host ":: " -ForegroundColor White -NoNewLine ; Write-Host "https://darkbyte.net " -ForegroundColor Blue -NoNewLine
    Write-Host ":: " -ForegroundColor White -NoNewLine ; Write-Host "v3.0 " -ForegroundColor Blue -NoNewLine ; Write-Host "::" -ForegroundColor White
    Write-Host ":: " -ForegroundColor White -NoNewLine ; Write-Host "https://github.com/JoelGMSec/Cloudtopolis " -ForegroundColor Blue -NoNewLine
    Write-Host ":: " -ForegroundColor White -NoNewLine ; Write-Host "[Server]" -ForegroundColor Red -NoNewLine ; Write-Host " ::" -ForegroundColor White
    Write-Host ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::" -ForegroundColor White
    Write-Host  ; $Host.UI.RawUI.ForegroundColor = 'White'
}

# HTTPS Support & Proxy Aware
add-type @"
using System.Net ; using System.Security.Cryptography.X509Certificates ; public class TrustAllCertsPolicy : ICertificatePolicy {
public bool CheckValidationResult(ServicePoint srvPoint, X509Certificate certificate, WebRequest request, int certificateProblem) { return true; }}
"@ ; $AllProtocols = [System.Net.SecurityProtocolType]'Ssl3,Tls,Tls11,Tls12' ; [System.Net.ServicePointManager]::SecurityProtocol = $AllProtocols
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy
[System.Net.WebRequest]::DefaultWebProxy = [System.Net.WebRequest]::GetSystemWebProxy()
[System.Net.WebRequest]::DefaultWebProxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials

# Functions
function Check-Command {
    Param ($command)
    $oldPreference = $ErrorActionPreference
    $ErrorActionPreference = 'stop'
    try {if(Get-Command $command){RETURN $true}}
    Catch {RETURN $false}
    Finally {$ErrorActionPreference=$oldPreference}}

$GCloudbin = "C:\Program Files (x86)\Google\Cloud SDK\google-cloud-sdk\bin\gcloud.ps1"

function Check-Choco { $Global:Check1 = Check-Command choco ; sleep 1
    Write-Host "[+] Checking Chocolatey installation in your system.." -ForegroundColor Green
    if($Check1 -in 'True'){ Write-Host "Chocolatey is installed!" ; Write-Host }
    else { Write-Host ; Write-Host "[!] Chocolatey is not installed!" -ForegroundColor Red ; Write-Host
    Invoke-Expression (New-Object Net.WebClient).DownloadString('https://chocolatey.org/install.ps1') ; Write-Host }}

function Check-GCloud { $Global:Check2 = & $GCloudbin info | Select-String "Google Cloud SDK" ; sleep 1
    Write-Host "[+] Checking Google Cloud SDK installation.." -ForegroundColor Green
    if($Check2 -ne $null){ Write-Host "Google Cloud SDK is installed!" ; Write-Host }
    else { Write-Host ; Write-Host "[!] Google Cloud SDK is not installed!" -ForegroundColor Red ; Write-Host
    choco install gcloudsdk -f -r -x -y --ignore-checksums ; del "C:\users\public\desktop\Google*.lnk" ; Write-Host }}

function Check-GAuth { $Global:Check3 = & $GCloudbin config get-value account 2> $null ; sleep 1
    Write-Host "[+] Checking Google Cloud Auth configuration.." -ForegroundColor Green
    if($Check3 -ne $null){ Write-Host "Google Cloud Auth success!" ; Write-Host }
    else { Write-Host ; Write-Host "[!] Google Cloud Auth is not configured!" -ForegroundColor Red ; Write-Host
    $Host.UI.RawUI.ForegroundColor = 'White' ; & $GCloudbin init --skip-diagnostics }}

function Repair-Permissions { 
    $keyspath="$env:userprofile\.ssh"
    $localgroups = (net localgroup | findstr *).trim('*')
    & icacls $keyspath /c /t /inheritance:r
    & icacls $keyspath /c /t /remove $localgroups
    & icacls $keyspath /c /t /grant $env:username`:F }

function Run-Server {
    $Global:Check3 = & $GCloudbin config get-value account 2> $null ; sleep 1
    if($Check3 -ne $null){ Write-Host "[i] Cloudtopolis is ready to run!" -ForegroundColor Blue ; sleep 1
    $gcloudssh = (& $GCloudbin cloud-shell ssh --dry-run).split('') | Select-String '@' 2> $null
    $command = '"curl -sk https://raw.githubusercontent.com/JoelGMSec/Cloudtopolis/master/Cloudtopolis.sh | bash"' ; Repair-Permissions 2>&1> $null
    ssh -p 6000 -i "$home\.ssh\google_compute_engine" -o "TCPKeepAlive=yes" -o "StrictHostKeyChecking=no" -C -L 8000:localhost:8000 -4 $gcloudssh -t $command }
    else { Write-Host "[!] Exiting.." -ForegroundColor Red ; sleep 2 ; exit }}

# Main Function
Show-Banner ; Check-Choco ; Check-GCloud ; Check-GAuth ; Run-Server
