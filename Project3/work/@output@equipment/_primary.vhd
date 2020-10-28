library verilog;
use verilog.vl_types.all;
entity OutputEquipment is
    port(
        clk             : in     vl_logic;
        we              : in     vl_logic;
        addr            : in     vl_logic_vector(3 downto 2);
        datain          : in     vl_logic_vector(31 downto 0);
        dsout           : out    vl_logic_vector(31 downto 0)
    );
end OutputEquipment;
