@ECHO OFF

SET source=^
C:\Users\szymo\Desktop\Szymontest1

:: Powyżej wpisz ścieżkę do folderu źródłowego.
:: Z wszystkich plików znajdujących się w tym
:: folderze zostanie utworzona kopia zapasowa.

SET destination=^
D:\Kopia zapasowa

:: Powyżej wpisz ścieżkę do której pliki
:: z folderu źródłowego mają zostać przeniesione.

SET "now=%date:~0,2%.%date:~3,2%.%date:~-4% %time:~0,2%:%time:~3,2%:%time:~6,2%"

ECHO ---------------------
ECHO.    WindowsBackup
ECHO. %now%
ECHO ---------------------

xcopy "%source%" "%destination%" /S /E /Y /I

SET /A xcopyreturncode=%errorlevel%
SET description=Unknown

IF %xcopycode%==0 (
  SET description=Files were copied without error
) ELSE IF %xcopycode%==1 (
  SET description=No files were found to copy
) ELSE IF %xcopycode%==2 (
  SET description=Copying was terminated by user
) ELSE IF %xcopycode%==4 (
  SET description=Not enough memory or disk space, or invalid drive name
) ELSE IF %xcopycode%==5 (
  SET description=Disk write error occurred
)

SET logfilename=WindowsBackup-logfile.txt
ECHO LAST BACKUP: %now%, STATUS: %description%. > "%destination%/%logfilename%"

EXIT %xcopycode%
