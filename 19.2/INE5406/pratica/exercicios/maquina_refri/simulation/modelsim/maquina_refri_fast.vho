-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 64-Bit"
-- VERSION "Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Web Edition"

-- DATE "10/10/2019 09:19:05"

-- 
-- Device: Altera EP2C35F672C6 Package FBGA672
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY CYCLONEII;
LIBRARY IEEE;
USE CYCLONEII.CYCLONEII_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	maquina_refri IS
    PORT (
	Reset : IN std_logic;
	clk : IN std_logic;
	c : IN std_logic;
	s : IN std_logic_vector(7 DOWNTO 0);
	a : IN std_logic_vector(7 DOWNTO 0);
	d : OUT std_logic
	);
END maquina_refri;

-- Design Ports Information
-- d	=>  Location: PIN_W25,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- s[7]	=>  Location: PIN_C13,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- s[6]	=>  Location: PIN_D13,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- s[5]	=>  Location: PIN_Y25,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- s[4]	=>  Location: PIN_AA25,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- s[3]	=>  Location: PIN_T19,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- s[2]	=>  Location: PIN_U22,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- s[1]	=>  Location: PIN_AA26,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- s[0]	=>  Location: PIN_W24,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- c	=>  Location: PIN_W23,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- clk	=>  Location: PIN_P2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- Reset	=>  Location: PIN_P1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- a[7]	=>  Location: PIN_W26,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- a[6]	=>  Location: PIN_V25,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- a[5]	=>  Location: PIN_U21,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- a[4]	=>  Location: PIN_U20,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- a[3]	=>  Location: PIN_V23,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- a[2]	=>  Location: PIN_R19,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- a[1]	=>  Location: PIN_V26,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- a[0]	=>  Location: PIN_V24,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default


ARCHITECTURE structure OF maquina_refri IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_Reset : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL ww_c : std_logic;
SIGNAL ww_s : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_a : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_d : std_logic;
SIGNAL \clk~clkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \Reset~clkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \b_operativo|reg|q[3]~14_combout\ : std_logic;
SIGNAL \clk~combout\ : std_logic;
SIGNAL \clk~clkctrl_outclk\ : std_logic;
SIGNAL \b_controle|estado.INICIO~0_combout\ : std_logic;
SIGNAL \Reset~combout\ : std_logic;
SIGNAL \Reset~clkctrl_outclk\ : std_logic;
SIGNAL \b_controle|estado.INICIO~regout\ : std_logic;
SIGNAL \c~combout\ : std_logic;
SIGNAL \b_operativo|reg|q[0]~8_combout\ : std_logic;
SIGNAL \b_operativo|reg|q[0]~9\ : std_logic;
SIGNAL \b_operativo|reg|q[1]~10_combout\ : std_logic;
SIGNAL \b_operativo|reg|q[1]~11\ : std_logic;
SIGNAL \b_operativo|reg|q[2]~12_combout\ : std_logic;
SIGNAL \b_operativo|reg|q[2]~13\ : std_logic;
SIGNAL \b_operativo|reg|q[3]~15\ : std_logic;
SIGNAL \b_operativo|reg|q[4]~16_combout\ : std_logic;
SIGNAL \b_operativo|reg|q[4]~17\ : std_logic;
SIGNAL \b_operativo|reg|q[5]~19\ : std_logic;
SIGNAL \b_operativo|reg|q[6]~21\ : std_logic;
SIGNAL \b_operativo|reg|q[7]~22_combout\ : std_logic;
SIGNAL \b_operativo|reg|q[6]~20_combout\ : std_logic;
SIGNAL \b_operativo|reg|q[5]~18_combout\ : std_logic;
SIGNAL \b_operativo|men|LessThan0~1_cout\ : std_logic;
SIGNAL \b_operativo|men|LessThan0~3_cout\ : std_logic;
SIGNAL \b_operativo|men|LessThan0~5_cout\ : std_logic;
SIGNAL \b_operativo|men|LessThan0~7_cout\ : std_logic;
SIGNAL \b_operativo|men|LessThan0~9_cout\ : std_logic;
SIGNAL \b_operativo|men|LessThan0~11_cout\ : std_logic;
SIGNAL \b_operativo|men|LessThan0~13_cout\ : std_logic;
SIGNAL \b_operativo|men|LessThan0~14_combout\ : std_logic;
SIGNAL \b_controle|estado~13_combout\ : std_logic;
SIGNAL \b_controle|estado.ACUM~regout\ : std_logic;
SIGNAL \b_controle|estado~12_combout\ : std_logic;
SIGNAL \b_controle|estado.ESPERA~regout\ : std_logic;
SIGNAL \b_controle|estado~11_combout\ : std_logic;
SIGNAL \b_controle|estado.LIBERA~regout\ : std_logic;
SIGNAL \a~combout\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \s~combout\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \b_operativo|reg|q\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \b_controle|ALT_INV_estado.INICIO~regout\ : std_logic;

