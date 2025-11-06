<#
  Helper to compile and run the ModelSim/SystemVerilog testbench.
  Assumes `vlog` and `vsim` are available on PATH (ModelSim-Altera).
#>

Param()

$here = Split-Path -Parent $MyInvocation.MyCommand.Definition
Push-Location $here
try {
  Write-Output "Compiling SystemVerilog sources with vlog..."
  # Compile all design files (modules at repo root and top/testbench under src/sim)
  vlog -sv ALU.sv register_file.sv data_memory.sv display.sv mux_memtoreg.sv mux_alusrc.sv mux_regdst.sv sign_extend.sv top.sv sim/top_tb.sv
    if ($LASTEXITCODE -ne 0) { throw "vlog failed with exit code $LASTEXITCODE" }

    Write-Output "Running simulation (vsim)..."
    # run in batch mode for a short time and then quit
    vsim -c -do "run 2000ns; quit" top_tb
}
finally {
    Pop-Location
}
