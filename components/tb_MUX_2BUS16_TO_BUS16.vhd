library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY tb_MUX_2BUS8_TO1_BUS8 IS
END tb_MUX_2BUS8_TO1_BUS8;

ARCHITECTURE behavior OF tb_MUX_2BUS8_TO1_BUS8 IS

-- Component Declaration for the UUT

   COMPONENT MUX_2BUS16_TO1_BUS16 is
   port ( in1     : in  std_logic_vector(15 downto 0);
          in2     : in  std_logic_vector(15 downto 0);
          s       : in  std_logic;
          mux_out : out std_logic_vector(15 downto 0) 
         );
   end COMPONENT;   

   signal   s                : std_logic ;
   signal   in1,in2, mux_out : std_logic_vector(15 downto 0);
   constant time_delay       : time := 20 ns;

BEGIN
   -- Instantiate the Unit Under Test (UUT)
   uut: MUX_2BUS16_TO1_BUS16 port map ( 
          in1     => in1,
          in2     => in2,
          s       => s,
          mux_out => mux_out 
        );

   -- Stimulus process 
   stim_process: process -- this process, in testbench/simulation code, is different than in design code
   begin
      assert false report "MUX_2BUS8_TO1_BUS8 testbench started"; -- puts a note in the ModelSim transcript window (this line is just for convenience)
      s <= '1';
      wait for time_delay;
      in1 <= "0000000000000001"; in2 <= "1111111111111110"; 
      wait for time_delay;
      s <= not s;
      wait for time_delay;
      stimloop : for i in 0 to 7 loop
         in1 <= std_logic_vector( rotate_left( unsigned(in1), 1 ) );
         in2 <= std_logic_vector( rotate_left( unsigned(in2), 1 ) );
         wait for time_delay;
         s <= not s;
         wait for time_delay;
      end loop stimloop;
      wait for 10*time_delay; -- this extends the time by 10x the time_delay, for ease of veiwing waveforms
      assert false report "MUX2TO1 testbench completed"; -- puts a note in the ModelSim transcript window (this line is just for convenience)
      wait; -- this wait without any time parameters just stops the simulation, otherwise it would repeat forever starting back at the top  
   end process;
END;
