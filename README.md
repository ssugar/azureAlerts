# azureAlerts
Powershell Module to manage Azure Alert Rules

Most of the New-AzureAlert function, and inspiration for all of this from Keith Mayer from [here](http://blogs.technet.com/b/keithmayer/archive/2014/11/08/scripts-to-tools-automate-monitoring-alert-rules-in-microsoft-azure-with-powershell-and-the-azure-service-management-rest-api.aspx)

##Prepare to use the Module##
You'll need to connect to your azure subscription via the Get-AzurePublishSettingsFile method, not the Add-AzureAccount method.

###Download Azure Publish Settings File###

    Get-AzurePublishSettingsFile

###Import Azure Publish Settings File###

    Import-AzurePublishSettingsFile 'path-to-publish-settings-file'

Note: If you've previously authenticated to your Azure subscription via Azure AD credentials using the Add-AzureAccount cmdlet, you will need to remove the Azure subscription information cached in your local subscription data file by using the Remove-AzureSubscription cmdlet. If you do not perform this step, the management certificate required for the Azure Service Management REST API won't be available in the Powershell session and you will encounter errors.

###Download the Module###

    git clone https://github.com/ssugar/azureAlerts
	
###Import the Module###

	cd azureAlerts
    Import-Module .\AzureAlerts.psd1
	
##Using the Module##

###Get-AzureAlert###

    Get-AzureAlert

This returns a listing of all alert rules configured in the current subscription.

Required Parameters:
+ None

Optional Parameters:
+ None

###New-AzureAlert###

    New-AzureAlert

This adds a new alert rule to a cloud service in the current subscription.

Required Parameters:
+ cloudServiceName - The name of an existing Cloud Service, as reported by Get-AzureService
+ deploymentName - The name of an existing deployment within a Cloud Service, as reported by Get-AzureDeployment
+ roleName - The name of an existing role within a Cloud Service deployment, as	reported by Get-AzureDeployment
+ alertName - The name for the new Alert to be added. The name can contain only letters, numbers, commas, and periods. The name can be up to 32 characters long.
+ alertDescription - Description for the new Alert to be added. The description can contain only letters, numbers, commas, and periods. The description can be up to 128 characters long.
+ metricName - Name of the metric on which to associate an alert rule. Valid metricName values include:
 - "Percentage CPU"
 - "Disk Read Bytes/Sec"
 - "Disk Write Bytes/Sec"
 - "Network In"
 - "Network Out"
+ metricWindowSize - Rolling timeframe across which metric should be evaluated against threshold. Valid metricWindowSize values include:
 - "PT5M" (5 min)
 - "PT15M" (15 min)
 - "PT30M" (30 min)
 - "PT45M" (45 min)
 - "PT60M" (60 min)
+ metricOperator - Operator used to compare metricName against metricThreshold. Value metricOperator values include:
 - "GreaterThan"
 - "GreaterThanOrEqual"
 - "LessThan"
 - "LessThanOrEqual"
+ metricThreshold - Numeric value to which metricName is compared to determine if alert should be issued.
+ alertAdmins - Indicates whether subscription administrators and co-administrators should be alerted via email. Valid alertAdmins values include:
 - True
 - False
+ alertOther - Email address for additional application administrator that should be alerted via email.

Optional Parameters:
+ None



