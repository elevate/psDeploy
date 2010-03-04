
<#
.Synopsis
Creates a new network drive
#>
function New-NetworkDrive
{
    param
    (
        $Unc = $(throw "You must specify a UNC path to mount"),
        $Letter = $(throw "You must specify a drive letter")
    )
    
    $network = New-Object -ComObject WScript.Network
    $network.MapNetworkDrive("$Letter:", $Unc)
    
    Write-Output "Created new network drive $Letter: = $Unc"
}

