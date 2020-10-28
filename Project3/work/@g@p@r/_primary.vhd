library verilog;
use verilog.vl_types.all;
entity GPR is
    port(
        clk             : in     vl_logic;
        ReadR1          : in     vl_logic_vector(31 downto 0);
        ReadR2          : in     vl_logic_vector(31 downto 0);
        WrR             : in     vl_logic_vector(31 downto 0);
        WrData          : in     vl_logic_vector(31 downto 0);
        GPRWr           : in     vl_logic;
        A               : out    vl_logic_vector(31 downto 0);
        B               : out    vl_logic_vector(31 downto 0);
        \of\            : in     vl_logic
    );
end GPR;
