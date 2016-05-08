--============================================================================
--!
--! \file      full_adder.vhd
--!
--! \project   full_adder
--!
--! \langv     VHDL-2008
--!
--! \brief     A full adder.
--!
--! \details   -
--!
--! \bug       -
--!
--! \see       -
--!
--! \copyright GPLv2
--!
--! Revision history:
--!
--! \version   0.1
--! \date      2016-03-20
--! \author    Andreas Mueller
--! \brief     Create file.
--!
--============================================================================


library ieee;
    use ieee.numeric_std.all;
    use ieee.std_logic_1164.all;

package full_adder_pkg is
    component full_adder is
        port (
            a_i : in std_logic;
            b_i : in std_logic;
            c_i : in std_logic;
            s_o : out std_logic;
            c_o : out std_logic
        );
    end component full_adder;
end package full_adder_pkg;

package body full_adder_pkg is
end package body full_adder_pkg;


library ieee;
    use ieee.numeric_std.all;
    use ieee.std_logic_1164.all;

entity full_adder is
    port (
        a_i : in std_logic;
        b_i : in std_logic;
        c_i : in std_logic;
        s_o : out std_logic;
        c_o : out std_logic
    );
begin
end entity full_adder;

architecture rtl of full_adder is
begin
    s_o <= a_i xor b_i xor c_i;
    c_o <= (a_i and b_i) or (a_i and c_i) or (b_i and c_i);
end architecture rtl;
