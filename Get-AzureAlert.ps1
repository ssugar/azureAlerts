function Get-AzureAlert {

   <#
	.SYNOPSIS
	Get-AzureAlert lists monitoring alerts for the Current Azure Subscription
	.DESCRIPTION
	Get-AzureAlert lists monitoring alerts for the Current Azure Subscription
	.OUTPUTS
	Alert Rule Configurations for Current Subscription
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

		$alerts.Value
	}

	end {
	}
	  
}