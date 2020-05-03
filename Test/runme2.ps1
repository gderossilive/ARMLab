
Connect-AzAccount
$subscriptionChoose = @(Get-AzSubscription |Out-GridView -Title "seleziona la sottoscrizione" -PassThru)
Set-AzContext $subscriptionChoose.Name

$projectName = "gdr1274793862"
#$projectName = "gdr"+(Get-Random)

$resourceGroupName = "${projectName}rg"

$templateUri = "https://raw.githubusercontent.com/gderossilive/ARMLab/master/public-ip-parentloadbalancer.json"

New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateUri $templateUri
