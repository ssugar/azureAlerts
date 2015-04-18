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




