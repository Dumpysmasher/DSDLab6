# lab6_kg

Quartus project scaffold for the lab (Cyclone IV E EP4CE115F29C7).

Files included:

- `src/top.sv` — small SystemVerilog top-level example (8-bit counter)
- `sim/top_tb.sv` — simple SystemVerilog testbench for ModelSim
- `lab6_kg.qpf` / `lab6_kg.qsf` — minimal Quartus project files (device set)
- `run_sim.ps1` — helper to compile & run ModelSim (assumes `vlog`/`vsim` on PATH)
- `run_quartus_compile.ps1` — helper to run Quartus compile (uses `quartus_sh`)

How to run

1) Simulation (ModelSim-Altera) — from PowerShell in this folder:

```powershell
.\run_sim.ps1
```

This assumes `vlog`/`vsim` are available on PATH (ModelSim-Altera). If not, provide the full path to those executables or run ModelSim from its installation shell.

2) Quartus compile — from PowerShell in this folder:

```powershell
.\run_quartus_compile.ps1
```

This will call `quartus_sh --flow compile lab6_kg` and requires Quartus (which you already added to PATH).

Notes
- Device: EP4CE115F29C7 (Cyclone IV E)
- Top-level entity name: `top`

If you want I can also add a simple Makefile or extend the testbench with assertions / wave dump.
