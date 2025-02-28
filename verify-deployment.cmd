
@echo off
set resourceGroup=bipeenRG
set webAppName=bipeenapp8765
set storageAccount=bipeenst987

echo Checking if Web App exists...
for /f "delims=" %%A in ('az webapp show --name %webAppName% --resource-group %resourceGroup% --query "defaultHostName" -o tsv') do set webApp=%%A

if "%webApp%"=="" (
    echo ❌ Web App NOT found!
    exit /b 1
) else (
    echo ✅ Web App exists: https://%webApp%
)

echo Checking if Storage Account exists...
for /f "delims=" %%B in ('az storage account show --name %storageAccount% --resource-group %resourceGroup% --query "primaryEndpoints.blob" -o tsv') do set storage=%%B

if "%storage%"=="" (
    echo ❌ Storage Account NOT found!
    exit /b 1
) else (
    echo ✅ Storage Account exists: %storage%
)

echo 🎉 Verification Completed Successfully!
