@ECHO OFF
call conda activate simOmPP

setlocal enabledelayedexpansion



@REM SAMPLE 6 -----------------------------------------------------------------
set "numbers=3"
for %%i in (%numbers%) do (
    echo %%i
    python D:/Code/simOmPP/combineEnsight.py ^
    --resultFolders     E:/Paper4/Simulations/invivo/mi_nocs/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295 ^
                        E:/Paper4/Simulations/invivo/mi_nocs/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_continue ^
    --resPath           E:/Paper4/Simulations/invivo/mi_nocs/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_total ^
    --simType           tissue ^
    --dt                1.0
)


@REM SAMPLE 11 -----------------------------------------------------------------
set "numbers=5"
for %%i in (%numbers%) do (
    echo %%i
    python D:/Code/simOmPP/combineEnsight.py ^
    --resultFolders     E:/Paper4/Simulations/invivo/mi_nocs/sample11/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295 ^
                        E:/Paper4/Simulations/invivo/mi_nocs/sample11/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_continue ^
    --resPath           E:/Paper4/Simulations/invivo/mi_nocs/sample11/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_total ^
    --simType           tissue ^
    --dt                1.0

)

@REM SAMPLE 12 -----------------------------------------------------------------
set "numbers=6 8 12"
for %%i in (%numbers%) do (
    echo %%i
    python D:/Code/simOmPP/combineEnsight.py ^
    --resultFolders     E:/Paper4/Simulations/invivo/mi_nocs/sample12/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295 ^
                        E:/Paper4/Simulations/invivo/mi_nocs/sample12/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_continue ^
    --resPath           E:/Paper4/Simulations/invivo/mi_nocs/sample12/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_total ^
    --simType           tissue ^
    --dt                1.0

)