library verilog;
use verilog.vl_types.all;
entity doutchange is
    port(
        addr            : in     vl_logic_vector(9 downto 0);
        dout            : in     vl_logic_vector(31 downto 0);
        doutt           : out    vl_logic_vector(31 downto 0);
        lb              : in     vl_logic
    );
end doutchange;
