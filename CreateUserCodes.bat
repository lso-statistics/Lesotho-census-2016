setlocal

REM Find CSEntry.exe (path differs on 32 and 64 bit Windows)

SET CSEntry="%ProgramFiles(x86)%\CSPro 6.2\CSEntry.exe"
SET Excel2CSPro="%ProgramFiles(x86)%\CSPro 6.2\Excel2CSPro.exe"
if exist %CSEntry% goto :gotcspro
SET CSEntry="%ProgramFiles%\CSPro 6.2\CSEntry.exe"
SET Excel2CSPro="%ProgramFiles%\CSPro 6.2\Excel2CSPro.exe"
if exist %CSEntry% goto :gotcspro
echo "Can't find CSEntry version 6.2. Is it installed?"
goto :eof
:gotcspro

REM Create .dat lookup file
%Excel2CSPro% /run /excel=".\Menu\staff.xlsx" /dcf=".\Menu\Staff.dcf" /output=".\Menu\staff.dat" /utf8="1" /worksheet="1" /rowStart="2" /columns="1+"

REM copy lookup files
copy /y .\Menu\staff.dat .\Deployment\LesothoCensus2016\Application\Menu