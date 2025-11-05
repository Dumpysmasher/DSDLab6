<#
  Helper to run a Quartus compile for the project.
  Requires `quartus_sh` on PATH (you already added Quartus installation to PATH).
#>

Param()

$here = Split-Path -Parent $MyInvocation.MyCommand.Definition
Push-Location $here
try {
    Write-Output "Running Quartus compile for project 'lab6_kg'..."
    quartus_sh --flow compile lab6_kg
}
finally {
    Pop-Location
}
