[CmdletBinding()]
param ( 
    [Parameter(Mandatory=$True)]
    [String]
    $SubscriptionID
)

$connect=Connect-AzAccount
$context = Get-AzSubscription -SubscriptionId $SubscriptionID
Set-AzContext $context

$projectName = "gdr"+(Get-Random)
$location = "westeurope"
$upn=$connect.Context.Account.id
$secretValue = Read-Host -Prompt "Enter the virtual machine administrator password" -AsSecureString

$resourceGroupName = "${projectName}rg"
$keyVaultName = $projectName
$adUserId = (Get-AzADUser -UserPrincipalName $upn).Id
$templateUri = "https://raw.githubusercontent.com/Azure/azure-docs-json-samples/master/tutorials-use-key-vault/CreateKeyVault.json"
#$templateUri = "https://raw.githubusercontent.com/gderossilive/ARMLab/master/AKVdeploy.json?token=AEZ3DIYO5HPWPGJCBQST2GC6T3AU2"

New-AzResourceGroup -Name $resourceGroupName -Location $location
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateUri $templateUri -keyVaultName $keyVaultName -adUserId $adUserId -secretValue $secretValue

Write-Host "Press [ENTER] to continue ..."