--============================================================================
--!
--! \file      <FILE_NAME>
--!
--! \project   <PROJECT_NAME>
--!
--! \langv     VHDL-1987
--!
--! \brief     <BRIEF_DESCRIPTION>.
--!
--! \details   <DETAILED_DESCRIPTION>.
--!
--! \bug       <BUGS_OR_KNOWN_ISSUES>.
--!
--! \see       <REFERENCES>
--!
--! \copyright <COPYRIGHT_OR_LICENSE>
--!
--! Revision history:
--!
--! \version   <VERSION>
--! \date      <YYYY-MM-DD>
--! \author    <AUTHOR_NAME>
--! \brief     Create file.
--!
--============================================================================


library ieee;
    use ieee.numeric_std.all;
    use ieee.std_logic_1164.all;

package template_module_package is
    component template_module
        generic (
            my_generic : integer := 0
        );
        port (
            my_port : std_logic
        );
    end component;
end;


library ieee;
    use ieee.numeric_std.all;
    use ieee.std_logic_1164.all;

entity template_module is
    generic (
        my_generic : integer := 0
    );
    port (
        my_port : std_logic
    );
begin
end template_module;


library ieee;
    use ieee.numeric_std.all;
    use ieee.std_logic_1164.all;

architecture rtl of template_module is
begin
end rtl;
