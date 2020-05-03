$connect=Connect-AzAccount
$subscriptionChoose = @(Get-AzSubscription |Out-GridView -Title "Select your subscriptions" -PassThru)
Set-AzContext $subscriptionChoose.Name
#$adUserId = (Get-AzADUser -UserPrincipalName $connect.Context.Account.id).Id

$RGlocation="westeurope"
$RGName = "Spoke"+(Get-Random)

$templateUri = "https://raw.githubusercontent.com/gderossilive/ARMLab/master/Test/RGdeploy.json"
#$templatefile = "C:\Users\gderossi\OneDrive - Microsoft\Poste Italiane\PCL\GitHub\ARMlab\AzureVMdeploy.parameters.json"

New-AzSubscriptionDeployment -Location $RGlocation -TemplateUri $templateUri -rgName $RGName -rgLocation $RGlocation

Write-Host "Press [ENTER] to continue ..."