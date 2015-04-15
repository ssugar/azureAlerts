# azureAlerts
Powershell Functions to manage Azure alerts

##Prepare to use the functions##

The below instructions, the New-AzureAlert function, and inspiration for all of this from Keith Mayer from (here)[http://blogs.technet.com/b/keithmayer/archive/2014/11/08/scripts-to-tools-automate-monitoring-alert-rules-in-microsoft-azure-with-powershell-and-the-azure-service-management-rest-api.aspx]

To authenticate to the Azure Service Management REST API endpoints, we'll be passing the subscription ID and management certificate for your Azure subscription.  To obtain your subscription ID and management certificate, you can use the following snippet of code:

###Download Azure Publish Settings File###

    Get-AzurePublishSettingsFile

###Import Azure Publish Settings File###

    Import-AzurePublishSettingsFile 'path-to-publish-settings-file'

###Get your Azure subscription ID and certificate###

    $subscriptionName = 'your-subscription-name'
    $subscription = Get-AzureSubscription -SubscriptionName $subscriptionName -ExtendedDetails 
    $certificate = $subscription.Certificate
    $subscriptionId = $subscription.SubscriptionId

Tip! If you've previously authenticated to your Azure subscription via Azure AD credentials using the Add-AzureAccount cmdlet, you may first need to remove the Azure subscription information cached in your local subscription data file by using the Remove-AzureSubscription cmdlet. If you do not perform this step, the management certificate may not be properly returned when calling the Get-AzureSubscription cmdlet above.


