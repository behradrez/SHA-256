library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity mux is
port(A_input, B_input : in std_logic_vector(31 downto 0);
		C_input: in std_logic;
		G_output: out std_logic_vector(31 downto 0));
end mux;


architecture implementation of mux is
begin
	G_output<= A_input when C_input='0' else B_input;
end implementation;
