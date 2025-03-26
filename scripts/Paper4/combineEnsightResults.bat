@ECHO OFF
call conda activate simOmPP

setlocal enabledelayedexpansion

@REM SAMPLE 4 -----------------------------------------------------------------
@REM set "numbers=1 4 17"
@REM for %%i in (%numbers%) do (
@REM     echo %%i
@REM     python D:/Code/simOmPP/combineEnsight.py ^
@REM     --resultFolders     D:/Paper4/Simulations/invivo/mi/sample4/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295 ^
@REM                         D:/Paper4/Simulations/invivo/mi/sample4/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_continue ^
@REM     --resPath           D:/Paper4/Simulations/invivo/mi/sample4/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_total ^
@REM     --simType           tissue ^
@REM     --dt                1.0

@REM     python D:/Code/simOmPP/combineEnsight.py ^
@REM     --resultFolders     D:/Paper4/Simulations/invivo/mi/sample4/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295 ^
@REM                         D:/Paper4/Simulations/invivo/mi/sample4/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_continue ^
@REM     --resPath           D:/Paper4/Simulations/invivo/mi/sample4/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_total ^
@REM     --simType           cs ^
@REM     --dt                1.0
@REM )

@REM SAMPLE 5 -----------------------------------------------------------------
set "numbers=3 7 12 14 17"
for %%i in (%numbers%) do (
    echo %%i
    python D:/Code/simOmPP/combineEnsight.py ^
    --resultFolders     D:/Paper4/Simulations/invivo/mi/sample5/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295 ^
                        D:/Paper4/Simulations/invivo/mi/sample5/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_continue ^
    --resPath           D:/Paper4/Simulations/invivo/mi/sample5/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_total ^
    --simType           tissue ^
    --dt                1.0

    python D:/Code/simOmPP/combineEnsight.py ^
    --resultFolders     D:/Paper4/Simulations/invivo/mi/sample5/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295 ^
                        D:/Paper4/Simulations/invivo/mi/sample5/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_continue ^
    --resPath           D:/Paper4/Simulations/invivo/mi/sample5/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_total ^
    --simType           cs ^
    --dt                1.0
)


@REM SAMPLE 6 -----------------------------------------------------------------
@REM set "numbers=3 13 14 17"
@REM for %%i in (%numbers%) do (
@REM     echo %%i
@REM     python D:/Code/simOmPP/combineEnsight.py ^
@REM     --resultFolders     D:/Paper4/Simulations/invivo/mi/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295 ^
@REM                         D:/Paper4/Simulations/invivo/mi/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_continue ^
@REM     --resPath           D:/Paper4/Simulations/invivo/mi/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_total ^
@REM     --simType           tissue ^
@REM     --dt                1.0

@REM     python D:/Code/simOmPP/combineEnsight.py ^
@REM     --resultFolders     D:/Paper4/Simulations/invivo/mi/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295 ^
@REM                         D:/Paper4/Simulations/invivo/mi/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_continue ^
@REM     --resPath           D:/Paper4/Simulations/invivo/mi/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_total ^
@REM     --simType           cs ^
@REM     --dt                1.0
@REM )


@REM SAMPLE 7 -----------------------------------------------------------------
set "numbers=1 3 14 17"
for %%i in (%numbers%) do (
    echo %%i
    python D:/Code/simOmPP/combineEnsight.py ^
    --resultFolders     D:/Paper4/Simulations/invivo/mi/sample7/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295 ^
                        D:/Paper4/Simulations/invivo/mi/sample7/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_continue ^
    --resPath           D:/Paper4/Simulations/invivo/mi/sample7/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_total ^
    --simType           tissue ^
    --dt                1.0

    python D:/Code/simOmPP/combineEnsight.py ^
    --resultFolders     D:/Paper4/Simulations/invivo/mi/sample7/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295 ^
                        D:/Paper4/Simulations/invivo/mi/sample7/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_continue ^
    --resPath           D:/Paper4/Simulations/invivo/mi/sample7/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_total ^
    --simType           cs ^
    --dt                1.0
)


