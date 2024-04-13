library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity g45_sine is
port(	x_in : in unsigned(12 downto 0);
		clk : in std_logic;
		y_out: out unsigned(12 downto 0));
end g45_sine;


architecture behaviour of g45_sine is
signal x_reg, y_reg: unsigned(12 downto 0);

signal constA : unsigned(31 downto 0) := x"C8EC8A4B";
signal constB : unsigned(31 downto 0) := x"A3B2292C";
signal constC : unsigned(31 downto 0) := x"00047645";

signal tmpy,tmpy2,tmpy3,tmpy4,tmpy5,tmpy6,tmpy7 : unsigned(31 downto 0);
signal unsignedX : unsigned(12 downto 0);


begin
	
	unsignedx <= unsigned(x_in);
	--Storing in register on change
	store_vals: process(clk, x_in, tmpy7)
		begin
		x_reg<=unsignedx;
		y_reg <= tmpy7(12 downto 0);
	end process;
	
	--Actual math
	tmpy <= resize((constC*resize(unsignedx,32)) srl 13,32);
	tmpy2 <= resize(constB - ((resize(unsignedx,32) * tmpy) srl 3),32);
	tmpy3 <= resize(resize(unsignedx,32) * (tmpy2 srl 13),32);
	tmpy4 <= resize(resize(unsignedx,32) * (tmpy3 srl 13),32);
	tmpy5 <= resize(constA - (tmpy4 srl 1),32);
	tmpy6 <= resize(resize(unsignedx,32) * (tmpy5 srl 13),32);
	tmpy7 <= resize(((tmpy6 +(to_unsigned(1,32) sll 18)) srl 18 )- 1,32) ;
	
	y_out <= tmpy7(12 downto 0);
	
end behaviour;

 
