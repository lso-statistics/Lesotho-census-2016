setlocal


REM Find CSEntry.exe (path differs on 32 and 64 bit Windows)

SET CSEntry="%ProgramFiles(x86)%\CSPro 6.2\CSEntry.exe"
if exist %CSEntry% goto :gotcspro
SET CSEntry="%ProgramFiles%\CSPro 6.2\CSEntry.exe"
if exist %CSEntry% goto :gotcspro
echo "Can't find CSEntry version 6.2. Is it installed?"
goto :eof
:gotcspro


REM Create deployment directory
rmdir /q /s Deployment
mkdir Deployment
cd Deployment
mkdir LesothoCensus2016
cd LesothoCensus2016
mkdir HouseholdDataEntry
mkdir Menu
mkdir AssistSupReview
cd..\..

REM Create .pen files
%CSEntry% /pen .\Menu\LesothoCensusMenu.ent
%CSEntry% /pen .\HouseholdDataEntry\HouseholdDataEntry.ent
%CSEntry% /pen .\AssistSupReview\AssistSupReview.ent

REM copy lookup files
copy /y .\Menu\staff.dat .\Deployment\LesothoCensus2016\Menu
copy /y .\Menu\AssSup.dat .\Deployment\LesothoCensus2016\Menu

REM Copy applications to deployment
move /y .\Menu\LesothoCensusMenu.pen .\Deployment\LesothoCensus2016\Menu
move /y .\HouseholdDataEntry\HouseholdDataEntry.pen .\Deployment\LesothoCensus2016\HouseholdDataEntry
move /y .\AssistSupReview\AssistSupReview.pen .\Deployment\LesothoCensus2016\AssistSupReview

REM Copy .pff for Menu
copy /y .\Menu\*.pff .\Deployment\LesothoCensus2016\Menu

REM Copy .pnc files
copy /y EnumeratorInitialSync.pnc .\Deployment\LesothoCensus2016
copy /y SupervisorInitialSync.pnc .\Deployment\LesothoCensus2016
copy /y SyncWithEnumerator.pnc .\Deployment\LesothoCensus2016
copy /y SyncWithServer.pnc .\Deployment\LesothoCensus2016
copy /y SyncWithSupervisor.pnc .\Deployment\LesothoCensus2016
