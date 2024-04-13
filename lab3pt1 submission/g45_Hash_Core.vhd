

--entity name: g45_Hash_Core

--Authors: Behrad Rezaie & Mahmoud Amin
--Date: March 30, 2024

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity g45_Hash_Core is
port (A_o, B_o, C_o, D_o, E_o, F_o, G_o, H_o : inout std_logic_vector(31 downto 0);
		A_i, B_i, C_i, D_i, E_i, F_i, G_i, H_i : in std_logic_vector(31 downto 0);
		Kt_i, Wt_i : in std_logic_vector(31 downto 0);
		LD, CLK : in std_logic);
		


end g45_Hash_Core;



architecture behaviour of g45_Hash_Core is

	signal a,b,c,d,e,f,g,h: std_logic_vector(31 downto 0);
	signal a_sum, e_sum: unsigned(31 downto 0);
	signal sSIG0, sSIG1, sCH, sMAJ: std_logic_vector(31 downto 0);
	signal bottom_sum: unsigned(31 downto 0);
	signal a_reg, b_reg, c_reg, d_reg, e_reg, f_reg, g_reg, h_reg: std_logic_vector(31 downto 0);
	
	--component declarations
	component mux
		port(A_input,B_input: in std_logic_vector(31 downto 0); C_input: in std_logic; G_output: out std_logic_vector(31 downto 0));
	end component;

	component g45_SIG_CH_MAJ
	port ( A_o, B_o, C_o, E_o, F_o, G_o : in std_logic_vector(31 downto 0);
	 SIG0, SIG1, CH, MAJ : out std_logic_vector(31 downto 0));
	end component;


	begin

	--summing operations
	bottom_sum<= unsigned(sCH) + unsigned(Kt_i) + unsigned(Wt_i) + unsigned(sSIG1);
	e_sum <= unsigned(d) + bottom_sum;
	a_sum <= unsigned(sMAJ) + unsigned(sSIG0) + bottom_sum;
	
	--inout assignments from registers
	A_o <= a_reg;
	B_o <= b_reg;
	C_o <= c_reg;
	D_o <= d_reg;
	E_o <= e_reg;
	F_o <= f_reg;
	G_o <= g_reg;
	H_o <= h_reg;
	
	feedRegisters: process(CLK)
	begin
		if(rising_edge(CLK)) then
			a_reg <= a;
			b_reg <= b;
			c_reg <= c;
			d_reg <= d;
			e_reg <= e;
			f_reg <= f;
			g_reg <= g;
			h_reg <= h;
		end if;
	end process;
		
	
	--component instantiations
	hash_funcs: g45_SIG_CH_MAJ
	port map(A_o => a_reg,
				B_o => b_reg,
				C_o => c_reg,
				E_o => e_reg,
				F_o => f_reg,
				G_o => g_reg,
				SIG0 => sSIG0,
				SIG1 => sSig1,
				MAJ => sMAJ,
				CH => sCH);
	a_mux: mux
	port map(A_input => std_logic_vector(a_sum),
				B_input => A_i,
				C_input => LD,
				G_output => a);
	b_mux: mux
	port map(A_input => A_o,
				B_input => B_i,
				C_input => LD,
				G_output => b);
	c_mux: mux
	port map(A_input => B_o,
				B_input => C_i,
				C_input => LD,
				G_output => c);
	d_mux: mux
	port map(A_input => C_o,
				B_input => D_i,
				C_input => LD,
				G_output => d);
	e_mux: mux
	port map(A_input => std_logic_vector(e_sum),
				B_input => E_i,
				C_input => LD,
				G_output => e);
	f_mux: mux
	port map(A_input => E_o,
				B_input => F_i,
				C_input => LD,
				G_output => f);
	g_mux: mux
	port map(A_input => F_o,
				B_input => G_i,
				C_input => LD,
				G_output => g);
	h_mux: mux
	port map(A_input => G_o,
				B_input => H_i,
				C_input => LD,
				G_output => h);

	
end behaviour;