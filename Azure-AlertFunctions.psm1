 <#
	.SYNOPSIS
	AzureAlerts.psm1 is a powershell module to work with Azure alerts.
	.DESCRIPTION
	AzureAlerts.psm1 is a powershell module to work with Azure alerts.
	.NOTES
	Version:        1.0
	Creation Date:  April 15, 2015
	Inspiration: https://gallery.technet.microsoft.com/scriptcenter/2d191bcd-3308-4edd-9de2-88dff796b0bc
	Author:         Scott Sugar
#>

Get-ChildItem -Path $PSScriptRoot | Unblock-File
Get-ChildItem -Path $PSScriptRoot\*.ps1 | Foreach-Object{ . $_.FullName }
