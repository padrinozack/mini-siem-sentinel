# Run PowerShell as Administrator
# Generates: 4720 (user created), 4732/4733 (added/removed from Administrators), 4726 (user deleted), 4625 (failed logon)
Write-Host "Starting demo event generation..."

# Create a temporary local user
try {
  $pwd = ConvertTo-SecureString 'P@ssw0rd!' -AsPlainText -Force
  if (-not (Get-LocalUser -Name 'labtest' -ErrorAction SilentlyContinue)) {
    New-LocalUser -Name 'labtest' -Password $pwd -FullName 'Lab Test User' -Description 'Temp user for Sentinel demo'
    Write-Host "Created user 'labtest' (Event 4720)."
  }
} catch { Write-Warning $_ }

Start-Sleep -Seconds 2

# Add to Administrators (4732), then remove (4733)
try {
  Add-LocalGroupMember -Group 'Administrators' -Member 'labtest' -ErrorAction SilentlyContinue
  Write-Host "Added 'labtest' to Administrators (Event 4732)."
  Start-Sleep -Seconds 2
  Remove-LocalGroupMember -Group 'Administrators' -Member 'labtest' -ErrorAction SilentlyContinue
  Write-Host "Removed 'labtest' from Administrators (Event 4733)."
} catch { Write-Warning $_ }

Start-Sleep -Seconds 2

# Trigger some failed logons (4625)
$badUser = "$env:COMPUTERNAME\notauser"
for ($i=1; $i -le 6; $i++) {
  Start-Process -FilePath "runas.exe" -ArgumentList "/user:$badUser cmd" -NoNewWindow
  Start-Sleep -Milliseconds 400
}
Write-Host "Triggered multiple failed logons (Event 4625)."

Start-Sleep -Seconds 2

# Clean up the temp user (4726)
try {
  Remove-LocalUser -Name 'labtest' -ErrorAction SilentlyContinue
  Write-Host "Deleted user 'labtest' (Event 4726)."
} catch { Write-Warning $_ }

Write-Host "Done. Give Azure a few minutes to ingest."
