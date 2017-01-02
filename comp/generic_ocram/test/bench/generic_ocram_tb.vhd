--============================================================================
--!
--! \file      generic_ocram_tb
--!
--! \project   generic_ocram
--!
--! \langv     VHDL-2008
--!
--! \brief     Testbench for component generic_ocram.
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
--! \date      2016-03-23
--! \author    Andreas Mueller
--! \brief     Create file.
--!
--============================================================================


library ieee;
    use ieee.numeric_std.all;
    use ieee.std_logic_1164.all;

library work;
    use work.generic_ocram_pkg;

entity generic_ocram_tb is
end entity generic_ocram_tb;

architecture tb of generic_ocram_tb is
    -- DUT generics.
    constant WIDTH : integer := 8;
    constant DEPTH : integer := 1024;
    constant READ_FIRST : boolean := TRUE;
    
    -- DUT port signals.
    signal clk   : std_logic := '0';
    signal rst   : std_logic := '1';
    signal addr  : std_logic_vector(generic_ocram_pkg.log2c(DEPTH)-1 downto 0);
    signal wren  : std_logic;
    signal datai : std_logic_vector(WIDTH-1 downto 0);
    signal datao : std_logic_vector(WIDTH-1 downto 0);
    
    -- Testbench.
    constant CLK_PERIOD : time := 10 ns;
    
    procedure sim_generic_ocram_write(
        constant C_ADDR : in std_logic_vector(addr'range);
        constant C_DATA : in std_logic_vector(WIDTH-1 downto 0);
        signal clk_i  : in std_logic;
        signal addr_o : out std_logic_vector(addr'range);
        signal wren_o : out std_logic;
        signal data_o : out std_logic_vector(WIDTH-1 downto 0)
    ) is
    begin
        wait until rising_edge(clk_i);
        addr_o <= C_ADDR;
        wren_o <= '1';
        data_o <= C_DATA;
        wait until rising_edge(clk_i);
        wren_o <= '0';
        report "Wrote "&integer'image(to_integer(unsigned(C_DATA)))&
            " to address "&integer'image(to_integer(unsigned(C_ADDR)));
    end procedure sim_generic_ocram_write;
    
    procedure sim_generic_ocram_read(
        constant C_ADDR : in std_logic_vector(addr'range);
        signal clk_i  : in std_logic;
        signal addr_o : out std_logic_vector(addr'range);
        signal data_i : in std_logic_vector(WIDTH-1 downto 0)
    ) is
    begin
        wait until rising_edge(clk_i);
        addr_o <= C_ADDR;
        wait until rising_edge(clk_i);
        wait until rising_edge(clk_i);
        report "Read "&integer'image(to_integer(unsigned(data_i)))&
            " from address "&integer'image(to_integer(unsigned(C_ADDR)));
    end procedure sim_generic_ocram_read;
    
begin
    
    p_testbench: process is
    begin
        report "### Simulation started.";
        
        rst   <= '1';
        addr  <= (others => '0');
        wren  <= '0';
        datai <= (others => '1');
        wait for 100 ns;
        
        sim_generic_ocram_write(
            C_ADDR   => "0000000001",
            C_DATA   => X"39",
            clk_i  => clk,
            addr_o => addr,
            wren_o => wren,
            data_o => datai
        );
        
        sim_generic_ocram_write(
            C_ADDR   => "1111111111",
            C_DATA   => X"72",
            clk_i  => clk,
            addr_o => addr,
            wren_o => wren,
            data_o => datai
        );
        
        sim_generic_ocram_read(
            C_ADDR   => "0000000001",
            clk_i  => clk,
            addr_o => addr,
            data_i => datao
        );
        
        sim_generic_ocram_read(
            C_ADDR   => "1111111111",
            clk_i  => clk,
            addr_o => addr,
            data_i => datao
        );
        
        assert FALSE
        report "### Simulation finished."
        severity note;
        wait;
    end process p_testbench;
    
    clk <= not clk after CLK_PERIOD/2;
    
    i_generic_ocram_dut: generic_ocram_pkg.generic_ocram
        generic map (
            WIDTH => WIDTH,
            DEPTH => DEPTH,
            READ_FIRST => READ_FIRST
        )
        port map (
            clk_i  => clk,
            rst_i  => rst,
            addr_i => addr,
            wren_i => wren,
            data_i => datai,
            data_o => datao
        );
    
end architecture tb;
