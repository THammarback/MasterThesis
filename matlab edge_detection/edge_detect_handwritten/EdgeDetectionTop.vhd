--modified 19 May  10:50 pm , send to synthesis

library ieee;
library work;
use ieee.std_logic_1164.all;
use work.SPHD110420_COMPONENTS.all;
use ieee.numeric_std.all;

entity EdgeDetectionTop is

  Port ( clk : in std_logic; --clock
         reset : in std_logic; --reset
         start: in std_logic;
		 ready: out std_logic;
         pixel_in : in std_logic_vector( 15 downto 0); 
         pixel_out: out std_logic_vector (15 downto 0); 
         sync_out: out std_logic;
         finish_frame: out std_logic          
        );
end EdgeDetectionTop;

architecture Behavioral of EdgeDetectionTop is

--SRAM MEMORY , initiated with  wrapper
component SRAM_SP_WRAPPER is
  port (
    ClkxCI  : in  std_logic;
    CSxSI   : in  std_logic;            -- Active Low
    WExSI   : in  std_logic;            --Active Low
    AddrxDI : in  std_logic_vector (7 downto 0);
    RYxSO   : out std_logic;
    DataxDI : in  std_logic_vector (31 downto 0);
    DataxDO : out std_logic_vector (31 downto 0)
    );
end component;

--signals for FSM inside
type state_type is (idle, process_frame);
signal current_state, next_state : state_type;
signal state_reg: std_logic;

--signals for demux-mux RAM- shift registers
signal input4pixel_reg, input4pixel_next : std_logic;
signal addressRAM_reg, addressRAM_next : unsigned (7 downto 0);
--signal counterLines_reg, counterLines_next: std_logic;
signal RAMselect_reg, RAMselect_next : std_logic;
signal addressRAMD_reg, addressRAMD_next : unsigned (7 downto 0);

signal RAMselectR1 : std_logic;

signal counterLength_reg, counterLength_next : unsigned(8 downto 0);

signal wordRAM_reg , wordRAM_next :std_logic_vector(31 downto 0);
signal word_concat  : std_logic_vector(31 downto 0);

--signals for counters
signal addressR1,addressR2 : unsigned(7 downto 0);
signal endline: std_logic;


signal counterLengthR1 : unsigned (8 downto 0);

signal endframe : std_logic;

signal RAM_WE_A_R1 :std_logic;
signal RAM_WE_B_R1 :std_logic;
signal RAM_WE_A_R2 :std_logic;
signal RAM_WE_B_R2 :std_logic;

--signals for RAMs
 signal RAM_A_IN, RAM_B_IN, RAM_A_OUT,RAM_B_OUT :  std_logic_vector(31 downto 0);
 signal RAM_A_we,RAM_B_we: std_logic;
 signal RAM_ALL_address:  std_logic_vector(7 downto 0);

signal LOW_CS : std_logic;
signal RYA, RYB: std_logic;
--signals for calculation
signal first_line : std_logic;


signal a0_reg,a1_reg,a2_reg,a3_reg : unsigned(7 downto 0);
signal a0_next,a1_next,a2_next,a3_next : unsigned(7 downto 0);


signal L1_reg, L1_next: unsigned(31 downto 0);
signal L2_reg, L2_next: unsigned(31 downto 0);
signal L3_reg, L3_next: unsigned(31 downto 0);

signal L1_R1,L1_R2,L1_R3 , L2_R1,L2_R2,L2_R3, L3_R1  : unsigned(31 downto 0);
--change to 12 bits (11 downto 0)
signal sum1, sum2,sum0, sum3 : unsigned(11 downto 0);
signal sum1_2, sum2_2,sum0_2,sum3_2: unsigned(11 downto 0);
signal columnLeft_reg, columnLeft_next : unsigned (23 downto 0);

signal column3_reg,column3_next : unsigned (23 downto 0);

signal columnLeft_R1,columnLeft_R2 : unsigned (23 downto 0);

signal column3_R1,column3_R2: unsigned (23 downto 0);

--signal for outputs after clamping, then saved to registers
signal S0, S1,S2,S3 : unsigned (7 downto 0);

signal S0_A,   S1_A,  S2_A,  S3_A : unsigned (7 downto 0);

begin

