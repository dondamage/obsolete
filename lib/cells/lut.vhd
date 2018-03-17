
library ieee;
    use ieee.numeric_std.all;
    use ieee.std_logic_1164.all;

package lut_pkg is
end package lut_pkg;


library ieee;
    use ieee.numeric_std.all;
    use ieee.std_logic_1164.all;

entity lut is
    generic (
        N       : integer;
        I_WIDTH : integer;
        LUT     : std_logic_vector := (N-1 downto 0 => (I_WIDTH-1 downto 0 = > '0'))
    );
    port (
        I : in std_logic_vector(N-1 downto 0);
        O : out std_logic
    );
end entity lut;


architecture rtl of lut is
begin
    O <= LUTIO_LOGIC(I);
end architecture rtl;
