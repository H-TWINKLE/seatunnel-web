@echo off

rem -------------------------------------------------------------------------
rem
rem 使用说明：
rem
rem 1: 该脚本用于别的项目时只需要修改 MAIN_CLASS 即可运行
rem
rem 2: JAVA_OPTS 可通过 -D 传入 undertow.port 与 undertow.host 这类参数覆盖
rem    配置文件中的相同值此外还有 undertow.resourcePath, undertow.ioThreads
rem    undertow.workerThreads 共五个参数可通过 -D 进行传入
rem
rem 3: JAVA_OPTS 可传入标准的 java 命令行参数,例如 -Xms256m -Xmx1024m 这类常用参数
rem
rem
rem -------------------------------------------------------------------------

setlocal & pushd

title seatunnel-web-2.3.4

rem 启动入口类,该脚本文件用于别的项目时要改这里
set MAIN_CLASS=org.apache.seatunnel.app.SeatunnelApplication

rem Java 命令行参数,根据需要开启下面的配置,改成自己需要的,注意等号前后不能有空格
rem set "JAVA_OPTS=-Xms256m -Xmx1024m -Dundertow.port=80 -Dundertow.host=0.0.0.0"
rem set "JAVA_OPTS=-Dundertow.port=80 -Dundertow.host=0.0.0.0"


if "%1"=="start" goto normal
if "%1"=="stop" goto normal
if "%1"=="restart" goto normal

rem goto error
if "%1"=="" ( goto start )


:error
echo Usage: seatunnel-web.bat start | stop | restart
goto :eof


:normal
if "%1"=="start" goto start
if "%1"=="stop" goto stop
if "%1"=="restart" goto restart
goto :eof


:start
echo starting seatunnel...

set WORKDIR=%~dp0

echo workDir is %WORKDIR%

set SPRING_OPTS= -Dspring.config.name=application.yml -Dspring.config.location=classpath:application.yml
set JAVA_OPTS= -server -Xms1g -Xmx1g -Xmn512m -XX:+PrintGCDetails -Xloggc:gc.log -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=dump.hprof -Dseatunnel-web.logs.path=${WORKDIR}..\logs
set CP=%WORKDIR%..\conf;%WORKDIR%..\libs\*;%WORKDIR%..\datasource\*;%WORKDIR%..\ui\*

echo prepare to start web server 

java -Xverify:none %JAVA_OPTS% -cp %CP% %SPRING_OPTS% %MAIN_CLASS%

goto :eof


:stop
set "PATH=%JAVA_HOME%\bin;%PATH%"
echo stopping jfinal undertow
for /f "tokens=1" %%i in ('jps -l ^| find "%MAIN_CLASS%"') do ( taskkill /F /PID %%i )
goto :eof


:restart
call :stop
call :start
goto :eof

endlocal & popd
pause
