END_TIME_CIVY = 3600; //When mission should end in seconds.
END_TIME_NATO = 3600; //When mission should end in seconds.

if (isServer && natosidemissionup) then {
    [] spawn 
    {
        ELAPSED_TIME_NATO  = 0;
        START_TIME_NATO = diag_tickTime;
        while {ELAPSED_TIME_NATO < END_TIME_NATO} do 
        {
            ELAPSED_TIME_NATO = diag_tickTime - START_TIME_NATO;
            publicVariable "ELAPSED_TIME_NATO";
            sleep 1;
        };
    };
};

if (isServer && civysidemissionup) then {
    [] spawn 
    {
        ELAPSED_TIME_CIVY  = 0;
        START_TIME_CIVY = diag_tickTime;
        while {ELAPSED_TIME_CIVY < END_TIME_CIVY} do 
        {
            ELAPSED_TIME_CIVY = diag_tickTime - START_TIME_CIVY;
            publicVariable "ELAPSED_TIME_CIVY";
            sleep 1;
        };
    };
};

if!(isDedicated) then
{
    [] spawn 
    {
        while{ELAPSED_TIME_NATO < END_TIME_NATO } do
        {
            _time = END_TIME_NATO - ELAPSED_TIME_NATO;
            _finish_time_minutes = floor(_time / 60);
            _finish_time_seconds = floor(_time) - (60 * _finish_time_minutes);
            if(_finish_time_seconds < 10) then
            {
                _finish_time_seconds = format ["0%1", _finish_time_seconds];
            };
            if(_finish_time_minutes < 10) then
            {
                _finish_time_minutes = format ["0%1", _finish_time_minutes];
            };
            _formatted_time_NATO = format ["%1:%2", _finish_time_minutes, _finish_time_seconds];
            
            if(islandStatusOn) then {

         SMhint = format ["<t align='center'>
              (IS) Time left:<br/>%1
              (IS) Time left:<br/>%1
			  <br/>____________________<br/>
              <t size='2.2'>
                  Island Status
              </t>
              <br/>____________________<br/>
              <t size='1.5' color='#00B2EE'>
                  50% Support
			  </t>
		  </t>", _formatted_time_NATO];
                  
                hint parsetext SMhint;
            } else {
                hintSilent format ["Time left:\n%1\nTime left:\n%1", _formatted_time_NATO];
            };
            
            
            sleep 1;
        };
    };
};  