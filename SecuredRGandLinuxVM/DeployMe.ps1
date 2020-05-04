$connect=Connect-AzAccount
$subscriptionChoose = @(Get-AzSubscription |Out-GridView -Title "Select your subscriptions" -PassThru)
Set-AzContext $subscriptionChoose.Name
$adUserId = (Get-AzADUser -UserPrincipalName $connect.Context.Account.id).Id
$location="westeurope"


#$projectName = "gdr1927008259"
$projectName = "Spoke"+(Get-Random)

$resourceGroupName = "${projectName}rg"
New-AzResourceGroup -Name $resourceGroupName -Location $location

$keyVaultName = $projectName
$SecretName="vm1AdminPassword"
$secretValue = Read-Host -Prompt "Enter the virtual machine administrator password" -AsSecureString

$templateUri = "https://raw.githubusercontent.com/gderossilive/ARMLab/master/SecuredRGandLinuxVM/AKVdeploy.json"

New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateUri $templateUri -keyVaultName $keyVaultName -adUserId $adUserId -secretName $SecretName -secretValue $secretValue

Write-Host "Press [ENTER] to continue ..."

$templateUri = "https://raw.githubusercontent.com/gderossilive/ARMLab/master/SecuredRGandLinuxVM/LinuxVMdeploy.json"
$templatefile = "C:\Users\gderossi\OneDrive - Microsoft\Poste Italiane\PCL\GitHub\ARMlab\SecuredRGandLinuxVM\LinuxVMdeploy.parameters.json"
$_artifactsLocation = "https://raw.githubusercontent.com/gderossilive/ARMLab/master/SecuredRGandLinuxVM/"

New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateParameterFile $templatefile -TemplateUri $templateUri -authenticationType "password" -ubuntuOSVersion "18.04-LTS" -VmSize "Standard_B2s" -virtualNetworkName "vNet" -subnetName "Subnet" -networkSecurityGroupName "SecGroupNet" -_artifactsLocation $_artifactsLocation

Write-Host "Press [ENTER] to continue ..."