@ECHO OFF
 
 
SET ExecuteCommand=nvidia-smi
 
 
SET ExecutePeriod=5
 
 
SETLOCAL EnableDelayedExpansion
 
:loop
 
  cls
 
  echo !date! !time!
  echo After !ExecutePeriod! s will execute the cmd^: !ExecuteCommand!
 
  echo.
 
  %ExecuteCommand%
  
  timeout /t %ExecutePeriod%
 
goto loop
