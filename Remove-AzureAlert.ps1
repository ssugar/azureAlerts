function Remove-AzureAlert {

   <#
	.SYNOPSIS
	Remove-AzureAlert removes a monitoring alert setup.
	.DESCRIPTION
	Remove-AzureAlert removes a monitoring alert setup.
	.PARAMETER subscriptionId
	The Id of the Azure Subscription in which the Cloud Service is
	deployed
	.PARAMETER certificate
	Certificate used for authenticating to Azure subscription Id
	.PARAMETER alertName
	The name for the new Alert to be removed.
	The name will contain only letters, numbers, commas, and periods.
	The name will be up to 32 characters long.
	.INPUTS
	Parameters above.
	.OUTPUTS
	json output for alert rule configuration that was successfully
	provisioned.
	.NOTES
	Version:        1.0
	Creation Date:  April 15, 2015
	Author:         Scott Sugar
	Inspiration: 	Keith Mayer ( http://KeithMayer.com )
	Change:         Initial function development
	#>

	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory=$true)]
		[string]$subscriptionId,
		[Parameter(Mandatory=$true)]
		[object]$certificate,
		[Parameter(Mandatory=$true, HelpMessage="Name of Alert you want to Remove")]
		[string]$alertName
	)

	begin {

		$requestHeader = @{
			"x-ms-version" = "2013-10-01";
			"Accept" = "application/json"
		}
		$contentType = "application/json;charset=utf-8"
		   
	}

	process {
		$alertListUri =
			"https://management.core.windows.net/$subscriptionID/services/monitoring/alertrules"

		$alerts = Invoke-RestMethod `
			-Uri $alertListUri `
			-Certificate $certificate `
			-Method Get `
			-Headers $requestHeader `
			-ContentType $contentType

		$rule = $alerts.Value | ?{$_.Name -eq $alertName} | Select Id
		$ruleID = $rule.Id
	
		$alertDeleteUri =
			"https://management.core.windows.net/$subscriptionID/services/monitoring/alertrules/$ruleID"

		$alertRemoval = Invoke-RestMethod `
			-Uri $alertDeleteUri `
			-Certificate $certificate `
			-Method Delete `
			-Headers $requestHeader `
			-ContentType $contentType

		$alertRemoval.Value
	
	}

	end {
	}
	  
}