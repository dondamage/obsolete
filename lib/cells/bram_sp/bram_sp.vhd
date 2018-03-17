

library work;
    use work.numeric_std.all;
    use work.std_logic_1164.all;

entity bram_sp is
    generic (
        RAM_DEPTH      : integer := 1024;
        RAM_WIDTH      : integer := 8;
        RAM_RDWR_ORDER : string := "READ_FIRST"; -- {READ_FIRST, WRITE_FIRST}
        RAM_INIT       : string := "DEFAULT"; -- {DEFAULT, INIT_DATA, INIT_FILE}
        RAM_INIT_DATA  : std_logic_vector(RAM_DEPTH*RAM_WIDTH-1 downto 0) :=
          (others => '0');
        RAM_INIT_FILE  : string
    );
    port (
        clk_i    : std_logic;
        wraddr_i : std_logic_vector(clog2(RAM_DEPTH)-1 downto 0);
        wren_i   : std_logic;
        wrdata_i : std_logic_vector(RAM_WIDTH-1 downto 0);
        rdaddr_i : std_logic_vector(clog2(RAM_DEPTH)-1 downto 0);
        rddata_o : std_logic_vector(RAM_WIDTH-1 downto 0)
    );
end entity bram_sp;

architecture rtl of bram_sp is

    type ram_t is array 0 to RAM_DEPTH-1 of std_logic_vector(RAM_WIDTH-1 downto 0);

    function initialize_ram(
        init_type : string;
        init_data : std_logic_vector;
        init_file : string
    ) return ram_t is
        variable reval : ram_t;
    begin
        case init_type is
            when "INIT_DATA" =>
                for i in 0 to RAM_DEPTH-1 loop
                    reval(i) := RAM_INIT_DATA((i+1)*RAM_WIDTH-1 downto i*RAM_WIDTH);
                end loop;
            when "INIT_FILE" =>
                
            when others =>
                reval := (others => 'U');
        end case;
        return reval;
    end function initialize_ram;

    shared variable ram : ram_t := initialize_ram(RAM_INIT, RAM_INIT_DATA, RAM_INIT_FILE);

begin

    p_bram_sp: process (clk_i) is
        variable wraddr_int : integer;
        variable rdaddr_int : integer;
    begin
        if rising_edge(clk_i) then
            wraddr_int := to_integer(unsigned(wraddr_i));
            if (RAM_RDWR_ORDER = "READ_FIRST") then
                rddata_o <= ram(rdaddr_int);
            end if;
            if (wren_i = '1') then
                ram(wraddr_int) := wrdata_i;
            end if;
            if (RAM_RDWR_ORDER = "WRITE_FIRST") then
                rddata_o <= ram(rdaddr_int);
            end if;
        end if;
    end process p_bram_sp;

end architecture rtl;

