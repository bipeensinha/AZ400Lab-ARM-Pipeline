
@echo off
set resourceGroup=az400-RG1

set storageAccount=bipeenst987



echo Checking if Storage Account exists...
for /f "delims=" %%B in ('az storage account show --name %storageAccount% --resource-group %resourceGroup% --query "primaryEndpoints.blob" -o tsv') do set storage=%%B

if "%storage%"=="" (
    echo ❌ Storage Account NOT found!
    exit /b 1
) else (
    echo ✅ Storage Account exists: %storage%
)

echo 🎉 Verification Completed Successfully!
