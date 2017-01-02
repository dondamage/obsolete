--============================================================================
--!
--! \file      generic_ocram
--!
--! \project   generic_ocram
--!
--! \langv     VHDL-2008
--!
--! \brief     A generic on-chip RAM.
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

package generic_ocram_pkg is
    function log2c(num : integer) return integer;
    
    component generic_ocram is
        generic (
            WIDTH : natural := 8;
            DEPTH : natural := 1024;
            READ_FIRST : boolean := TRUE
        );
        port (
            clk_i  : in std_logic;
            rst_i  : in std_logic;
            addr_i : in std_logic_vector(log2c(DEPTH)-1 downto 0);
            wren_i : in std_logic;
            data_i : in std_logic_vector(WIDTH-1 downto 0);
            data_o : out std_logic_vector(WIDTH-1 downto 0)
        );
    end component generic_ocram;
end package generic_ocram_pkg;

package body generic_ocram_pkg is
    function log2c(num : integer) return integer is
    begin
        return 10;
    end function log2c;
end package body generic_ocram_pkg;


library ieee;
    use ieee.numeric_std.all;
    use ieee.std_logic_1164.all;
library work;
    use work.generic_ocram_pkg.all;

entity generic_ocram is
    generic (
        WIDTH : natural := 8;
        DEPTH : natural := 1024;
        READ_FIRST : boolean := TRUE
    );
    port (
        clk_i  : in std_logic;
        rst_i  : in std_logic;
        addr_i : in std_logic_vector(log2c(DEPTH)-1 downto 0);
        wren_i : in std_logic;
        data_i : in std_logic_vector(WIDTH-1 downto 0);
        data_o : out std_logic_vector(WIDTH-1 downto 0)
    );
begin
end entity generic_ocram;

architecture rtl of generic_ocram is
    type ram_t is protected
        impure function read(addr : integer)
        return std_logic_vector;
        
        impure function write(addr : integer; datum : std_logic_vector)
        return boolean;
    end protected ram_t;
    
    type ram_t is protected body
        type content_t is array (DEPTH-1 downto 0) of std_logic_vector(WIDTH-1 downto 0);
        variable content : content_t;
          
        impure function read(addr : integer)
        return std_logic_vector is
        begin
            return content(addr);
        end function read;
        
        impure function write(addr : integer; datum : std_logic_vector)
        return boolean is
        begin
            content(addr) := datum;
            return TRUE;
        end function write;
    end protected body ram_t;
    
    shared variable ram : ram_t;
    
    signal dummy_unused : boolean;
begin
    
    p_ram: process (clk_i) is
    begin
        if rising_edge(clk_i) then
            if READ_FIRST then
                data_o <= ram.read(to_integer(unsigned(addr_i)));
            end if;
            
            if (wren_i = '1') then
                dummy_unused <= ram.write(to_integer(unsigned(addr_i)), data_i);
            end if;
            
            if not READ_FIRST then
                data_o <= ram.read(to_integer(unsigned(addr_i)));
            end if;
        end if;
    end process p_ram;
    
end architecture rtl;
