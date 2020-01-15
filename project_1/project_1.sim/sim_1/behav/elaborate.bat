@echo off
set xv_path=E:\\Vivado\\Vivado\\2017.2\\bin
call %xv_path%/xelab  -wto 99c0248d76d946eb8fe89f2723586d2e -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot DataPath_behav xil_defaultlib.DataPath xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
