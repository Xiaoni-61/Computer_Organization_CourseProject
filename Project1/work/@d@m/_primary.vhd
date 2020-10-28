library verilog;
use verilog.vl_types.all;
entity DM is
    port(
        DMWr            : in     vl_logic;
        Addr            : in     vl_logic_vector(31 downto 0);
        WrData          : in     vl_logic_vector(31 downto 0);
        ReData          : out    vl_logic_vector(31 downto 0);
        lb              : in     vl_logic
    );
end DM;
