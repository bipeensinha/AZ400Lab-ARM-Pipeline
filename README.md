<img width="514" alt="image" src="https://github.com/user-attachments/assets/d3345c74-8602-49c5-9871-07be6d627a13" />



Release Pipeline to Apply Updates
The Release Pipeline will: ✅ Take the Bicep artifact from Build Pipeline
✅ Deploy infrastructure updates to bipeenRG

🛠️ Steps to Create Release Pipeline in Azure DevOps
Go to Azure DevOps → Pipelines → Releases → New Pipeline

Select "Empty Job"

Add Artifact:

Click "Add an artifact"
Choose "Build", then select the Build Pipeline
Artifact Name: bicep-artifact
Click on "Stage 1", rename it to "Deploy Infra", and click "Add Task"

Add "Azure CLI" Task:

Azure Subscription: myapp
Script Type: Bash
Script Location: Inline Script
Inline Script:
bash
Copy
Edit
az deployment group create --resource-group bipeenRG --template-file $(System.ArtifactsDirectory)/bicep-artifact/infra.bicep
Save & Create Release.

Trigger the Release Pipeline to deploy updates.
