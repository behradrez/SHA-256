

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
	---- LAB 4 CONSTANT ARRAY -------
	type constant_array is array(0 to 63) of std_logic_vector(31 downto 0);
	constant Kt : constant_array := ( x"428a2f98", x"71374491", x"b5c0fbcf", x"e9b5dba5",
	x"3956c25b", x"59f111f1", x"923f82a4", x"ab1c5ed5", x"d807aa98", x"12835b01",
	x"243185be", x"550c7dc3", x"72be5d74", x"80deb1fe", x"9bdc06a7", x"c19bf174",
	x"e49b69c1", x"efbe4786", x"0fc19dc6", x"240ca1cc", x"2de92c6f", x"4a7484aa",
	x"5cb0a9dc", x"76f988da", x"983e5152", x"a831c66d", x"b00327c8", x"bf597fc7",
	x"c6e00bf3", x"d5a79147", x"06ca6351", x"14292967", x"27b70a85", x"2e1b2138",
	x"4d2c6dfc", x"53380d13", x"650a7354", x"766a0abb", x"81c2c92e", x"92722c85",
	x"a2bfe8a1", x"a81a664b", x"c24b8b70", x"c76c51a3", x"d192e819", x"d6990624",
	x"f40e3585", x"106aa070", x"19a4c116", x"1e376c08", x"2748774c", x"34b0bcb5",
	x"391c0cb3", x"4ed8aa4a", x"5b9cca4f", x"682e6ff3", x"748f82ee", x"78a5636f",
	x"84c87814", x"8cc70208", x"90befffa", x"a4506ceb", x"bef9a3f7", x"c67178f2"
	);
	---------------------------------
	
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