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
mkdir Application
mkdir Data
mkdir DataBackup
cd Application
mkdir HouseholdDataEntry
mkdir Menu
mkdir AssistSupReview
cd..
cd Data
mkdir Enumerator
mkdir Supervisor
cd..
cd DataBackup
mkdir Enumerator
mkdir Supervisor
cd..\..

REM Create .pen files
%CSEntry% /pen .\Menu\LesothoCensusMenu.ent
%CSEntry% /pen .\HouseholdDataEntry\HouseholdDataEntry.ent
%CSEntry% /pen .\AssistSupReview\AssistSupReview.ent

REM copy lookup files
copy /y .\Menu\staff.dat .\Deployment\LesothoCensus2016\Application\Menu
copy /y .\Menu\AssSup.dat .\Deployment\LesothoCensus2016\Application\Menu

REM Copy applications to deployment
move /y .\Menu\LesothoCensusMenu.pen .\Deployment\LesothoCensus2016\Application\Menu
move /y .\HouseholdDataEntry\HouseholdDataEntry.pen .\Deployment\LesothoCensus2016\Application\HouseholdDataEntry
move /y .\AssistSupReview\AssistSupReview.pen .\Deployment\LesothoCensus2016\Application\AssistSupReview

REM Copy .pff for Menu
copy /y .\Menu\*.pff .\Deployment\LesothoCensus2016\Application\Menu

REM Copy .pnc files
copy /y EnumeratorInitialSync.pnc .\Deployment\LesothoCensus2016\Application
copy /y SupervisorInitialSync.pnc .\Deployment\LesothoCensus2016\Application
copy /y SyncWithEnumerator.pnc .\Deployment\LesothoCensus2016\Application
copy /y SyncWithServer.pnc .\Deployment\LesothoCensus2016\Application
copy /y SyncWithSupervisor.pnc .\Deployment\LesothoCensus2016\Application
