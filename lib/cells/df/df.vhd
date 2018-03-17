
library ieee;
    use ieee.numeric_std.all;
    use ieee.std_logic_1164.all;

package df_pkg is
    type t_df_init_behavior is (NONE, RESET, PRESET, SET, CLEAR);

    component df is
        generic (
            INIT_CTL_POLARITY : std_logic := '1';
            INIT_BEHAVIOR     : t_df_init_behavior := NONE;
            INIT_VALUE        : std_logic := 'U';
            USE_CE            : boolean := FALSE
        );
        port (
            clk_i : in std_logic;
            rst_i : in std_logic;
            pst_i : in std_logic;
            set_i : in std_logic;
            clr_i : in std_logic;
            ce_i  : in std_logic;
            d_i   : in std_logic;
            q_o   : out std_logic
        );
    end component df;
end package df_pkg;


library ieee;
    use ieee.numeric_std.all;
    use ieee.std_logic_1164.all;
library work;
    use work.df_pkg.all;

entity df is
    generic (
        INIT_CTL_POLARITY : std_logic := '1';
        INIT_BEHAVIOR     : t_df_init_behavior := NONE;
        INIT_VALUE        : std_logic := 'U';
        USE_CE            : boolean := FALSE
    );
    port (
        clk_i : in std_logic;
        rst_i : in std_logic := not INIT_CTL_POLARITY;
        pst_i : in std_logic := not INIT_CTL_POLARITY;
        set_i : in std_logic := not INIT_CTL_POLARITY;
        clr_i : in std_logic := not INIT_CTL_POLARITY;
        ce_i  : in std_logic;
        d_i   : in std_logic;
        q_o   : out std_logic
    );
end entity df;


architecture rtl of df is
    signal q : std_logic := INIT_VALUE;
begin
    p_main: process (clk_i, rst_i, pst_i) is
    begin
        if (INIT_BEHAVIOR = RESET and rst_i = INIT_CTL_POLARITY) then
            q <= '0';
        elsif (INIT_BEHAVIOR = PRESET and pst_i = INIT_CTL_POLARITY) then
            q <= '1';
        elsif rising_edge(clk_i) then
            if (INIT_BEHAVIOR = SET and set_i = INIT_CTL_POLARITY) then
                q <= '1';
            elsif (INIT_BEHAVIOR = CLEAR and clr_i = INIT_CTL_POLARITY) then
                q <= '0';
            elsif (USE_CE and ce_i = '1') then
                q <= d_i;
            elsif (not USE_CE) then
                q <= d_i;
            end if;
        end if;
    end process p_main;

    q_o <= q;
end architecture rtl;
