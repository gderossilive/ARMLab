$projectName = Read-Host -Prompt "Enter a project name that is used to generate resource and resource group names"
$resourceGroupName = "${projectName}rg"

New-AzResourceGroup `
  -Name $resourceGroupName `
  -Location "Western Europe"

$templateFile="https://github.com/gderossilive/ARMLab/raw/master/AzureDeploy.json"
$parameterFile="./AzureDeploy.parameters.json"

# Deploy the template
New-AzResourceGroupDeployment `
  -Name DeployLinkedTemplate `
  -ResourceGroupName $resourceGroupName `
  -TemplateFile $templateFile `
  -projectName $projectName `
  -TemplateParameterFile $parameterFile `
  -verbose