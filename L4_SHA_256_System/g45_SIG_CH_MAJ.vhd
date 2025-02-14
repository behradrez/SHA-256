library ieee; -- allows use of the std_logic_vector type
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- needed if you are using unsigned rotate operations


entity g45_SIG_CH_MAJ is
port ( A_o, B_o, C_o, E_o, F_o, G_o : in std_logic_vector(31 downto 0);
 SIG0, SIG1, CH, MAJ : out std_logic_vector(31 downto 0));
end g45_SIG_CH_MAJ;

architecture behavior of g45_SIG_CH_MAJ is
    signal r2,r13,r22,r6,r11,r25: std_logic_vector(31 downto 0);
    begin

    maj_process : process(A_o, B_o, C_o)
    begin
        MAJ <= ((A_o AND B_o) xor (B_o AND C_o)) xor (C_o AND A_o);
    end process;

    ch_process : process(E_o, F_o,G_o)
    begin
        CH <= (E_o AND F_o) xor (NOT E_o AND G_o);
    end process;

    sig0_process : process(A_o, r2, r13, r22)
    begin
        r2 <= A_o(1 downto 0) & A_o(31 downto 2);
        r13 <= A_o(12 downto 0) & A_o(31 downto 13);
        r22 <= A_o(21 downto 0) & A_o(31 downto 22);
        SIG0 <= (r2 xor r13) xor r22;
    end process;

    sig1_process : process(E_o, r6, r11, r25)
    begin
        r6 <= E_o(5 downto 0) & E_o(31 downto 6);
        r11 <= E_o(10 downto 0) & E_o(31 downto 11);
        r25 <= E_o(24 downto 0) & E_o(31 downto 25);
        SIG1 <= (r6 xor r11) xor r25;
    end process;

end behavior;

