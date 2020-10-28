library verilog;
use verilog.vl_types.all;
entity CP0 is
    port(
        epcin           : in     vl_logic_vector(31 downto 0);
        din             : in     vl_logic_vector(31 downto 0);
        hwint           : in     vl_logic_vector(5 downto 0);
        sel             : in     vl_logic_vector(4 downto 0);
        wen             : in     vl_logic;
        exlset          : in     vl_logic;
        exlclr          : in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        intreq          : out    vl_logic;
        epcstr          : out    vl_logic_vector(31 downto 0);
        dout            : out    vl_logic_vector(31 downto 0)
    );
end CP0;
