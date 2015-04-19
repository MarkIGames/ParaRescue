while {true} do
	{
	waituntil {bark==1};
	bark = 0;
	publicvariable "bark";
	playSound3D [soundToPlay, dog1, false, getpos dog1, volume, 1, 70];
	};