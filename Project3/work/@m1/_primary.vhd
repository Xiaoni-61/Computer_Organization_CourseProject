library verilog;
use verilog.vl_types.all;
entity M1 is
    port(
        clk             : in     vl_logic;
        GPRSel          : in     vl_logic_vector(1 downto 0);
        in0             : in     vl_logic_vector(31 downto 0);
        in1             : in     vl_logic_vector(31 downto 0);
        in2             : in     vl_logic_vector(31 downto 0);
        WrReg           : out    vl_logic_vector(31 downto 0)
    );
end M1;
