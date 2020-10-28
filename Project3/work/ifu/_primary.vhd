library verilog;
use verilog.vl_types.all;
entity ifu is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        jsome           : in     vl_logic;
        jr              : in     vl_logic;
        npc_sel         : in     vl_logic;
        zero            : in     vl_logic;
        pcc             : out    vl_logic_vector(31 downto 0);
        AOut            : in     vl_logic_vector(31 downto 0);
        code            : out    vl_logic_vector(31 downto 0);
        enpc            : in     vl_logic;
        intctr          : in     vl_logic;
        eret            : in     vl_logic;
        epc             : in     vl_logic_vector(31 downto 0);
        pc1             : out    vl_logic_vector(31 downto 0)
    );
end ifu;