LOW_CS <= '0';
  --register for FSM and counters
    process(clk,reset)
    begin 
     if reset ='1' then 
         current_state <= idle;-- FSM
     
        wordRAM_reg     <= (others=> '0');
        input4pixel_reg <= '0';
        addressRAM_reg  <= (others=> '0');
        addressRAMD_reg  <= (others=> '0');
       counterLength_reg <= (others=> '0');
        RAMselect_reg <= '0';
        
        L1_reg <= (others => '0');
        L2_reg <= (others => '0');
        L3_reg <= (others => '0');
        
        columnLeft_reg <= (others =>'0');
        column3_reg <= (others =>'0');
        
        a0_reg <= (others => '0');
        a1_reg <= (others => '0');
        a2_reg <= (others => '0');
        a3_reg <= (others => '0');
                
     elsif rising_edge(clk) then
        current_state <= next_state;-- FSM
     
        wordRAM_reg     <= wordRAM_next;
        input4pixel_reg <= input4pixel_next;
        addressRAM_reg  <= addressRAM_next;
        addressRAMD_reg  <= addressRAMD_next;
        counterLength_reg <= counterLength_next;
        RAMselect_reg <= RAMselect_next;
        
        L1_reg <= L1_next;
        L2_reg <= L2_next;
        L3_reg <= L3_next;
               
        columnLeft_reg <= columnLeft_next;
        column3_reg <= column3_next;               
        
        a0_reg <= a0_next;
        a1_reg <= a1_next;
        a2_reg <= a2_next;
        a3_reg <= a3_next;
        
        end if;
     end process;

 --next state logic FSM
  process( current_state, start, endframe)
  begin
  case current_state is
      when idle =>
            if start ='1' then
               next_state <= process_frame;
            else
               next_state <= current_state;
            end if;
      when process_frame =>
            if endframe  ='1' then
                next_state <= idle;
            else 
                next_state <= current_state;
            end if;
  end case; 
  end process;  
       
    --output logic;
    process( current_state)
    begin
        case current_state is
            when idle =>
            state_reg <= '0';
           when process_frame =>
            state_reg <= '1';
        end case;
    end process;


--logic for DEMUX- MUX - registers asociated to shift-save pixels
ready <= not state_reg;
--counter for 4 pixel next
input4pixel_next <= not input4pixel_reg when state_reg ='1' else '0'; 


--delayed RAM address
RAM_ALL_address <= std_logic_vector(addressRAMD_reg);
--counters for 1 SRAM at a time writing, RAM address
addressRAM_next <= (others => '0') when state_reg ='0' else addressR1;      --  
addressR1 <= (others=> '0') when endline ='1' else addressR2;               --
addressR2 <= addressRAM_reg + 1 when (input4pixel_reg= '1') else addressRAM_reg ; --
--input4pixel_reg is used to count the RAM address

--RAM address delayed -- extra circuit to reuse in both RAM addresses
addressRAMD_next <= addressRAM_reg when endline ='0' else (others=>'0');

--concatenate 4 pixels register
wordRAM_next <= word_concat when state_reg = '1' else (others => '0');          --
word_concat <= pixel_in & wordRAM_reg(31 downto 16);                            --

RAMselect_next <= RAMselectR1 when state_reg ='1' else '0';
RAMselectR1 <= not RAMselect_reg when endline ='1' else RAMselect_reg;
--after a endline, or 640 pixel, the other RAM starts to read while the other is written several times

--demux for sRAM's  input data
RAM_A_IN <= wordRAM_reg when (RAMselect_reg = '0') else (others=>'0');
RAM_B_IN <= wordRAM_reg when (RAMselect_reg = '1') else (others=>'0');
--RAM_C_IN <= wordRAM_next when (counterLines_next = 2) else (others=>'0');   

--demux for SRAM Write enable input --reading and writing to RAM
RAM_A_we <=  RAM_WE_A_R2 when state_reg='1' else '1';
RAM_B_we <=  RAM_WE_B_R2 when state_reg='1' else '1';

RAM_WE_A_R1 <= '1' when RAMselect_reg ='1' else input4pixel_reg;
RAM_WE_B_R1 <= '1' when RAMselect_reg ='0' else input4pixel_reg;

RAM_WE_A_R2 <= RAM_WE_A_R1 when endframe ='0' else '1';
RAM_WE_B_R2 <= RAM_WE_B_R1 when endframe ='0' else '1';


--1 line is finished, 1 SRAM is completely full
endline <= '1' when addressRAM_reg = 160 else '0';                          --
                              
--counter for Length of the image, for new frame
counterLength_next <= counterLengthR1 when (state_reg='1') else (others=> '0');
counterLengthR1 <= counterLength_reg +1 when endline = '1' else counterLength_reg;

--possible finish signal with other conditional after getting image matrix
endframe <= '1' when (counterLength_next = 481 and addressRAMD_reg = 2 ) else '0';
--finish flag for system and for FSM
finish_frame <= endframe;

--signals for timing to perform operations
first_line <= '1' when counterLength_next = 0 else '0';
---

---bit shifts , application of filter
L1_next <= (others => '0') when state_reg = '0'  else L1_R1;
L1_R1<=(others => '0') when counterLength_reg <= 1  else L1_R2;
L1_R2 <= L1_reg when addressRAM_reg = 0 else L1_R3;
L1_R3 <= unsigned(RAM_A_OUT) when RAMselect_reg ='0' else unsigned(RAM_B_OUT) ;
--

L2_next <= (others => '0') when state_reg = '0'  else L2_R1; 
L2_R1 <=  (others => '0') when counterLength_reg = 0  else L2_R2;
L2_R2 <= L2_reg when addressRAM_reg = 0 else L2_R3;
L2_R3 <= unsigned(RAM_A_OUT) when RAMselect_reg ='1' else unsigned(RAM_B_OUT) ;
--
L3_next <= (others => '0') when state_reg = '0'  else L3_R1; 
L3_R1 <= unsigned(wordRAM_reg) when input4pixel_reg ='0' else L3_reg;


