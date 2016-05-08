--============================================================================
--!
--! \file      full_adder_tb.chd
--!
--! \project   full_adder
--!
--! \langv     VHDL-2008
--!
--! \brief     Testbench for the full_adder component.
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
library work;
    use work.full_adder_pkg;

entity full_adder_tb is
end entity full_adder_tb;

architecture tb of full_adder_tb is
    -- DUT port signals.
    signal a, b ,ci, s, co : std_logic;
    
    -- Testbench.
    type truth_table_t is array(integer range <>) of std_logic_vector(0 to 4);
    constant TRUTH_TABLE : truth_table_t(0 to 7) := (
        ('0', '0', '0', '0', '0'),
        ('1', '0', '0', '1', '0'),
        ('0', '1', '0', '1', '0'),
        ('1', '1', '0', '0', '1'),
        ('0', '0', '1', '1', '0'),
        ('1', '0', '1', '0', '1'),
        ('0', '1', '1', '0', '1'),
        ('1', '1', '1', '1', '1')
    );
begin
    -- Testbench.
    p_testbench: process is
    begin
        report("### Simulation started.");
        
        for i in TRUTH_TABLE'range loop
            a <= TRUTH_TABLE(i)(0);
            b <= TRUTH_TABLE(i)(1);
            ci <= TRUTH_TABLE(i)(2);
            
            wait for 10 ns;
            
            assert s = TRUTH_TABLE(i)(3)
            report "Unexpected sum output s_o for input (a_i, b_i, c_i) = "
                &"("&std_logic'image(a)&", "&std_logic'image(b)&", "
                &std_logic'image(ci)&")"
            severity ERROR;
            
            assert co = TRUTH_TABLE(i)(4)
            report "Unexpected carry output c_o for input (a_i, b_i, c_i) = "
                &"("&std_logic'image(a)&", "&std_logic'image(b)&", "
                &std_logic'image(ci)&")"
            severity ERROR;
        end loop;
        
        assert FALSE
        report("### Simulation finished.")
        severity NOTE;
        wait;
    end process p_testbench;
    
    -- DUT.
    i_full_adder_dut: full_adder_pkg.full_adder
        port map (
            a_i => a,
            b_i => b,
            c_i => ci,
            s_o => s,
            c_o => co
        );
end architecture tb;
