module StateMachine(
		input Clk,
		input [9:0] SW,
		input secGenIn,
		input [1:0] KEY,
		input [31:0] timeParaMeter,
		input [31:0] userDate,
		output [31:0] Out,
		output [1:0] timerState,
		output activeState,
		output ledBlink,
		output DateOrTime,
		output flashFlag
);


reg startSetTime,startSetAlarm,stopperStart,startCD,DateOrTimeReg,flashReg;
wire [31:0] ansUP,ansDOWN,alarmTime,userTime,timeToCount,stopperOut,CDTime,CDState,dateTime; //times for each state
wire [31:0] saved1,saved2,saved3; //saves for stopper
reg saveActive,actState;
wire [1:0] setTimeStage,setAlarmStage,setCDStage,setDateStage; //the stage of each state
reg  [1:0] finalState; //final state output
wire setTimeFlag,setAlarmFlag,setCDFlag,alarmDone,countDownDone,setDateFlag; //set flags
reg [31:0] tmpReg,dateReg;// time and date to print to 7seg

saveStopper SaveSt(Clk,saveActive,KEY,stopperOut,saved1,saved2,saved3);
stopper st(secGenIn,stopperStart&~SW[2],KEY,stopperOut);



///
alarmClock ac(Clk,ansUP,alarmTime,setAlarmFlag,KEY[1],alarmDone);
setTime stAlarm(Clk,KEY,startSetAlarm,alarmTime,setAlarmFlag,setAlarmStage);
///

///
rise_det r2d(secGenIn,setCDFlag,riseDetFlagCD);
setTime stCD(Clk,KEY,startCD,CDTime,setCDFlag,setCDStage);
countdown cDown(Clk,CDTime,secGenIn,setCDFlag,KEY[1],riseDetFlagCD,ansDOWN,countDownDone);
Mux2_1_32bit m32_2(CDTime,ansDOWN,setCDFlag,CDState); //show the set time to cd or the the real time that cd
///


///
wire riseDetFlag,riseDetFlagCD;
rise_det rd(secGenIn,setTimeFlag,riseDetFlag);
countUp cUp(secGenIn,timeToCount,ansUP,riseDetFlag);
setTime stUp(Clk,KEY,startSetTime,userTime,setTimeFlag,setTimeStage);
Mux2_1_32bit m32(timeParaMeter,userTime,setTimeFlag,timeToCount); //choose burned time or set time


///

///
setDate SD(Clk,KEY,DateOrTimeReg,userDate,dateTime,setDateFlag,setDateStage); //set date

///


assign ledBlink = alarmDone | countDownDone; //led[0] blink when alarm or cd done

always @(posedge Clk) begin
actState=1; 
DateOrTimeReg=0;
flashReg=0;
startSetAlarm=0;
startCD=0;
startSetTime=0;
saveActive=0;
stopperStart=0;

	case(SW[8:0])
	0: begin // Normal clock
			tmpReg=ansUP;
		end
	1: begin 
			startSetTime=1;
			finalState = setTimeStage;
			tmpReg=userTime;
			actState=0;
		end
	2: begin
			stopperStart=1;
			tmpReg=stopperOut;

		end
	4: begin
			stopperStart=1;
			tmpReg=stopperOut;
			saveActive=1;
		end
	5: begin
			stopperStart=1;
			tmpReg=saved1;
		end
	6: begin
			stopperStart=1;
			tmpReg=saved2;
		end	
	7: begin
			stopperStart=1;
			tmpReg=saved3;
		end					
	8: begin 
			tmpReg=CDState;
			startCD=1;
			actState=0;
			finalState = setCDStage;

		end
	9: 	tmpReg=ansDOWN;

	16:begin //alarm
			actState=0;
			startSetAlarm=1;
			tmpReg=alarmTime;
			finalState=setAlarmStage;

		end
		
	32:begin
			actState=0;
			DateOrTimeReg=1;
			dateReg = dateTime;
			finalState = setDateStage;
		end
	64:begin
			flashReg = 1;
		end	
		
	9'b100000000:	tmpReg=ansUP; // local time 
	9'b100000001:	tmpReg=ansUP-7*3600; // New York (GMT 2 -7)
	9'b100000010:	tmpReg=ansUP-2*3600; // London (GMT 2 -2)
	9'b100000100:	tmpReg=ansUP+6*3600; // China (GMT 2 +6)
	9'b100001000:	tmpReg=ansUP-1*3600; // France (GMT 2 -1)
	9'b100010000:	tmpReg=ansUP+5*3600; // Thailand (GMT 2 +5)
	9'b100100000:	tmpReg=ansUP+10*3600; // New Zealand (GMT 2 +10)
	9'b101000000:	tmpReg=ansUP+2*3600; // Emirates (GMT 2 +2)
	9'b110000000:	tmpReg=ansUP-5*3600; // China (GMT 2 -5)

	endcase
end

assign Out=(DateOrTimeReg)? dateReg: tmpReg;
assign activeState=actState;
assign timerState=finalState;
assign DateOrTime= DateOrTimeReg;
assign flashFlag = flashReg;



endmodule
