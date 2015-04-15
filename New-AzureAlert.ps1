function New-AzureAlert {

   <#
	.SYNOPSIS
	New-AzureAlert defines a new monitoring alert to an existing Cloud
	Service deployment.
	.DESCRIPTION
	New-AzureAlert defines a new monitoring alert to an existing Cloud
	Service deployment
	for IaaS Virtual Machines or PaaS Web/Worker roles.
	For demonstration purposes only.
	No support or warranty is supplied or inferred.
	Use at your own risk.
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
	Creation Date:  Nov 8, 2014
	Author:         Keith Mayer ( http://KeithMayer.com )
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
	   
		$alertEnabled = "true"

		if ($alertAdmins) {
			$alertAdminsValue = "true"
		} else {
			$alertAdminsValue = "false"
		}
		   
	}

	process {

		$alertId = ([GUID]::NewGuid()).Guid

		$alertManagementUri =
			"https://management.core.windows.net/$subscriptionId/services/monitoring/alertrules/$alertID"

		$alertRequest = @"
		{
			"Id":  "$alertID",
			"Name":  "$alertName",
			"IsEnabled":  $alertEnabled,
			"Condition":  {
							  "odata.type":  "Microsoft.WindowsAzure.Management.Monitoring.Alerts.Models.ThresholdRuleCondition",
							  "DataSource":  {
												 "odata.type":  "Microsoft.WindowsAzure.Management.Monitoring.Alerts.Models.RuleMetricDataSource",
												 "ResourceId":  "/hostedservices/$cloudServiceName/deployments/$deploymentName/roles/$roleName",
												 "MetricNamespace":  "",
												 "MetricName":  "$metricName"
											 },
							  "Operator": "$metricOperator",
							  "Threshold":  $metricThreshold,
							  "WindowSize":  "$metricWindowSize"
						  },
			"Actions":  [
							{
								"odata.type":  "Microsoft.WindowsAzure.Management.Monitoring.Alerts.Models.RuleEmailAction",
								"SendToServiceOwners":  $alertAdminsValue,
								"CustomEmails": [
									"$alertOther"
								]
							}
						]
		}
		"@

		[byte[]]$requestBody =
			[System.Text.Encoding]::UTF8.GetBytes($alertRequest)

		$alertResponse = Invoke-RestMethod `
			-Uri $alertManagementUri `
			-Certificate $certificate `
			-Method Put `
			-Headers $requestHeader `
			-Body $requestBody `
			-ContentType $contentType

	}

	end {

		$alertListUri =
			"https://management.core.windows.net/$subscriptionID/services/monitoring/alertrules"

		$alerts = Invoke-RestMethod `
			-Uri $alertListUri `
			-Certificate $certificate `
			-Method Get `
			-Headers $requestHeader `
			-ContentType $contentType

		$alerts.Value | ConvertTo-Json

	}
	  
}
