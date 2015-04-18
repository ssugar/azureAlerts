function Update-AzureAlert {

   <#
	.SYNOPSIS
	Update-AzureAlert updates monitoring alerts for an existing Cloud
	Service deployment.
	.DESCRIPTION
	Update-AzureAlert updates monitoring alerts for an Azure Subscription
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
		[Parameter(Mandatory=$true, HelpMessage="Name of the cloud service")]
		[string]$cloudServiceName,
		[Parameter(Mandatory=$true, HelpMessage="Name of deployment, usually same as cloud service name")]
		[string]$deploymentName,
		[Parameter(Mandatory=$true, HelpMessage="Name of role, usually same as cloud service name")]
		[string]$roleName,
		[Parameter(Mandatory=$true, HelpMessage="Name of Alert to Update")]
		[string]$alertName,
		[Parameter(Mandatory=$true, HelpMessage="Description of Alert")]
		[string]$alertDescription,
		[Parameter(Mandatory=$true, HelpMessage="Percentage CPU, Disk Read Bytes/Sec, Disk Write Bytes/Sec, Network In, Network Out")]
		[ValidateSet("Percentage CPU", "Disk Read Bytes/Sec", "Disk Write Bytes/Sec", "Network In", "Network Out")]
		[string]$metricName,
		[Parameter(Mandatory=$true, HelpMessage="PT5M, PT15M, PT30M, PT45M, PT60M")]
		[ValidateSet("PT5M", "PT15M", "PT30M", "PT45M", "PT60M")]
		[string]$metricWindowSize,
		[Parameter(Mandatory=$true, HelpMessage="GreaterThan, GreaterThanOrEqual, LessThan, LessThanOrEqual")]
		[ValidateSet("GreaterThan", "GreaterThanOrEqual", "LessThan", "LessThanOrEqual")]
		[string]$metricOperator,
		[Parameter(Mandatory=$true, HelpMessage="Alert threshold")]
		[decimal]$metricThreshold,
		[Parameter(Mandatory=$true, HelpMessage="True or False")]
		[boolean]$alertAdmins=$false,
		[Parameter(Mandatory=$true, HelpMessage="Other email addresses to alert")]
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

		Remove-AzureAlert -alertName $alertName

	
		New-AzureAlert -alertName $alertName `
		    -alertDescription $alertDescription `
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