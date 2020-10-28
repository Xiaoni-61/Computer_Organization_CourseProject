library verilog;
use verilog.vl_types.all;
entity \IF\ is
    port(
        clk             : in     vl_logic;
        \of\            : in     vl_logic;
        jal             : in     vl_logic;
        \out\           : out    vl_logic_vector(31 downto 0)
    );
end \IF\;
