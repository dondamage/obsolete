libhdl
======

The libhdl project is released as free software under the terms of the GPLv2.

Overview
--------

This project contains a growing collection of components and packages, which present
solutions to common HDL design problems. Most HDL components are only offered in VHDL at the
moment. Verilog may follow later.

Folder Structure
----------------

The repository folder structure is briefly outlined in the following:

/comp/ : Folder for reusable design units (components) implemented in device-agnostic HDL (no vendor primitives).
  template/ : Contains component templates for various HDL languages and versions.
    ...
  <component_name>/ : Parent folder for a VHDL component.
    doc/ : Documentation of the component. Focus on the interface. Limitations!
    rtl/ : Synthesizable RTL source code.
      <component_name>.vhd : Main component file containing entity, architecture and package (VHDL).
    sim/ : Simulation related files (no HDL code).
      <vendor>/ : Simulator vendor.
        <tool>/ : Simulator name.
          out/ : Simulation output.
          run/ : Simulation script.
          tmp/ : Temporary files and intermediate artefacts.
    syn/ : Synthesis folder.
      <vendor>/ : Synthesis tool vendor.
        <tool>/ : Synthesis tool name.
          out/ : Synthesis output.
          run/ : Synthesis script.
          tmp/ : Temporary files and intermediate artefacts.
    test/ : Test related files
      bench/ : Testbench.
      src/ : Source code for testbench and simulation (potentially non-synthesizable).

/doc/ : Documentation of the libhdl project as a whole.

/lib/ : Folder for VHDL packages containing constants and subprograms.
  _template/ : Contains library templates for various HDL languages and versions.
    ...
  <libname>/ : Parent folder for a VHDL package. 

/tool/ : Software tools like code generators, editor configurations, utility scripts &cetera.