BEGIN

ww_Reset <= Reset;
ww_clk <= clk;
ww_c <= c;
ww_s <= s;
ww_a <= a;
d <= ww_d;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\clk~clkctrl_INCLK_bus\ <= (gnd & gnd & gnd & \clk~combout\);

\Reset~clkctrl_INCLK_bus\ <= (gnd & gnd & gnd & \Reset~combout\);
\b_controle|ALT_INV_estado.INICIO~regout\ <= NOT \b_controle|estado.INICIO~regout\;

-- Location: LCFF_X64_Y10_N7
\b_operativo|reg|q[3]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \b_operativo|reg|q[3]~14_combout\,
	aclr => \b_controle|ALT_INV_estado.INICIO~regout\,
	ena => \b_controle|estado.ACUM~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \b_operativo|reg|q\(3));

-- Location: LCCOMB_X64_Y10_N6
\b_operativo|reg|q[3]~14\ : cycloneii_lcell_comb
-- Equation(s):
-- \b_operativo|reg|q[3]~14_combout\ = (\b_operativo|reg|q\(3) & ((\a~combout\(3) & (\b_operativo|reg|q[2]~13\ & VCC)) # (!\a~combout\(3) & (!\b_operativo|reg|q[2]~13\)))) # (!\b_operativo|reg|q\(3) & ((\a~combout\(3) & (!\b_operativo|reg|q[2]~13\)) # 
-- (!\a~combout\(3) & ((\b_operativo|reg|q[2]~13\) # (GND)))))
-- \b_operativo|reg|q[3]~15\ = CARRY((\b_operativo|reg|q\(3) & (!\a~combout\(3) & !\b_operativo|reg|q[2]~13\)) # (!\b_operativo|reg|q\(3) & ((!\b_operativo|reg|q[2]~13\) # (!\a~combout\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \b_operativo|reg|q\(3),
	datab => \a~combout\(3),
	datad => VCC,
	cin => \b_operativo|reg|q[2]~13\,
	combout => \b_operativo|reg|q[3]~14_combout\,
	cout => \b_operativo|reg|q[3]~15\);

-- Location: PIN_D13,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\s[6]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_s(6),
	combout => \s~combout\(6));

-- Location: PIN_Y25,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\s[5]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_s(5),
	combout => \s~combout\(5));

-- Location: PIN_AA25,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\s[4]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_s(4),
	combout => \s~combout\(4));

-- Location: PIN_W24,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\s[0]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_s(0),
	combout => \s~combout\(0));

-- Location: PIN_U20,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\a[4]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_a(4),
	combout => \a~combout\(4));

-- Location: PIN_R19,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\a[2]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_a(2),
	combout => \a~combout\(2));

-- Location: PIN_V26,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\a[1]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_a(1),
	combout => \a~combout\(1));

-- Location: PIN_V24,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\a[0]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_a(0),
	combout => \a~combout\(0));

-- Location: PIN_P2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\clk~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_clk,
	combout => \clk~combout\);

-- Location: CLKCTRL_G3
\clk~clkctrl\ : cycloneii_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \clk~clkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \clk~clkctrl_outclk\);

-- Location: LCCOMB_X64_Y10_N28
\b_controle|estado.INICIO~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \b_controle|estado.INICIO~0_combout\ = !\b_controle|estado.LIBERA~regout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \b_controle|estado.LIBERA~regout\,
	combout => \b_controle|estado.INICIO~0_combout\);

-- Location: PIN_P1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\Reset~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_Reset,
	combout => \Reset~combout\);

-- Location: CLKCTRL_G1
\Reset~clkctrl\ : cycloneii_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \Reset~clkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \Reset~clkctrl_outclk\);

-- Location: LCFF_X64_Y10_N29
\b_controle|estado.INICIO\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \b_controle|estado.INICIO~0_combout\,
	aclr => \Reset~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \b_controle|estado.INICIO~regout\);

