Connect-AzAccount
$subscriptionChoose = @(Get-AzSubscription |Out-GridView -Title "Select your subscriptions" -PassThru)
Set-AzContext $subscriptionChoose.Name

$projectName = (Get-Random)
$location = "westeurope"
$resourceGroupName = "${projectName}rg"

$PolicyUri="https://raw.githubusercontent.com/Azure/azure-policy/master/samples/Compute/use-managed-disk-vm/azurepolicy.rules.json"
$PolicyTemplateUri="https://raw.githubusercontent.com/Azure/azure-policy/master/samples/Compute/use-managed-disk-vm/azurepolicy.parameters.json"

$definition = New-AzPolicyDefinition -Name "Deploy-managed-disk-vm" -DisplayName "Create VM using Managed Disk" -description "Create VM using Managed Disk" -Policy $PolicyUri -Parameter $PolicyTemplateUri -Mode All

$ResourceGroup = New-AzResourceGroup -Name $resourceGroupName -Location $location 

$assignment = New-AzPolicyAssignment -Name "use-managed-disk-vm" -Scope $ResourceGroup.ResourceId  -PolicyDefinition $definition

