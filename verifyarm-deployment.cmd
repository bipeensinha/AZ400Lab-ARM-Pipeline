# runb in powershell core
# Define variables
$resourceGroup = "az400-RG1"
$storageAccount = "bipeenst987sde"

Write-Host "Checking if Storage Account exists..."

# Get the storage account primary blob endpoint
$storage = az storage account show --name $storageAccount --resource-group $resourceGroup --query "primaryEndpoints.blob" -o tsv

if (-not $storage) {
    Write-Host "❌ Storage Account NOT found!"
    exit 1
} else {
    Write-Host "✅ Storage Account exists: $storage"
}

Write-Host "🎉 Verification Completed Successfully!"
