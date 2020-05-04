Connect-AzAccount
$subscriptionChoose = @(Get-AzSubscription |Out-GridView -Title "Select your subscriptions" -PassThru)
Set-AzContext $subscriptionChoose.Name

$projectName = "RG"+(Get-Random)
$location = "westeurope"
$resourceGroupName = "${projectName}rg"
$templateUri = "https://raw.githubusercontent.com/gderossilive/ARMLab/master/LoadBalancer/RGdeploy.json"

New-AzDeployment -Location $location -TemplateUri $templateUri -RGname $resourceGroupName -RGlocation $location
#New-AzResourceGroup -Name $resourceGroupName -Location $location

Write-Host "Press [ENTER] to continue."

$adminUserName = Read-Host -Prompt "Enter the virtual machine administrator account name"
$adminPassword = Read-Host -Prompt "Enter the virtual machine administrator password" -AsSecureString
$templateUri = "https://raw.githubusercontent.com/gderossilive/ARMLab/master/LoadBalancer/LBdeploy.json"

New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateUri $templateUri -projectName $projectName -location $location -adminUsername $adminUsername -adminPassword $adminPassword