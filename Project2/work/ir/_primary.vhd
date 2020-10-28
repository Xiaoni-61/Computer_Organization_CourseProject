library verilog;
use verilog.vl_types.all;
entity ir is
    port(
        irin            : in     vl_logic_vector(31 downto 0);
        imm             : out    vl_logic_vector(15 downto 0);
        rs              : out    vl_logic_vector(31 downto 0);
        rt              : out    vl_logic_vector(31 downto 0);
        rd              : out    vl_logic_vector(31 downto 0);
        jadd            : out    vl_logic_vector(25 downto 0)
    );
end ir;
