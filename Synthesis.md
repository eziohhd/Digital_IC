# Notes about synthesis

## Basic synthesis flow

* Syntax Analysis:

    * Read in HDL files and check for syntax errors.
    
        read_hdl -verilog sourceCode/toplevel.v
    
* Library Definition

    * Provide standard cells and IP Libraries.
        ```
        read_libs "/.../....lib/.lib"
        ```

* Elaboration and Binding:

    * Convert RTL into Boolean structure.
    
    * State reduction, encoding, register infering.

    * Bind all leaf cells to provided libraries.
        ```
        elaborate toplevel
        ```

* Constraint Definition

    * Define clock frequency and other constraints.
        ```
        read_sdc sdc/constraints.sdc
        ```

* Pre-mapping Optimization:

    * Map to generic cells and perform additional heuristics
        ```
        syn_generic
        ```
* Technology Mapping:
    
    * Map generic logic to technology libraries
        ```
        syn_map
        ```
* Post-mapping Optimization:

    * Iterate over design, changing gate sizes, Boolean literals, architectural approaches to try and meet constraints.
        ```
        syn_opt
        ```
* Report and export

