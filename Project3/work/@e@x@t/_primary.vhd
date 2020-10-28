library verilog;
use verilog.vl_types.all;
entity EXT is
    port(
        clk             : in     vl_logic;
        imm16           : in     vl_logic_vector(15 downto 0);
        imm32           : out    vl_logic_vector(31 downto 0);
        ExtOp           : in     vl_logic_vector(1 downto 0)
    );
end EXT;
