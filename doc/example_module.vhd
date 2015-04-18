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
--============================================================================


library ieee;
    use ieee.numeric_std.all;
    use ieee.std_logic_1164.all;

package template_module_package is
    component template_module is
        generic (
            my_generic : integer := 0
        );
        port (
            my_port : std_logic
        );
    end component template_module;
end package template_module_package;


library ieee;
    use ieee.numeric_std.all;
    use ieee.std_logic_1164.all;

entity template_module is
    generic (
        MY_GENERIC_A : integer := 8;
        MY_GENERIC_B : integer := 3
    );
    port (
        clk_i       : in std_logic;
        rst_i       : in std_logic;
        my_port_i   : in std_logic_vector(MY_GENERIC_A-1 downto 0);
        my_select_i : in std_logic_vector(MY_GENERIC_B-1 downto 0);
        my_port_o   : out std_logic_vector(MY_GENERIC_A-1 downto 0)
    );
begin
    assert (2**MY_GENERIC_B >= MY_GENERIC_A)
    report "example_module: Incompatible choice of generic values."
    severity FAILURE;
end entity template_module;

architecture rtl of template_module is
begin
    --! \vhdlflow
    p_my_process_label:
    process (clk_i, rst_i) is
        variable tmp : std_logic_vector(2 downto 0);
    begin
        if (rst_i = '1') then
            my_port_o <= (others => '0');
        elsif rising_edge(clk_i) then
            tmp := std_logic_vector(resize(unsigned(my_select_i), 3));
            case (tmp) is
                when "000" =>
                    my_port_o <= std_logic_vector(unsigned(my_port_i) + 1);
                when "001" =>
                    my_port_o <= std_logic_vector(unsigned(my_port_i) + 1);
                when "010" =>
                    my_port_o <= std_logic_vector(unsigned(my_port_i) + 2);
                when "011" =>
                    my_port_o <= std_logic_vector(unsigned(my_port_i) + 3);
                when "100" =>
                    my_port_o <= std_logic_vector(unsigned(my_port_i) + 5);
                when "101" =>
                    my_port_o <= std_logic_vector(unsigned(my_port_i) + 8);
                when "110" =>
                    my_port_o <= std_logic_vector(unsigned(my_port_i) + 13);
                when "111" =>
                    my_port_o <= std_logic_vector(unsigned(my_port_i) + 21);
                when others =>
                    my_port_o <= std_logic_vector(unsigned(my_port_i) + 1);
            end case;
        end if;
    end process;
end architecture rtl;
