library IEEE;
use IEEE.std_logic_1164.all;

Entity bsLR is
      port (LorR    : in  std_logic; -- '1' for left, '0' for right
            LorA    : in  std_logic; -- '1' for arithmetic, '0' for logical
            i_s     : in  std_logic_vector(4 downto 0);  -- shift count
            i_a     : in  std_logic_vector (31 downto 0);
            o_a     : out std_logic_vector (31 downto 0) );
end entity bsLR;

architecture structure of bsLR is

component mux2
  port(SEL          : in std_logic;
       A			: in std_logic;
	   B			: in std_logic;
	   O			: out std_logic);
end component;

component reverse
Port (  s : in STD_LOGIC;
		i : in STD_LOGIC_VECTOR (31 downto 0);
		o : out STD_LOGIC_VECTOR (31 downto 0));
end component;


signal s_1, ss_1, s_2, ss_2, s_4, ss_4, s_8, ss_8, s_16, ss_16, si_a, so_a	: std_logic_vector(31 downto 0);
signal LorAs, sLorAmux : std_logic;

begin

muxLRselA : mux2
    port map(SEL  => i_a(31),
  	         A  => '0',
			 B  => '1',
			 O  => sLorAmux);
			 
muxLRselB : mux2
    port map(SEL  => LorA,
  	         A  => '0',
			 B  => sLorAmux,
			 O  => LorAs);


in_reverse : reverse
	port map(s  => LorR,
			 i  => i_a,
			 o  => si_a);
			 
			 
out_reverse : reverse
	port map(s  => LorR,
			 i  => so_a,
			 o  => o_a);

ss_1 <= LorAs & si_a(31 downto 1);
ss_2 <= LorAs & LorAs & s_1(31 downto 2);
ss_4 <= LorAs & LorAs & LorAs & LorAs & s_2(31 downto 4);
ss_8 <= LorAs & LorAs & LorAs & LorAs & LorAs & LorAs & LorAs & LorAs & s_4(31 downto 8);
ss_16 <= LorAs & LorAs & LorAs & LorAs & LorAs & LorAs & LorAs & LorAs & LorAs & LorAs & LorAs & LorAs & LorAs & LorAs & LorAs & LorAs & s_8(31 downto 16);

G1: for i in 0 to 31 generate
  mux1i : mux2
    port map(SEL  => i_s(0),
  	         A  => si_a(i),
			 B  => ss_1(i),
			 O  => s_1(i));
end generate;

G2: for i in 0 to 31 generate
  mux2i : mux2
    port map(SEL  => i_s(1),
  	         A  => s_1(i),
			 B  => ss_2(i),
			 O  => s_2(i));
end generate;

G4: for i in 0 to 31 generate
  mux4i : mux2
    port map(SEL  => i_s(2),
  	         A  => s_2(i),
			 B  => ss_4(i),
			 O  => s_4(i));
end generate;

G8: for i in 0 to 31 generate
  mux1i : mux2
    port map(SEL  => i_s(3),
  	         A  => s_4(i),
			 B  => ss_8(i),
			 O  => s_8(i));
end generate;

G16: for i in 0 to 31 generate
  mux16i : mux2
    port map(SEL  => i_s(4),
  	         A  => s_8(i),
			 B  => ss_16(i),
			 O  => so_a(i));
end generate;

  
end structure;