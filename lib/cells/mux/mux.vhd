library ieee;
    use ieee.numeric_std.all;
    use ieee.std_logic_1164.all;

library work;
    use work.libhdl_types_pkg.all;

package mux_pkg is
    component mux is
        generic (
            N_INPUTS   : integer := 2;
            DATA_WIDTH : integer := 8;
            LATENCY    : integer := 0
        );
        port (
            clk_i  : in  std_logic;
            ena_i  : in  std_logic;
            data_i : in  std_logic_vector(N_INPUTS*DATA_WIDTH-1 downto 0);
            sel_i  : in  std_logic_vector(clog2(N_INPUTS)-1 downto 0);
            data_o : out std_logic_vector(DATA_WIDTH-1 downto 0)
        );
    end component mux;
end package mux_pkg;


library ieee;
    use ieee.numeric_std.all;
    use ieee.std_logic_1164.all;

library work;
    use work.libhdl_types_pkg.all;

entity mux is
    generic (
        N_INPUTS   : integer := 2;
        DATA_WIDTH : integer := 8;
        LATENCY    : natural := 0
    );
    port (
        clk_i  : in  std_logic;
        ena_i  : in  std_logic;
        data_i : in  std_logic_vector(N_INPUTS*DATA_WIDTH-1 downto 0);
        sel_i  : in  std_logic_vector(clog2(N_INPUTS)-1 downto 0);
        data_o : out std_logic_vector(DATA_WIDTH-1 downto 0)
    );
end entity mux;

architecture rtl of mux is
    signal data_intermediate : std_logic_vector;
    signal data_o_int : std_logic_vector(DATA_WIDTH-1 downto 0);
begin

    data_o <= data_o_int;

    g_mux_comb: if (LATENCY = 0) generate
        p_mux_comb: process (data_i, sel_i) is
            variable sel_int : integer;
        begin
            sel_int := to_integer(unsigned(sel_i));
            data_o_int <= data_i((sel_int+1)*DATA_WIDTH-1 downto sel_int*DATA_WIDTH);
        end process p_mux_comb;
    end generate g_mux_comb;

    g_mux_clkd: if (LATENCY > 0) generate
        p_mux_clkd: process (clk_i) is
            variable sel_int : integer;
        begin
            if rising_edge(clk_i) then
                for i in LATENCY downto 1 loop
                    sel_int := to_integer(unsigned(sel_i))/i;
                    data_intermediate <= data;
                end loop;
                data_o_int <= data_intermediate(sel_int);
            end if;
        end process p_mux_clkd;
    end generate g_mux_clkd;
end architecture rtl;

