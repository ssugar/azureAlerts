function Update-AzureAlert {

   <#
	.SYNOPSIS
	Update-AzureAlert updates monitoring alerts for an existing Cloud
	Service deployment.
	.DESCRIPTION
	Update-AzureAlert updates monitoring alerts for an Azure Subscription
	.PARAMETER subscriptionId
	The Id of the Azure Subscription in which the Cloud Service is
	deployed
	.PARAMETER certificate
	Certificate used for authenticating to Azure subscription Id
	.PARAMETER cloudServiceName
	The name of an existing Cloud Service, as reported
	by Get-AzureService
	.PARAMETER deploymentName
	The name of an existing deployment within a Cloud Service, as
	reported by Get-AzureDeployment
	.PARAMETER roleName
	The name of an existing role within a Cloud Service deployment, as
	reported by Get-AzureDeployment
	.PARAMETER alertName
	The name for the new Alert to be added.
	The name can contain only letters, numbers, commas, and periods.
	The name can be up to 32 characters long.
	.PARAMETER alertDescription
	Optional description for the new Alert to be added.
	The description can contain only letters, numbers, commas, and
	periods.
	The description can be up to 128 characters long.
	.PARAMETER metricName
	Name of the metric on which to associate an alert rule.
	Valid metricName values include:
	"Percentage CPU"
	"Disk Read Bytes/Sec"
	"Disk Write Bytes/Sec"
	"Network In"
	"Network Out"
	.PARAMETER metricWindowSize
	Rolling timeframe across which metric should be evaluated against
	threshold.
	Valid metricWindowSize values include:
	"PT5M" (5 min)
	"PT15M" (15 min)
	"PT30M" (30 min)
	"PT45M" (45 min)
	"PT60M" (60 min)
	.PARAMETER metricOperator
	Operator used to compare metricName against metricThreshold.
	Value metricOperator values include:
	"GreaterThan"
	"GreaterThanOrEqual"
	"LessThan"
	"LessThanOrEqual"
	.PARAMETER metricThreshold
	Numeric value to which metricName is compared to determine if alert
	should be issued.
	.PARAMETER alertAdmins
	Indicates whether subscription administrators and co-administrators
	should be alerted via email.
	Valid alertAdmins values include: True, False
	.PARAMETER alertOther
	Email address for additional application administrator that should
	be alerted via email.
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
		[object]$certificate,
		[string]$cloudServiceName,
		[string]$deploymentName,
		[string]$roleName,
		[string]$alertName,
		[string]$alertDescription,
		[string]$metricName,
		[string]$metricWindowSize,
		[string]$metricOperator,
		[decimal]$metricThreshold,
		[boolean]$alertAdmins,
		[string]$alertOther
	)

	begin {

		$requestHeader = @{
			"x-ms-version" = "2013-10-01";
			"Accept" = "application/json"
		}
		$contentType = "application/json;charset=utf-8"
		   
	}

	process {

		Remove-AzureAlert -alertName $alertName `
			-subscriptionId $subscriptionId `
			-certificate $certificate `

	
		New-AzureAlert -alertName $alertName `
		    -alertDescription $alertDescription `
			-subscriptionId $subscriptionId `
			-certificate $certificate `
			-cloudServiceName $cloudServiceName `
			-roleName $roleName `
			-deploymentName $deploymentName `
			-metricName $metricName `
			-metricWindowSize $metricWindowSize `
			-metricOperator $metricOperator `
			-metricThreshold $metricThreshold `
			-alertAdmins $alertAdmins `
			-alertOther $alertOther

	}
	
	

	end {
	
	}
	  
}