@REM SAMPLE 8 -----------------------------------------------------------------
set "numbers=18"
for %%i in (%numbers%) do (
    echo %%i
    python D:/Code/simOmPP/combineEnsight.py ^
    --resultFolders     D:/Paper4/Simulations/invivo/mi/sample8/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295 ^
                        D:/Paper4/Simulations/invivo/mi/sample8/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_continue ^
    --resPath           D:/Paper4/Simulations/invivo/mi/sample8/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_total ^
    --simType           tissue ^
    --dt                1.0

    python D:/Code/simOmPP/combineEnsight.py ^
    --resultFolders     D:/Paper4/Simulations/invivo/mi/sample8/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295 ^
                        D:/Paper4/Simulations/invivo/mi/sample8/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_continue ^
    --resPath           D:/Paper4/Simulations/invivo/mi/sample8/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_total ^
    --simType           cs ^
    --dt                1.0
)



@REM SAMPLE 9 -----------------------------------------------------------------
set "numbers=8 11 14"
for %%i in (%numbers%) do (
    echo %%i
    python D:/Code/simOmPP/combineEnsight.py ^
    --resultFolders     D:/Paper4/Simulations/invivo/mi/sample9/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295 ^
                        D:/Paper4/Simulations/invivo/mi/sample9/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_continue ^
    --resPath           D:/Paper4/Simulations/invivo/mi/sample9/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_total ^
    --simType           tissue ^
    --dt                1.0

    python D:/Code/simOmPP/combineEnsight.py ^
    --resultFolders     D:/Paper4/Simulations/invivo/mi/sample9/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295 ^
                        D:/Paper4/Simulations/invivo/mi/sample9/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_continue ^
    --resPath           D:/Paper4/Simulations/invivo/mi/sample9/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_total ^
    --simType           cs ^
    --dt                1.0
)


@REM SAMPLE 10 -----------------------------------------------------------------
set "numbers=9 18"
for %%i in (%numbers%) do (
    echo %%i
    python D:/Code/simOmPP/combineEnsight.py ^
    --resultFolders     D:/Paper4/Simulations/invivo/mi/sample10/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295 ^
                        D:/Paper4/Simulations/invivo/mi/sample10/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_continue ^
    --resPath           D:/Paper4/Simulations/invivo/mi/sample10/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_total ^
    --simType           tissue ^
    --dt                1.0

    python D:/Code/simOmPP/combineEnsight.py ^
    --resultFolders     D:/Paper4/Simulations/invivo/mi/sample10/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295 ^
                        D:/Paper4/Simulations/invivo/mi/sample10/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_continue ^
    --resPath           D:/Paper4/Simulations/invivo/mi/sample10/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_total ^
    --simType           cs ^
    --dt                1.0
)



@REM SAMPLE 11 -----------------------------------------------------------------
set "numbers=5 7 8 18"
for %%i in (%numbers%) do (
    echo %%i
    python D:/Code/simOmPP/combineEnsight.py ^
    --resultFolders     D:/Paper4/Simulations/invivo/mi/sample11/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295 ^
                        D:/Paper4/Simulations/invivo/mi/sample11/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_continue ^
    --resPath           D:/Paper4/Simulations/invivo/mi/sample11/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_total ^
    --simType           tissue ^
    --dt                1.0

    python D:/Code/simOmPP/combineEnsight.py ^
    --resultFolders     D:/Paper4/Simulations/invivo/mi/sample11/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295 ^
                        D:/Paper4/Simulations/invivo/mi/sample11/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_continue ^
    --resPath           D:/Paper4/Simulations/invivo/mi/sample11/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_total ^
    --simType           cs ^
    --dt                1.0
)

@REM SAMPLE 12 -----------------------------------------------------------------
set "numbers=7 18"
for %%i in (%numbers%) do (
    echo %%i
    python D:/Code/simOmPP/combineEnsight.py ^
    --resultFolders     D:/Paper4/Simulations/invivo/mi/sample12/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295 ^
                        D:/Paper4/Simulations/invivo/mi/sample12/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_continue ^
    --resPath           D:/Paper4/Simulations/invivo/mi/sample12/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_total ^
    --simType           tissue ^
    --dt                1.0

    python D:/Code/simOmPP/combineEnsight.py ^
    --resultFolders     D:/Paper4/Simulations/invivo/mi/sample12/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295 ^
                        D:/Paper4/Simulations/invivo/mi/sample12/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_continue ^
    --resPath           D:/Paper4/Simulations/invivo/mi/sample12/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_total ^
    --simType           cs ^
    --dt                1.0
)