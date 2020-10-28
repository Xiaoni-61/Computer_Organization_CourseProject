library verilog;
use verilog.vl_types.all;
entity bridge is
    port(
        prAddr          : in     vl_logic_vector(31 downto 0);
        prRd            : out    vl_logic_vector(31 downto 0);
        prWd            : in     vl_logic_vector(31 downto 0);
        dev0_Rd         : in     vl_logic_vector(31 downto 0);
        dev1_Rd         : in     vl_logic_vector(31 downto 0);
        dev2_Rd         : in     vl_logic_vector(31 downto 0);
        dev_Wd          : out    vl_logic_vector(31 downto 0);
        dev_addr        : out    vl_logic_vector(31 downto 0);
        irqin0          : in     vl_logic;
        imout           : out    vl_logic_vector(5 downto 0);
        wein            : in     vl_logic;
        weout0          : out    vl_logic;
        weout2          : out    vl_logic
    );
end bridge;
