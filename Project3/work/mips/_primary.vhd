library verilog;
use verilog.vl_types.all;
entity mips is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        imout           : in     vl_logic_vector(5 downto 0);
        prRd            : in     vl_logic_vector(31 downto 0);
        prWd            : out    vl_logic_vector(31 downto 0);
        prAddr          : out    vl_logic_vector(31 downto 0);
        devwe           : out    vl_logic
    );
end mips;