-- Location: PIN_W23,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\c~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_c,
	combout => \c~combout\);

-- Location: PIN_W26,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\a[7]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_a(7),
	combout => \a~combout\(7));

-- Location: PIN_V25,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\a[6]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_a(6),
	combout => \a~combout\(6));

-- Location: PIN_U21,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\a[5]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_a(5),
	combout => \a~combout\(5));

-- Location: PIN_V23,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\a[3]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_a(3),
	combout => \a~combout\(3));

-- Location: LCCOMB_X64_Y10_N0
\b_operativo|reg|q[0]~8\ : cycloneii_lcell_comb
-- Equation(s):
-- \b_operativo|reg|q[0]~8_combout\ = (\a~combout\(0) & (\b_operativo|reg|q\(0) $ (VCC))) # (!\a~combout\(0) & (\b_operativo|reg|q\(0) & VCC))
-- \b_operativo|reg|q[0]~9\ = CARRY((\a~combout\(0) & \b_operativo|reg|q\(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110011010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \a~combout\(0),
	datab => \b_operativo|reg|q\(0),
	datad => VCC,
	combout => \b_operativo|reg|q[0]~8_combout\,
	cout => \b_operativo|reg|q[0]~9\);

-- Location: LCFF_X64_Y10_N1
\b_operativo|reg|q[0]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \b_operativo|reg|q[0]~8_combout\,
	aclr => \b_controle|ALT_INV_estado.INICIO~regout\,
	ena => \b_controle|estado.ACUM~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \b_operativo|reg|q\(0));

-- Location: LCCOMB_X64_Y10_N2
\b_operativo|reg|q[1]~10\ : cycloneii_lcell_comb
-- Equation(s):
-- \b_operativo|reg|q[1]~10_combout\ = (\a~combout\(1) & ((\b_operativo|reg|q\(1) & (\b_operativo|reg|q[0]~9\ & VCC)) # (!\b_operativo|reg|q\(1) & (!\b_operativo|reg|q[0]~9\)))) # (!\a~combout\(1) & ((\b_operativo|reg|q\(1) & (!\b_operativo|reg|q[0]~9\)) # 
-- (!\b_operativo|reg|q\(1) & ((\b_operativo|reg|q[0]~9\) # (GND)))))
-- \b_operativo|reg|q[1]~11\ = CARRY((\a~combout\(1) & (!\b_operativo|reg|q\(1) & !\b_operativo|reg|q[0]~9\)) # (!\a~combout\(1) & ((!\b_operativo|reg|q[0]~9\) # (!\b_operativo|reg|q\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \a~combout\(1),
	datab => \b_operativo|reg|q\(1),
	datad => VCC,
	cin => \b_operativo|reg|q[0]~9\,
	combout => \b_operativo|reg|q[1]~10_combout\,
	cout => \b_operativo|reg|q[1]~11\);

-- Location: LCFF_X64_Y10_N3
\b_operativo|reg|q[1]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \b_operativo|reg|q[1]~10_combout\,
	aclr => \b_controle|ALT_INV_estado.INICIO~regout\,
	ena => \b_controle|estado.ACUM~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \b_operativo|reg|q\(1));

-- Location: LCCOMB_X64_Y10_N4
\b_operativo|reg|q[2]~12\ : cycloneii_lcell_comb
-- Equation(s):
-- \b_operativo|reg|q[2]~12_combout\ = ((\a~combout\(2) $ (\b_operativo|reg|q\(2) $ (!\b_operativo|reg|q[1]~11\)))) # (GND)
-- \b_operativo|reg|q[2]~13\ = CARRY((\a~combout\(2) & ((\b_operativo|reg|q\(2)) # (!\b_operativo|reg|q[1]~11\))) # (!\a~combout\(2) & (\b_operativo|reg|q\(2) & !\b_operativo|reg|q[1]~11\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110001110",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \a~combout\(2),
	datab => \b_operativo|reg|q\(2),
	datad => VCC,
	cin => \b_operativo|reg|q[1]~11\,
	combout => \b_operativo|reg|q[2]~12_combout\,
	cout => \b_operativo|reg|q[2]~13\);

-- Location: LCFF_X64_Y10_N5
\b_operativo|reg|q[2]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \b_operativo|reg|q[2]~12_combout\,
	aclr => \b_controle|ALT_INV_estado.INICIO~regout\,
	ena => \b_controle|estado.ACUM~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \b_operativo|reg|q\(2));

-- Location: LCCOMB_X64_Y10_N8
\b_operativo|reg|q[4]~16\ : cycloneii_lcell_comb
-- Equation(s):
-- \b_operativo|reg|q[4]~16_combout\ = ((\a~combout\(4) $ (\b_operativo|reg|q\(4) $ (!\b_operativo|reg|q[3]~15\)))) # (GND)
-- \b_operativo|reg|q[4]~17\ = CARRY((\a~combout\(4) & ((\b_operativo|reg|q\(4)) # (!\b_operativo|reg|q[3]~15\))) # (!\a~combout\(4) & (\b_operativo|reg|q\(4) & !\b_operativo|reg|q[3]~15\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110001110",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \a~combout\(4),
	datab => \b_operativo|reg|q\(4),
	datad => VCC,
	cin => \b_operativo|reg|q[3]~15\,
	combout => \b_operativo|reg|q[4]~16_combout\,
	cout => \b_operativo|reg|q[4]~17\);

-- Location: LCFF_X64_Y10_N9
\b_operativo|reg|q[4]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \b_operativo|reg|q[4]~16_combout\,
	aclr => \b_controle|ALT_INV_estado.INICIO~regout\,
	ena => \b_controle|estado.ACUM~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \b_operativo|reg|q\(4));

-- Location: LCCOMB_X64_Y10_N10
\b_operativo|reg|q[5]~18\ : cycloneii_lcell_comb
-- Equation(s):
-- \b_operativo|reg|q[5]~18_combout\ = (\b_operativo|reg|q\(5) & ((\a~combout\(5) & (\b_operativo|reg|q[4]~17\ & VCC)) # (!\a~combout\(5) & (!\b_operativo|reg|q[4]~17\)))) # (!\b_operativo|reg|q\(5) & ((\a~combout\(5) & (!\b_operativo|reg|q[4]~17\)) # 
-- (!\a~combout\(5) & ((\b_operativo|reg|q[4]~17\) # (GND)))))
-- \b_operativo|reg|q[5]~19\ = CARRY((\b_operativo|reg|q\(5) & (!\a~combout\(5) & !\b_operativo|reg|q[4]~17\)) # (!\b_operativo|reg|q\(5) & ((!\b_operativo|reg|q[4]~17\) # (!\a~combout\(5)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \b_operativo|reg|q\(5),
	datab => \a~combout\(5),
	datad => VCC,
	cin => \b_operativo|reg|q[4]~17\,
	combout => \b_operativo|reg|q[5]~18_combout\,
	cout => \b_operativo|reg|q[5]~19\);

-- Location: LCCOMB_X64_Y10_N12
\b_operativo|reg|q[6]~20\ : cycloneii_lcell_comb
-- Equation(s):
-- \b_operativo|reg|q[6]~20_combout\ = ((\b_operativo|reg|q\(6) $ (\a~combout\(6) $ (!\b_operativo|reg|q[5]~19\)))) # (GND)
-- \b_operativo|reg|q[6]~21\ = CARRY((\b_operativo|reg|q\(6) & ((\a~combout\(6)) # (!\b_operativo|reg|q[5]~19\))) # (!\b_operativo|reg|q\(6) & (\a~combout\(6) & !\b_operativo|reg|q[5]~19\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110001110",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \b_operativo|reg|q\(6),
	datab => \a~combout\(6),
	datad => VCC,
	cin => \b_operativo|reg|q[5]~19\,
	combout => \b_operativo|reg|q[6]~20_combout\,
	cout => \b_operativo|reg|q[6]~21\);

-- Location: LCCOMB_X64_Y10_N14
\b_operativo|reg|q[7]~22\ : cycloneii_lcell_comb
-- Equation(s):
-- \b_operativo|reg|q[7]~22_combout\ = \b_operativo|reg|q\(7) $ (\b_operativo|reg|q[6]~21\ $ (\a~combout\(7)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100111100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \b_operativo|reg|q\(7),
	datad => \a~combout\(7),
	cin => \b_operativo|reg|q[6]~21\,
	combout => \b_operativo|reg|q[7]~22_combout\);

-- Location: LCFF_X64_Y10_N15
\b_operativo|reg|q[7]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \b_operativo|reg|q[7]~22_combout\,
	aclr => \b_controle|ALT_INV_estado.INICIO~regout\,
	ena => \b_controle|estado.ACUM~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \b_operativo|reg|q\(7));

-- Location: PIN_C13,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\s[7]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_s(7),
	combout => \s~combout\(7));

-- Location: LCFF_X64_Y10_N13
\b_operativo|reg|q[6]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \b_operativo|reg|q[6]~20_combout\,
	aclr => \b_controle|ALT_INV_estado.INICIO~regout\,
	ena => \b_controle|estado.ACUM~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \b_operativo|reg|q\(6));

-- Location: LCFF_X64_Y10_N11
\b_operativo|reg|q[5]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \b_operativo|reg|q[5]~18_combout\,
	aclr => \b_controle|ALT_INV_estado.INICIO~regout\,
	ena => \b_controle|estado.ACUM~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \b_operativo|reg|q\(5));

-- Location: PIN_T19,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\s[3]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_s(3),
	combout => \s~combout\(3));

-- Location: PIN_U22,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\s[2]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_s(2),
	combout => \s~combout\(2));

-- Location: PIN_AA26,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\s[1]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_s(1),
	combout => \s~combout\(1));

-- Location: LCCOMB_X63_Y10_N8
\b_operativo|men|LessThan0~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \b_operativo|men|LessThan0~1_cout\ = CARRY((\s~combout\(0) & !\b_operativo|reg|q\(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000100010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \s~combout\(0),
	datab => \b_operativo|reg|q\(0),
	datad => VCC,
	cout => \b_operativo|men|LessThan0~1_cout\);

-- Location: LCCOMB_X63_Y10_N10
\b_operativo|men|LessThan0~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \b_operativo|men|LessThan0~3_cout\ = CARRY((\b_operativo|reg|q\(1) & ((!\b_operativo|men|LessThan0~1_cout\) # (!\s~combout\(1)))) # (!\b_operativo|reg|q\(1) & (!\s~combout\(1) & !\b_operativo|men|LessThan0~1_cout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000101011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \b_operativo|reg|q\(1),
	datab => \s~combout\(1),
	datad => VCC,
	cin => \b_operativo|men|LessThan0~1_cout\,
	cout => \b_operativo|men|LessThan0~3_cout\);

-- Location: LCCOMB_X63_Y10_N12
\b_operativo|men|LessThan0~5\ : cycloneii_lcell_comb
-- Equation(s):
-- \b_operativo|men|LessThan0~5_cout\ = CARRY((\b_operativo|reg|q\(2) & (\s~combout\(2) & !\b_operativo|men|LessThan0~3_cout\)) # (!\b_operativo|reg|q\(2) & ((\s~combout\(2)) # (!\b_operativo|men|LessThan0~3_cout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \b_operativo|reg|q\(2),
	datab => \s~combout\(2),
	datad => VCC,
	cin => \b_operativo|men|LessThan0~3_cout\,
	cout => \b_operativo|men|LessThan0~5_cout\);

-- Location: LCCOMB_X63_Y10_N14
\b_operativo|men|LessThan0~7\ : cycloneii_lcell_comb
-- Equation(s):
-- \b_operativo|men|LessThan0~7_cout\ = CARRY((\b_operativo|reg|q\(3) & ((!\b_operativo|men|LessThan0~5_cout\) # (!\s~combout\(3)))) # (!\b_operativo|reg|q\(3) & (!\s~combout\(3) & !\b_operativo|men|LessThan0~5_cout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000101011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \b_operativo|reg|q\(3),
	datab => \s~combout\(3),
	datad => VCC,
	cin => \b_operativo|men|LessThan0~5_cout\,
	cout => \b_operativo|men|LessThan0~7_cout\);

-- Location: LCCOMB_X63_Y10_N16
\b_operativo|men|LessThan0~9\ : cycloneii_lcell_comb
-- Equation(s):
-- \b_operativo|men|LessThan0~9_cout\ = CARRY((\s~combout\(4) & ((!\b_operativo|men|LessThan0~7_cout\) # (!\b_operativo|reg|q\(4)))) # (!\s~combout\(4) & (!\b_operativo|reg|q\(4) & !\b_operativo|men|LessThan0~7_cout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000101011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \s~combout\(4),
	datab => \b_operativo|reg|q\(4),
	datad => VCC,
	cin => \b_operativo|men|LessThan0~7_cout\,
	cout => \b_operativo|men|LessThan0~9_cout\);

-- Location: LCCOMB_X63_Y10_N18
\b_operativo|men|LessThan0~11\ : cycloneii_lcell_comb
-- Equation(s):
-- \b_operativo|men|LessThan0~11_cout\ = CARRY((\s~combout\(5) & (\b_operativo|reg|q\(5) & !\b_operativo|men|LessThan0~9_cout\)) # (!\s~combout\(5) & ((\b_operativo|reg|q\(5)) # (!\b_operativo|men|LessThan0~9_cout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \s~combout\(5),
	datab => \b_operativo|reg|q\(5),
	datad => VCC,
	cin => \b_operativo|men|LessThan0~9_cout\,
	cout => \b_operativo|men|LessThan0~11_cout\);

-- Location: LCCOMB_X63_Y10_N20
\b_operativo|men|LessThan0~13\ : cycloneii_lcell_comb
-- Equation(s):
-- \b_operativo|men|LessThan0~13_cout\ = CARRY((\s~combout\(6) & ((!\b_operativo|men|LessThan0~11_cout\) # (!\b_operativo|reg|q\(6)))) # (!\s~combout\(6) & (!\b_operativo|reg|q\(6) & !\b_operativo|men|LessThan0~11_cout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000101011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \s~combout\(6),
	datab => \b_operativo|reg|q\(6),
	datad => VCC,
	cin => \b_operativo|men|LessThan0~11_cout\,
	cout => \b_operativo|men|LessThan0~13_cout\);

-- Location: LCCOMB_X63_Y10_N22
\b_operativo|men|LessThan0~14\ : cycloneii_lcell_comb
-- Equation(s):
-- \b_operativo|men|LessThan0~14_combout\ = (\b_operativo|reg|q\(7) & (\b_operativo|men|LessThan0~13_cout\ & \s~combout\(7))) # (!\b_operativo|reg|q\(7) & ((\b_operativo|men|LessThan0~13_cout\) # (\s~combout\(7))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001100110000",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \b_operativo|reg|q\(7),
	datad => \s~combout\(7),
	cin => \b_operativo|men|LessThan0~13_cout\,
	combout => \b_operativo|men|LessThan0~14_combout\);

-- Location: LCCOMB_X63_Y10_N0
\b_controle|estado~13\ : cycloneii_lcell_comb
-- Equation(s):
-- \b_controle|estado~13_combout\ = (\b_controle|estado.ESPERA~regout\ & ((\c~combout\) # (!\b_operativo|men|LessThan0~14_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \b_controle|estado.ESPERA~regout\,
	datac => \c~combout\,
	datad => \b_operativo|men|LessThan0~14_combout\,
	combout => \b_controle|estado~13_combout\);

-- Location: LCFF_X63_Y10_N1
\b_controle|estado.ACUM\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \b_controle|estado~13_combout\,
	aclr => \Reset~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \b_controle|estado.ACUM~regout\);

-- Location: LCCOMB_X63_Y10_N2
\b_controle|estado~12\ : cycloneii_lcell_comb
-- Equation(s):
-- \b_controle|estado~12_combout\ = (\b_controle|estado.ACUM~regout\) # (!\b_controle|estado.INICIO~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \b_controle|estado.INICIO~regout\,
	datad => \b_controle|estado.ACUM~regout\,
	combout => \b_controle|estado~12_combout\);

-- Location: LCFF_X63_Y10_N3
\b_controle|estado.ESPERA\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \b_controle|estado~12_combout\,
	aclr => \Reset~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \b_controle|estado.ESPERA~regout\);

-- Location: LCCOMB_X63_Y10_N24
\b_controle|estado~11\ : cycloneii_lcell_comb
-- Equation(s):
-- \b_controle|estado~11_combout\ = (\b_controle|estado.ESPERA~regout\ & (!\c~combout\ & \b_operativo|men|LessThan0~14_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \b_controle|estado.ESPERA~regout\,
	datac => \c~combout\,
	datad => \b_operativo|men|LessThan0~14_combout\,
	combout => \b_controle|estado~11_combout\);

-- Location: LCFF_X63_Y10_N25
\b_controle|estado.LIBERA\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \b_controle|estado~11_combout\,
	aclr => \Reset~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \b_controle|estado.LIBERA~regout\);

-- Location: PIN_W25,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\d~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \b_controle|estado.LIBERA~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_d);
END structure;


