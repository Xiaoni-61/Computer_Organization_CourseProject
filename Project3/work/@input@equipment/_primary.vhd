library verilog;
use verilog.vl_types.all;
entity InputEquipment is
    port(
        inn             : in     vl_logic_vector(31 downto 0);
        addr            : in     vl_logic_vector(3 downto 2);
        keyout          : out    vl_logic_vector(31 downto 0)
    );
end InputEquipment;
