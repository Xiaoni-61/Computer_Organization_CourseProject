library verilog;
use verilog.vl_types.all;
entity M2 is
    port(
        clk             : in     vl_logic;
        WDSel           : in     vl_logic_vector(2 downto 0);
        inn0            : in     vl_logic_vector(31 downto 0);
        inn1            : in     vl_logic_vector(31 downto 0);
        inn2            : in     vl_logic_vector(31 downto 0);
        inn3            : in     vl_logic_vector(31 downto 0);
        inn4            : in     vl_logic_vector(31 downto 0);
        WrData          : out    vl_logic_vector(31 downto 0)
    );
end M2;
