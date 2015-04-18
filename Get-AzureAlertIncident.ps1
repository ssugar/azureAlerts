function Get-AzureAlertIncident {

   <#
	.SYNOPSIS
	Get-AzureAlertIncident lists monitoring alert incidents for an existing Cloud
	Service deployment.
	.DESCRIPTION
	Get-AzureAlertIncident lists monitoring alert incidents for an Azure Subscription
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
		[Parameter(Mandatory=$true, HelpMessage="Name of Alert you want to get incidents for")]
		[string]$alertName
	)

	begin {

		$requestHeader = @{
			"x-ms-version" = "2013-10-01";
			"Accept" = "application/json"
		}
		$contentType = "application/json;charset=utf-8"

		$subInfo = Get-AzureSubscription -Current -ExtendedDetails
		$subscriptionID = $subInfo.SubscriptionId
		$certificate = $subInfo.Certificate
		   
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
	
		$alertListIncidentUri =
			"https://management.core.windows.net/$subscriptionID/services/monitoring/alertrules/$ruleID/alertincidents"

		$incidents = Invoke-RestMethod `
			-Uri $alertListIncidentUri `
			-Certificate $certificate `
			-Method Get `
			-Headers $requestHeader `
			-ContentType $contentType

		$incidents.Value | fl

	}

	end {
	}
	  
}