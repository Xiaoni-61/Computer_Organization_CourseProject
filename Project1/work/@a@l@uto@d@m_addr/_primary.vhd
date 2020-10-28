library verilog;
use verilog.vl_types.all;
entity ALUtoDM_addr is
    port(
        ALUout          : in     vl_logic_vector(31 downto 0);
        addr            : out    vl_logic_vector(9 downto 0)
    );
end ALUtoDM_addr;
