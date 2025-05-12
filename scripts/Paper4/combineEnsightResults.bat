@ECHO OFF
call conda activate simOmPP

setlocal enabledelayedexpansion

@REM SAMPLE 4 -----------------------------------------------------------------
@REM set "numbers=1 4 17"
@REM for %%i in (%numbers%) do (
@REM     echo %%i
@REM     python D:/Code/simOmPP/combineEnsight.py ^
@REM     --resultFolders     E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample4/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295 ^
@REM                         E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample4/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_continue ^
@REM     --resPath           E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample4/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_total ^
@REM     --simType           tissue ^
@REM     --dt                1.0

@REM     python D:/Code/simOmPP/combineEnsight.py ^
@REM     --resultFolders     E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample4/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295 ^
@REM                         E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample4/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_continue ^
@REM     --resPath           E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample4/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_total ^
@REM     --simType           cs ^
@REM     --dt                1.0
@REM )

@REM SAMPLE 5 -----------------------------------------------------------------
set "numbers=3"
for %%i in (%numbers%) do (
    echo %%i
    python D:/Code/simOmPP/combineEnsight.py ^
    --resultFolders     E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample5/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295 ^
                        E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample5/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_continue ^
    --resPath           E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample5/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_total ^
    --simType           tissue ^
    --dt                1.0

    python D:/Code/simOmPP/combineEnsight.py ^
    --resultFolders     E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample5/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295 ^
                        E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample5/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_continue ^
    --resPath           E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample5/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_total ^
    --simType           cs ^
    --dt                1.0
)


@REM SAMPLE 6 -----------------------------------------------------------------
set "numbers=13"
for %%i in (%numbers%) do (
    echo %%i
    python D:/Code/simOmPP/combineEnsight.py ^
    --resultFolders     E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295 ^
                        E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_continue ^
    --resPath           E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_total ^
    --simType           tissue ^
    --dt                1.0

    python D:/Code/simOmPP/combineEnsight.py ^
    --resultFolders     E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295 ^
                        E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_continue ^
    --resPath           E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_total ^
    --simType           cs ^
    --dt                1.0
)


@REM SAMPLE 7 -----------------------------------------------------------------
set "numbers=17"
for %%i in (%numbers%) do (
    echo %%i
    python D:/Code/simOmPP/combineEnsight.py ^
    --resultFolders     E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample7/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295 ^
                        E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample7/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_continue ^
    --resPath           E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample7/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_total ^
    --simType           tissue ^
    --dt                1.0

    python D:/Code/simOmPP/combineEnsight.py ^
    --resultFolders     E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample7/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295 ^
                        E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample7/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_continue ^
    --resPath           E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample7/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_total ^
    --simType           cs ^
    --dt                1.0
)


@REM @REM SAMPLE 8 -----------------------------------------------------------------
@REM set "numbers=4"
@REM for %%i in (%numbers%) do (
@REM     echo %%i
@REM     python D:/Code/simOmPP/combineEnsight.py ^
@REM     --resultFolders     E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample8/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295 ^
@REM                         E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample8/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_continue ^
@REM     --resPath           E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample8/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_total ^
@REM     --simType           tissue ^
@REM     --dt                1.0

@REM     python D:/Code/simOmPP/combineEnsight.py ^
@REM     --resultFolders     E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample8/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295 ^
@REM                         E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample8/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_continue ^
@REM     --resPath           E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample8/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_total ^
@REM     --simType           cs ^
@REM     --dt                1.0
@REM )



@REM SAMPLE 9 -----------------------------------------------------------------
set "numbers=11"
for %%i in (%numbers%) do (
    echo %%i
    python D:/Code/simOmPP/combineEnsight.py ^
    --resultFolders     E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample9/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295 ^
                        E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample9/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_continue ^
    --resPath           E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample9/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_total ^
    --simType           tissue ^
    --dt                1.0

    python D:/Code/simOmPP/combineEnsight.py ^
    --resultFolders     E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample9/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295 ^
                        E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample9/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_continue ^
    --resPath           E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample9/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_total ^
    --simType           cs ^
    --dt                1.0
)


@REM SAMPLE 10 -----------------------------------------------------------------
set "numbers=9"
for %%i in (%numbers%) do (
    echo %%i
    python D:/Code/simOmPP/combineEnsight.py ^
    --resultFolders     E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample10/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295 ^
                        E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample10/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_continue ^
    --resPath           E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample10/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_total ^
    --simType           tissue ^
    --dt                1.0

    python D:/Code/simOmPP/combineEnsight.py ^
    --resultFolders     E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample10/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295 ^
                        E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample10/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_continue ^
    --resPath           E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample10/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_total ^
    --simType           cs ^
    --dt                1.0
)



@REM SAMPLE 11 -----------------------------------------------------------------
set "numbers=5"
for %%i in (%numbers%) do (
    echo %%i
    python D:/Code/simOmPP/combineEnsight.py ^
    --resultFolders     E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample11/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295 ^
                        E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample11/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_continue ^
    --resPath           E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample11/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_total ^
    --simType           tissue ^
    --dt                1.0

    python D:/Code/simOmPP/combineEnsight.py ^
    --resultFolders     E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample11/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295 ^
                        E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample11/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_continue ^
    --resPath           E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample11/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_total ^
    --simType           cs ^
    --dt                1.0
)

@REM @REM SAMPLE 12 -----------------------------------------------------------------
@REM set "numbers=8 18"
@REM for %%i in (%numbers%) do (
@REM     echo %%i
@REM     python D:/Code/simOmPP/combineEnsight.py ^
@REM     --resultFolders     E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample12/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295 ^
@REM                         E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample12/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_continue ^
@REM     --resPath           E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample12/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_total ^
@REM     --simType           tissue ^
@REM     --dt                1.0

@REM     python D:/Code/simOmPP/combineEnsight.py ^
@REM     --resultFolders     E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample12/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295 ^
@REM                         E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample12/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_continue ^
@REM     --resPath           E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample12/S2_295/results_mi_CL600_1800ms_stimAHA%%i_S2_295_total ^
@REM     --simType           cs ^
@REM     --dt                1.0
@REM )