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
$secretValue = Read-Host -Prompt "Enter the virtual machine administrator password" -AsSecureString

$resourceGroupName = "${projectName}rg"
$keyVaultName = $projectName
$adUserId = (Get-AzADUser -UserPrincipalName $upn).Id
$templateUri = "https://raw.githubusercontent.com/gderossilive/ARMLab/master/AKVdeploy.json"

New-AzResourceGroup -Name $resourceGroupName -Location $location
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateUri $templateUri -keyVaultName $keyVaultName -adUserId $adUserId -secretValue $secretValue

Write-Host "Press [ENTER] to continue ..."

$templateUri = "https://raw.githubusercontent.com/gderossilive/ARMLab/master/AzureVMdeploy.json"
$templatefile = "C:\Users\gderossi\OneDrive - Microsoft\Poste Italiane\PCL\GitHub\ARMlab\AzureVMdeploy.parameters.json"

New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile $templatefile -TemplateUri $templateUri

Write-Host "Press [ENTER] to continue ..."