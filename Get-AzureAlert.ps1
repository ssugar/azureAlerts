function Get-AzureAlert {

   <#
	.SYNOPSIS
	Get-AzureAlert lists monitoring alerts for an existing Cloud
	Service deployment.
	.DESCRIPTION
	Get-AzureAlert lists monitoring alerts for an Azure Subscription
	.PARAMETER subscriptionId
	The Id of the Azure Subscription in which the Cloud Service is
	deployed
	.PARAMETER certificate
	Certificate used for authenticating to Azure subscription Id
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
		[string]$subscriptionId,
		[object]$certificate
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

		$alerts.Value
	}

	end {
	}
	  
}