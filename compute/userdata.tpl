<powershell>

# get parameters passed in by Terraform
$p_subnet = "${subnet}"
$p_region = "${region}"

# create log file in c:\Windows\temp
$filePath = $env:SystemRoot + "\Temp\" + (Get-Date).ToString("yyyy-MM-dd-hh-mm") + ".log"
New-Item $filePath -ItemType file

# Log all parameters passed in from Terraform
$lines = ""
$lines = $lines + ("subnet: {0}" -f $p_subnet)
Add-Content $filePath $lines
Add-Content $filePath  ("{0} region: {1}`n" -f (Get-Date -Format s), $p_region)

# set AWS default region
Set-DefaultAWSRegion -Region $p_region

# install MS SQL Server Management Studio (SSMS) - 650 MB! $env:TEMP = C:\Users\Administrator\AppData\Local\Temp\2
# Add-Content $filePath  ("{0} Downloading MS SQL Server Management Studio ..." -f (Get-Date -Format s))
# $InstallerSQL = $env:TEMP + “\SSMS-Setup-ENU.exe”
# Invoke-WebRequest “https://aka.ms/ssmsfullsetup" -OutFile $InstallerSQL
# Add-Content $filePath  ("{0} SSMS downloaded." -f (Get-Date -Format s))
# Add-Content $filePath  ("{0} Installing MS SQL Server Management Studio ..." -f (Get-Date -Format s))
# start $InstallerSQL /Quiet
# Remove-Item $InstallerSQL
# Add-Content $filePath  ("{0} ... SSMS installed." -f (Get-Date -Format s))

# It is faster to install SSMS with Chocolatery: 
Add-Content $filePath  ("{0} Installing Chocolatery ..." -f (Get-Date -Format s))
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) 
Add-Content $filePath  ("{0} ... Chocolatery installed." -f (Get-Date -Format s))
Add-Content $filePath  ("{0} Installing MS SQL Server Management Studio (SSMS) ..." -f (Get-Date -Format s))
choco install -y sql-server-management-studio 
Add-Content $filePath  ("{0} ... SSMS installed." -f (Get-Date -Format s))

</powershell>

# execute this user data only for the first launch, not for subsequent reboots!
<persist>false</persist>
