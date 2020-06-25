Connect-AzureAD

Add-Type -AssemblyName System.Windows.Forms

$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{
  InitialDirectory = [Environment]::GetFolderPath('Desktop')
  Filter = 'CSV files (*.csv)|*.csv'
}

$null = $FileBrowser.ShowDialog()

$Csv = $FileBrowser.FileName

Import-Csv $csv | foreach{
  Set-AzureADUser -ObjectId $_.UserPrincipalName -DisplayName $_.DisplayName -Department $_.Department
  Start-Sleep -seconds 2
}

Disconnect-AzureAD
