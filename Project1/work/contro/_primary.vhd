library verilog;
use verilog.vl_types.all;
entity contro is
    port(
        clk             : in     vl_logic;
        code            : in     vl_logic_vector(31 downto 0);
        Zero            : in     vl_logic;
        ALU_OP          : out    vl_logic_vector(2 downto 0);
        WDSel           : out    vl_logic_vector(1 downto 0);
        GPRSel          : out    vl_logic_vector(1 downto 0);
        ExtOp           : out    vl_logic_vector(1 downto 0);
        GPRWr           : out    vl_logic;
        BSel            : out    vl_logic;
        DMWr            : out    vl_logic;
        jsome           : out    vl_logic;
        npc_sel         : out    vl_logic;
        jr              : out    vl_logic;
        jal             : out    vl_logic;
        sb              : out    vl_logic;
        lb              : out    vl_logic
    );
end contro;
