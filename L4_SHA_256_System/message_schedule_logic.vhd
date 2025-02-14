library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL; 



entity message_schedule_logic is
    port(
        message     : in std_logic_vector(31 downto 0);
        round_count : in unsigned(5 downto 0);
        CLK         : in std_logic;
        wt_o        : out std_logic_vector(31 downto 0)
    );
end message_schedule_logic;


architecture behaviour of message_schedule_logic is

signal r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15: std_logic_vector(31 downto 0);
signal mux_selector: std_logic := '1';
signal mux_output: std_logic_vector(31 downto 0);
signal sum: std_logic_vector(31 downto 0);

signal sigma0, sigma1 : std_logic_vector(31 downto 0);


component mux
		port(A_input,B_input: in std_logic_vector(31 downto 0); C_input: in std_logic; G_output: out std_logic_vector(31 downto 0));
end component;



begin 

mux1: mux
port map(A_input => sum, B_input => message, C_input => mux_selector, G_output => mux_output);


wt_o <= mux_output;

sigma0 <= ((r14(6 downto 0) & r14(31 downto 7)) xor (r14(17 downto 0) & r14(31 downto 18)) xor ("000" & r14(31 downto 3)));
sigma1 <= ((r1(16 downto 0) & r1(31 downto 17)) xor (r1(18 downto 0) & r1(31 downto 19)) xor ("0000000000" & r1(31 downto 10)));

sum <= std_logic_vector(unsigned(sigma0) + unsigned(sigma1) + unsigned(r15) + unsigned(r6));

loop_registers: process(CLK)
	begin
	if(rising_edge(CLK)) then
		if(to_integer(round_count) > 15) then
			mux_selector <= '0';
		end if;
		r15 <= r14;
		r14 <= r13;
		r13 <= r12;
		r12 <= r11;
		r11 <= r10;
		r10 <= r9;
		r9 <= r8;
		r8 <= r7;
		r7 <= r6;
		r6 <= r5;
		r5 <= r4;
		r4 <= r3;
		r3 <= r2;
		r2 <= r1;
		r1 <= r0;
		r0 <= mux_output;
	end if;
end process;

end behaviour;