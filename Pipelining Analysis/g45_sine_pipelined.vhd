library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity g45_sine_pipelined is
port( clk: in std_logic;
		x: in unsigned(12 downto 0);
		y: out unsigned(12 downto 0));
end g45_sine_pipelined;

architecture behaviour of g45_sine_pipelined is

signal constA : unsigned(31 downto 0) := x"C8EC8A4B";
signal constB : unsigned(31 downto 0) := x"A3B2292C";
signal constC : unsigned(31 downto 0) := x"00047645";

signal reg1, reg2, reg3, reg4, reg5, reg6, reg7 : unsigned(31 downto 0);
signal x_input,x2,x3,x4,x5,x6 : unsigned(12 downto 0);

begin
	y<= reg7(12 downto 0);

	process(CLK)
	begin
		if rising_edge(clk) then
			x_input <= x;
			reg1 <= resize((constC*resize(x_input,32)) srl 13,32);
			x2 <= x_input;
			reg2 <= resize(constB - ((resize(x2,32) * reg1) srl 3),32);
			x3 <= x2;
			reg3 <= resize(resize(x3,32) * (reg2 srl 13),32);
			x4 <=x3;
			reg4 <= resize(resize(x4,32) * (reg3 srl 13),32);
			x5 <= x4;
			reg5 <= resize(constA - (reg4 srl 1),32);
			x6 <= x5;
			reg6 <= resize(resize(x6,32) * (reg5 srl 13),32);
			reg7 <= resize(((reg6+(to_unsigned(1,32) sll 18)) srl 18)-1,32);
		end if;
	end process;

end behaviour;