Tools used in the libhdl tool chain, helping in development or repetetive tasks can be delegated to.
Tools should be based on Python, Perl or TCL. Simple shell scripts will do as well.
Try to remain platform independent (not the main focus while the code is growing).

TODO:

libhdl_hierachy: extract module hierarchy, given a top module and some search paths.

libhdl_syn: wrapper for most common vendor synthesis tools (not the most expensive ones).

libhdl_doc: script to generate documentation from libhdl source files. A doxygen wrapper.

libhdl_lint: a linter to help in maintaining the coding guidelines, propose possible improvements or extract metrics.

vhdl_wizard: helper tools to do repetetive tasks like: generate component from entity, generate instantiation template from entity/component, find unused/undeclared signals, generate testbench for entity/component, generate conversion function for enumeration type (FSM state to slv), &cetera.

QUESTIONS:

own HDL language parser is overkill. what open source implementations do exist?

