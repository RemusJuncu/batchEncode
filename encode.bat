@ECHO off
TITLE Encode http://remusjuncu.com/
COLOR 0c
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION
CLS

:: drag and drop files and folders on the encode.bat to run
:: !!! make sure the encodeFolder exists !!!

rem explorer .\encodes\
SET "encodeFolder=D:\_econdes\"

IF EXIST %1 GOTO FileAction
explorer %encodeFolder%
EXIT

:FileAction
  rem pushd %~dp0
  for %%A in (%*) DO (
    echo.
    echo --// %%A \\--
    TITLE --// %%A \\--
    echo.
    
    IF EXIST %%A\ (
      rem echo %%~nnA
      set currentFolder=%%~nnA
      mkdir "%encodeFolder%!currentFolder!"
      for /f "usebackq delims=|" %%f in (`dir /b %%A`) do (
        rem %%~A\%%f
        ffmpeg -i "%%~A\%%f" -c:v libx264 "%encodeFolder%!currentFolder!\%%~nf.mp4"
      )
    ) ELSE (
      ffmpeg -i %%A -c:v libx264 "%encodeFolder%%%~nnA.mp4"
    )
  )
PAUSE
EXIT

:: get ffmpeg from https://www.ffmpeg.org/
:: ffmpeg.exe needs to next to the file, 
:: if that doesn't work you can copy ffmpeg.exe to the windows folder and it will work
