:: if you are building from svn repo: make sure svnversion.exe is in your path!
::
:: creates svn_revision file in root folder with last svn_revision
:: creates ..\svn_revision and svn_revision.h

:: uses svnversion.exe (searched in PATH)
:: if svnversion.exe is not found 
::    or the root dir is not an svn repo
::    and no svn_revision file exists
:: then, a dummy value is written (should not happen!)



@FOR /F "tokens=1" %%i in ('svnversion.exe %~dp0..') do @SET SVN_REVISION=%%i

@IF NOT DEFINED SVN_REVISION GOTO writedummy
@IF SVN_REVISION==exported GOTO writedummy

@echo %SVN_REVISION%>%~dp0..\svn_revision
@echo [INFO] ..\svn_revision set to %SVN_REVISION%
@GOTO svn_revision_h

:writedummy
@IF EXIST %~dp0..\svn_revision GOTO svn_revision_h
@echo 666>%~dp0..\svn_revision
@echo [INFO] ..\svn_revision set to 666

:svn_revision_h

:: creates svn_revision.h file

@FOR /F "tokens=1" %%i in (%~dp0..\svn_revision) do @SET SVN_REVISION=%%i

@SET /A SVN_REVISION+=6000

@echo #ifndef __SVN_REVISION_H__                 >  %~dp0\svn_revision.h
@echo #define __SVN_REVISION_H__                 >> %~dp0\svn_revision.h
@echo #define SVN_REVISION %SVN_REVISION%        >> %~dp0\svn_revision.h
@echo #define SVN_REVISION_STR "%SVN_REVISION%"  >> %~dp0\svn_revision.h

@echo #endif //__SVN_REVISION_H__                >> %~dp0\svn_revision.h
