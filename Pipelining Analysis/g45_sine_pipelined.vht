-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "04/02/2024 00:36:38"
                                                            
-- Vhdl Test Bench template for design  :  g45_sine
-- 
-- Simulation tool : QuestaSim (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                
use ieee.numeric_std.all;

ENTITY g45_sine_pipelined_vhd_tst IS
END g45_sine_pipelined_vhd_tst;
ARCHITECTURE g45_sine_pipelined_arch OF g45_sine_pipelined_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL clk : STD_LOGIC;
SIGNAL x : UNSIGNED(12 DOWNTO 0);
SIGNAL y: UNSIGNED(12 DOWNTO 0);
COMPONENT g45_sine_pipelined
	PORT (
	clk : IN STD_LOGIC;
	x : IN UNSIGNED(12 DOWNTO 0);
	y: BUFFER UNSIGNED(12 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : g45_sine_pipelined
	PORT MAP (
-- list connections between master ports and signals
	clk => clk,
	x => x,
	y => y
	);
init : PROCESS                                               
-- variable declarations                                     
BEGIN                                                        
        -- code that executes only once                      
WAIT;                                                       
END PROCESS init;                                           
always : PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
BEGIN    
			wait for 5 ns;
			clk <='1';
			wait for 5 ns;
			clk <= '0';
			x <= to_unsigned(8191,13);
			wait for 5 ns;
			clk <='1';
			wait for 5 ns;
			clk <= '0';
			x <= to_unsigned(4096, 13);
			wait for 5 ns;
			clk <='1';
			wait for 5 ns;
			clk <= '0';
			x <= to_unsigned(2048, 13);
			wait for 5 ns;
			clk <='1';
			wait for 5 ns;
			clk <= '0';
			x <= to_unsigned(0,13);
			wait for 5 ns;
			clk <='1';
			wait for 5 ns;
			clk <= '0';
			x <= to_unsigned(100, 13);
			wait for 5 ns;
			clk <='1';
			wait for 5 ns;
			clk <= '0';
			wait for 5 ns;
			clk <='1';
			wait for 5 ns;
			clk <= '0';
			wait for 5 ns;
			clk <='1';
			wait for 5 ns;
			clk <= '0';
			wait for 5 ns;
			clk <='1';
			wait for 5 ns;
			clk <= '0';
			wait for 5 ns;
			clk <='1';
			wait for 5 ns;
			clk <= '0';
			wait for 5 ns;
			clk <='1';
			wait for 5 ns;
			clk <= '0';
			wait for 5 ns;
			clk <='1';
			wait for 5 ns;
			clk <= '0';
			wait for 5 ns;
			clk <='1';
			wait for 5 ns;
			clk <= '0';
			wait for 5 ns;
			clk <='1';
			wait for 5 ns;
			clk <= '0';
			wait for 5 ns;
			clk <='1';
			wait for 5 ns;
			clk <= '0';
			wait for 5 ns;
			clk <='1';
			wait for 5 ns;
			clk <= '0';
			wait for 5 ns;
			clk <='1';
			wait for 5 ns;
			clk <= '0';

						

			
WAIT;                                                        
END PROCESS always;                                          
END g45_sine_pipelined_arch;
