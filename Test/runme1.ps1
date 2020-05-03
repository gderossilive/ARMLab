[CmdletBinding()]
param ( 
    [Parameter(Mandatory=$True)]
    [String]
    $SubscriptionID
)

$connect=Connect-AzAccount
$context = Get-AzSubscription -SubscriptionId $SubscriptionID
Set-AzContext $context

$projectName = "gdr1274793862"
#$projectName = "gdr"+(Get-Random)
$location = "westeurope"
$upn=$connect.Context.Account.id

$resourceGroupName = "${projectName}rg"
$adUserId = (Get-AzADUser -UserPrincipalName $upn).Id

$templateUri = "https://raw.githubusercontent.com/gderossilive/ARMLab/master/helloworldparent.json"

New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateUri $templateUri
