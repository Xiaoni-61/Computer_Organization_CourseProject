library verilog;
use verilog.vl_types.all;
entity M3 is
    port(
        clk             : inout  vl_logic;
        B               : in     vl_logic_vector(31 downto 0);
        imm32           : in     vl_logic_vector(31 downto 0);
        BSel            : in     vl_logic;
        M3out           : out    vl_logic_vector(31 downto 0)
    );
end M3;
