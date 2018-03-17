library ieee;
    use ieee.math_real.all;
    use ieee.numeric_std.all;
    use ieee.std_logic_1164.all;

package libhdl_util_pkg is
    function clog2(p : positive) return natural;
end package libhdl_util_pkg;

package body libhdl_util_pkg is
    function clog2(p : positive) return natural is
    begin
        return positive(log2(real(p)));
    end function clog2;
end package body libhdl_util_pkg;

