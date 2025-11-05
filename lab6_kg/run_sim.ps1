<#
  Helper to compile and run the ModelSim/SystemVerilog testbench.
  Assumes `vlog` and `vsim` are available on PATH (ModelSim-Altera).
#>

Param()

$here = Split-Path -Parent $MyInvocation.MyCommand.Definition
Push-Location $here
try {
    Write-Output "Compiling SystemVerilog sources with vlog..."
    vlog -sv src/top.sv sim/top_tb.sv
    if ($LASTEXITCODE -ne 0) { throw "vlog failed with exit code $LASTEXITCODE" }

    Write-Output "Running simulation (vsim)..."
    # run in batch mode for a short time and then quit
    vsim -c -do "run 2000ns; quit" top_tb
}
finally {
    Pop-Location
}