columnLeft_next <= (others => '0') when state_reg ='0' else columnLeft_R1;
columnLeft_R1 <= (others => '0') when addressRAMD_reg = 0 else columnLeft_R2;
columnLeft_R2 <= L3_reg(31 downto 24) & L2_reg(31 downto 24) & L1_reg(31 downto 24);

column3_next <= (others => '0') when state_reg = '0' else column3_R1;
column3_R1 <= (others => '0') when addressRAMD_reg = 0 else column3_R2;
column3_R2 <= L3_reg(23 downto 16) & L2_reg(23 downto 16) & L1_reg(23 downto 16);

--correct now , mirror issue before 
sum1 <= ("0000" & L1_reg(15 downto 8)) + ("0000" & L1_reg(7 downto 0)) + ("0000" & L2_reg(7 downto 0))
         - ("0000" & L2_reg(23 downto 16)) - ("0000" & L3_reg(23 downto 16))- ("0000" & L3_reg(15 downto 8));
sum1_2 <= sum1(10 downto 0) & "0";-- bitshift 2 multiply

--correct now, mirror issue before
sum2 <= ("0000" & L1_reg(23 downto 16)) + ("0000" & L1_reg(15 downto 8)) + ("0000" & L2_reg(15 downto 8))
         - ("0000" & L2_reg(31 downto 24)) - ("0000" & L3_reg(31 downto 24))- ("0000" & L3_reg(23 downto 16));
sum2_2 <= sum2(10 downto 0) & "0";  --bitshift 2 multiply


-- correct now
--for first row, columnleft is set up as 0
sum0 <= ("0000" & columnLeft_reg(15 downto 8)) + ("0000" & columnLeft_reg(7 downto 0)) + ("0000" & L1_reg(7 downto 0))
         - ("0000" & L2_reg(15 downto 8)) - ("0000" & L3_reg(15 downto 8))- ("0000" & L3_reg(7 downto 0));
sum0_2 <= sum0(10 downto 0) & "0";  --bitshift 2 multiply


--third value to get after new data is read, this data should be sent before sum0, 
--since required left and 3rd column to process easier to send 
sum3 <= ("0000" & columnLeft_reg(7 downto 0)) + ("0000" & column3_reg(7 downto 0)) + ("0000" & column3_reg(15 downto 8))
          - ("0000" & columnLeft_reg(23 downto 16)) - ("0000" & L3_reg(7 downto 0))- ("0000" & L2_reg(7 downto 0));
sum3_2 <=  sum3(10 downto 0) & "0";  --bitshift 2 multiply      

--logic for clamping, negative values to 0 and values over 255 to 255    --clamping mode changed  
  S0 <=  (others=>'0') when sum0_2(11) ='1' else S0_A;
  S0_A <= (others=>'1') when sum0_2 >=255 else sum0_2(7 downto 0);
  
  S1 <=  (others=>'0') when sum1_2(11) ='1' else S1_A;
  S1_A <= (others=>'1') when sum1_2 >= 255 else sum1_2(7 downto 0);
  
  S2 <=  (others=>'0') when sum2_2(11) ='1'  else S2_A;
  S2_A <= (others=>'1') when sum2_2 >=255  else sum2_2(7 downto 0);
  
  S3 <=  (others=>'0') when sum3_2(11) ='1' else S3_A;
  S3_A <= (others=>'1') when sum3_2 >=255 else sum3_2(7 downto 0);
            
  
  a2_next <= S2 when input4pixel_reg ='0' else a2_reg;
  a0_next <= S0 when input4pixel_reg ='1' else a0_reg;
  a3_next <= S3 when input4pixel_reg = '1' else a3_reg;
  a1_next <= S1 when input4pixel_reg ='0' else a1_reg;
  
  pixel_out <=  std_logic_vector(a1_reg) & std_logic_vector(a0_reg) when input4pixel_reg = '1' else  std_logic_vector(a3_reg)& std_logic_vector(a2_reg); 
  
  sync_out <= '1' when  (addressRAMD_reg = 2 and counterLength_reg >= 1) else '0';
   
             
--port mapping RAM A and B
RAM_A:  SRAM_SP_WRAPPER port map
    (
    ClkxCI  => clk,
    CSxSI   => LOW_CS,           -- Active Low
    WExSI   => RAM_A_we,          --Active Low
    AddrxDI => RAM_ALL_address,
    RYxSO   => RYA,
    DataxDI =>  RAM_A_IN,
    DataxDO => RAM_A_OUT
    );

RAM_B:  SRAM_SP_WRAPPER port map
    (
    ClkxCI  => clk,
    CSxSI   => LOW_CS,           -- Active Low
    WExSI   => RAM_B_we,          --Active Low
    AddrxDI => RAM_ALL_address,
    RYxSO   => RYB,
    DataxDI =>  RAM_B_IN,
    DataxDO => RAM_B_OUT
    );


end Behavioral;

