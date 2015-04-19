xcopy /s /y "E:\Users\M\Documents\Arma 3 - Other Profiles\Sharpe\MPMissions\NATO0ParaRescue0-01e0.Altis\mission.sqm" "Z:\ARMA 3 Projects\ParaRescue\mission.sqm" 

set folder="E:\Users\M\Documents\Arma 3 - Other Profiles\Sharpe\MPMissions\NATO0ParaRescue0-01e0.Altis"
cd /d %folder%
for /F "delims=" %%i in ('dir /b') do (rmdir "%%i" /s/q || del "%%i" /s/q)

xcopy /s /y "Z:\ARMA 3 Projects\ParaRescue" "E:\Users\M\Documents\Arma 3 - Other Profiles\Sharpe\MPMissions\NATO0ParaRescue0-01e0.Altis"