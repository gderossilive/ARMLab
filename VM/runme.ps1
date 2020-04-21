$projectName ="gdr"
$resourceGroupName = "${projectName}rg"

#New-AzResourceGroup `
#  -Name $resourceGroupName `
#  -Location "westeurope"

$templateFile=".\AzureDeploy.json"
$parameterFile=".\AzureDeploy.parameters.json"

# Deploy the template
New-AzResourceGroupDeployment `
  -Name DeployLinkedTemplate `
  -ResourceGroupName $resourceGroupName `
  -TemplateFile $templateFile `
  -TemplateParameterFile $parameterFile `
  -verbose