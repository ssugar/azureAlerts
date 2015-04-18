# azureAlerts
Powershell Module to manage Azure Alert Rules via the Azure Service Management REST API.

* [Prepare](#prepare)
* [Usage](#usage)

Most of the New-AzureAlert function, and inspiration for all of this from Keith Mayer from [here](http://blogs.technet.com/b/keithmayer/archive/2014/11/08/scripts-to-tools-automate-monitoring-alert-rules-in-microsoft-azure-with-powershell-and-the-azure-service-management-rest-api.aspx)

##Prepare to use the Module <a id="prepare"></a>##
You'll need to connect to your azure subscription via the Get-AzurePublishSettingsFile method, not the Add-AzureAccount method.

####Download Azure Publish Settings File####

    Get-AzurePublishSettingsFile

####Import Azure Publish Settings File####

    Import-AzurePublishSettingsFile 'path-to-publish-settings-file'

Note: If you've previously authenticated to your Azure subscription via Azure AD credentials using the Add-AzureAccount cmdlet, you will need to remove the Azure subscription information cached in your local subscription data file by using the Remove-AzureSubscription cmdlet. If you do not perform this step, the management certificate required for the Azure Service Management REST API won't be available in the Powershell session and you will encounter errors.

####Download the Module####

    git clone https://github.com/ssugar/azureAlerts
	
####Import the Module####

	cd azureAlerts
    Import-Module .\AzureAlerts.psd1
	
##Using the Module <a id="usage"></a>##

####Get-AzureAlert####

    Get-AzureAlert

This returns a listing of all alert rules configured in the current subscription.

######Required Parameters######
+ None

######Optional Parameters######
+ None

####New-AzureAlert####

    New-AzureAlert -cloudServiceName "Name of cloud service" -deploymentName "Name of deployment" -roleName "Name of role" -alertName "Name of alert" -alertDescription "Description of Alert" -metricName "Network Out" -metricWindowSize "PT15M" -metricOperator "GreaterThan" -metricThreshold "1000000" -alertAdmins $false -alertOther "email@company.com"

This adds a new alert rule to a cloud service in the current subscription.  This function will require you to have unique names for your alerts.  That is not a requirement of the Azure service management API, but makes it easier to remove alerts by referencing their name rather than ID.

######Required Parameters######
+ **cloudServiceName** - The name of an existing Cloud Service, as reported by Get-AzureService
+ **deploymentName** - The name of an existing deployment within a Cloud Service, as reported by Get-AzureDeployment
+ **roleName** - The name of an existing role within a Cloud Service deployment, as	reported by Get-AzureDeployment
+ **alertName** - The name for the new Alert to be added. The name can contain only letters, numbers, commas, and periods. The name can be up to 32 characters long.  Must be unique.
+ **alertDescription** - Description for the new Alert to be added. The description can contain only letters, numbers, commas, and periods. The description can be up to 128 characters long.
+ **metricName** - Name of the metric on which to associate an alert rule. Valid metricName values include:
 - "Percentage CPU"
 - "Disk Read Bytes/Sec"
 - "Disk Write Bytes/Sec"
 - "Network In"
 - "Network Out"
+ **metricWindowSize** - Rolling timeframe across which metric should be evaluated against threshold. Valid metricWindowSize values include:
 - "PT5M" (5 min)
 - "PT15M" (15 min)
 - "PT30M" (30 min)
 - "PT45M" (45 min)
 - "PT60M" (60 min)
+ **metricOperator** - Operator used to compare metricName against metricThreshold. Value metricOperator values include:
 - "GreaterThan"
 - "GreaterThanOrEqual"
 - "LessThan"
 - "LessThanOrEqual"
+ **metricThreshold** - Numeric value to which metricName is compared to determine if alert should be issued.
+ **alertAdmins** - Indicates whether subscription administrators and co-administrators should be alerted via email. Valid alertAdmins values include:
 - True
 - False
+ **alertOther** - Email address for additional application administrator that should be alerted via email.

######Optional Parameters######
+ None

####Update-AzureAlert####

    Update-AzureAlert -cloudServiceName "Name of cloud service" -deploymentName "Name of deployment" -roleName "Name of role" -alertName "Name of alert" -alertDescription "Description of Alert" -metricName "Network Out" -metricWindowSize "PT15M" -metricOperator "GreaterThan" -metricThreshold "1000000" -alertAdmins $false -alertOther "email@company.com"

This currently removes and then re-creates a rule to a cloud service in the current subscription.  Issues encountered when trying to update a rule directly.   Possibly because the rule Id returned by the Azure Service Management API is different than the GUID used to create the rule.  The Delete method works with the different rule Id, but the Put method doesnt seem to.

######Required Parameters######
+ **cloudServiceName** - The name of an existing Cloud Service, as reported by Get-AzureService
+ **deploymentName** - The name of an existing deployment within a Cloud Service, as reported by Get-AzureDeployment
+ *roleName** - The name of an existing role within a Cloud Service deployment, as	reported by Get-AzureDeployment
+ **alertName** - The name for the new Alert to be added. The name can contain only letters, numbers, commas, and periods. The name can be up to 32 characters long.
+ **alertDescription** - Description for the new Alert to be added. The description can contain only letters, numbers, commas, and periods. The description can be up to 128 characters long.
+ **metricName** - Name of the metric on which to associate an alert rule. Valid metricName values include:
 - "Percentage CPU"
 - "Disk Read Bytes/Sec"
 - "Disk Write Bytes/Sec"
 - "Network In"
 - "Network Out"
+ **metricWindowSize** - Rolling timeframe across which metric should be evaluated against threshold. Valid metricWindowSize values include:
 - "PT5M" (5 min)
 - "PT15M" (15 min)
 - "PT30M" (30 min)
 - "PT45M" (45 min)
 - "PT60M" (60 min)
+ **metricOperator** - Operator used to compare metricName against metricThreshold. Value metricOperator values include:
 - "GreaterThan"
 - "GreaterThanOrEqual"
 - "LessThan"
 - "LessThanOrEqual"
+ **metricThreshold** - Numeric value to which metricName is compared to determine if alert should be issued.
+ **alertAdmins** - Indicates whether subscription administrators and co-administrators should be alerted via email. Valid alertAdmins values include:
 - True
 - False
+ **alertOther** - Email address for additional application administrator that should be alerted via email.

######Optional Parameters######
+ None

####Remove-AzureAlert####

    Remove-AzureAlert -alertName "Name of your alert"

This will remove an alert rule from the current subscription based on the alertName.  If more than one alert rule has the same name, this will probably fail.  To try and avoid this, the New-AzureAlert function will not create a rule with a duplicate name.

######Required Parameters######
+ **alertName** - The name for the new Alert to be added. The name can contain only letters, numbers, commas, and periods. The name can be up to 32 characters long.

######Optional Parameters######
+ None
