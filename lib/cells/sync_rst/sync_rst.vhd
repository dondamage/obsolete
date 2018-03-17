library ieee;
    use ieee.numeric_std.all;
    use ieee.std_logic_1164.all;

package sync_rst_pkg is
    component sync_rst is
        generic (
            N_SYNC_FFS   : integer := 2;
            RST_POLARITY : std_logic := '1'
        );
        port (
            arst_i : in std_logic;
            sclk_i  : in std_logic;
            srst_o  : out std_logic;
        );
    end component sync_rst;
end package sync_rst_pkg;


library ieee;
    use ieee.numeric_std.all;
    use ieee.std_logic_1164.all;

entity sync_rst is
    generic (
        N_SYNC_FFS   : integer := 2;
        RST_POLARITY : std_logic := '1'
    );
    port (
        arst_i : in std_logic;
        sclk_i : in std_logic;
        srst_o : out std_logic;
    );
begin
    assert N_SYNC_FFS >= 2
    report "Entity sync_rst: Invalid generic value."
    severity ERROR;
end entity sync_rst;


architecture rtl of sync_rst is
    signal srst_ffs : std_logic_vector(N_SYNC_FFS-1 downto 0);
begin

    p_sync_rst: process (sclk_i, arst_i) is
    begin
        if (arst_i = RST_POLARITY) then
            srst_ffs <= (others => RST_POLARITY);
        elsif (rising_edge(sclk_i)) then
            srst_ffs <= srst_ffs(N_SYNC_FFS-2 downto 0) & not RST_POLARITY;
        end if;
    end process p_sync_rst;

    srst_o <= srst_ffs(N_SYNC_FFS-1);

end architecture rtl;

