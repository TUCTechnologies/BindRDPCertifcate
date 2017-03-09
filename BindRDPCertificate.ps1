# Get a reference to the config instance
$tsgs = gwmi -class "Win32_TSGeneralSetting" -Namespace root\cimv2\terminalservices -Filter "TerminalName='RDP-tcp'"

# Get a reference to switch certificate to put in place
$Subject = Read-Host "Please enter in the subject name of the certificate"

# Get the thumbprint of the SSL certificate for the subject name supplied
$Thumbprint = (gci -path cert:/LocalMachine/My | Where-Object {$_.Subject -like "*$Subject*"}).Thumbprint

# Set the new thumbprint value
swmi -path $tsgs.__path -argument @{SSLCertificateSHA1Hash="$Thumbprint"}
