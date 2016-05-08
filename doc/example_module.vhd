--============================================================================
--!
--! \file      example_module
--!
--! \project   libhdl
--!
--! \author    Andreas Muller
--!
--! \date      2015-04-20
--!
--! \version   1.0
--!
--! \brief     Brief module description in one or two sentences.
--!
--! \details   More detailed description. This should focus on the interfaces,
--!            and at most give a rough outline of the internal
--!            implementation.
--!
--! \bug       No bugs or known issues.
--!
--! \see       List of references useful for the understanding of this module.
--!            e.g. standards, RFCs, papers, book chapters, web links &cetera.
--!
--! \copyright Copyright (C) 2015, Andreas Muller
--!            GNU General Public License Version 2
--!
--!            This program is free software; you can redistribute it and/or
--!            modify it under the terms of the GNU General Public License as
--!            published by the Free Software Foundation; either version 2 of
--!            the License, or (at your option) any later version.
--!            This program is distributed in the hope that it will be useful,
--!            but WITHOUT ANY WARRANTY; without even the implied warranty of
--!            MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
--!            GNU General Public License for more details.
--!
--============================================================================


library ieee;
    use ieee.numeric_std.all;
    use ieee.std_logic_1164.all;

--! \brief A brief package description.
package template_module_package is
    --! \brief This is the component declaration for my entity.
    component template_module is
        generic (
            my_generic : integer := 0
        );
        port (
            my_port : std_logic
        );
    end component template_module;
end package template_module_package;


--! \brief Import standard packages.
library ieee;
    use ieee.numeric_std.all;
    use ieee.std_logic_1164.all;

--! \brief A brief entity description.
entity template_module is
    generic (
        MY_GENERIC_A : integer := 8; --! This generic does foo.
        MY_GENERIC_B : integer := 3  --! That generic does bar.
    );
    port (
        clk_i       : in std_logic; --! Clock input.
        rst_i       : in std_logic; --! Reset input.
        my_port_i   : in std_logic_vector(MY_GENERIC_A-1 downto 0); --! My input port description.
        my_select_i : in std_logic_vector(MY_GENERIC_B-1 downto 0); --! My select description.
        my_port_o   : out std_logic_vector(MY_GENERIC_A-1 downto 0) --! My output port description.
    );
begin
    assert (2**MY_GENERIC_B >= MY_GENERIC_A)
    report "example_module: Incompatible choice of generic values."
    severity FAILURE;
end entity template_module;

--! \brief A brief architecture description.
architecture rtl of template_module is
    --! \brief A brief function description.
    --! \param Description of parameter 1.
    --! \return Description of return value.
    function my_function(param1 : integer) return integer is
    begin
        return param1;
    end function my_function;
    
    --! \brief A brief procedure description.
    --! \param Description of parameter 1.
    --! \return Description of return value.
    procedure my_procedure(param1 : in integer, reval1 : out integer) is
    begin
        reval1 <= param1;
    end function my_procedure;
begin
    --! \brief A brief process description.
    --! \vhdlflow
    p_my_process_label:
    process (clk_i, rst_i) is
    begin
        if (rst_i = '1') then
            my_port_o <= (others => '0');
        elsif rising_edge(clk_i) then
            assert (to_integer(unsigned(my_select_i)) < my_port_i'length)
            report "example_module: Invalid signal value."
            severity error;
            
            my_port_o <= (others => my_port_i(to_integer(unsigned(
                my_select_i))));
        end if;
    end process;
end architecture rtl;
