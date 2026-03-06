@REM @ECHO OFF
call conda activate simOmPP

@REM @REM @REM SAMPLE 8 -----------------------------------------------------------------
@REM python D:/Code/simOmPP/getResultsToExcel.py ^
@REM --meshPath    D:/Paper3/Simulations/invivo/mi/la/sample8/results_mi_CL1000_3000ms_CUSTOM_noscar/myresults_complete.vtk ^
@REM --resExcel    D:/Paper3/Simulations/invivo/mi/la/results_vol.xlsx

@REM @REM @REM SAMPLE 9------------------------------------------------

@REM python D:/Code/simOmPP/getResultsToExcel.py ^
@REM --meshPath    D:/Paper3/Simulations/invivo/mi/la/sample9/results_mi_CL1000_3000ms_CUSTOM_noscar/myresults_complete.vtk ^
@REM --resExcel    D:/Paper3/Simulations/invivo/mi/la/results_vol.xlsx


@REM @REM @REM SAMPLE 10------------------------------------------------

@REM python D:/Code/simOmPP/getResultsToExcel.py ^
@REM --meshPath    D:/Paper3/Simulations/invivo/mi/la/sample10/results_mi_CL1000_3000ms_CUSTOM_noscar/myresults_complete.vtk ^
@REM --resExcel    D:/Paper3/Simulations/invivo/mi/la/results_vol.xlsx


@REM @REM SAMPLE 11------------------------------------------------

@REM python D:/Code/simOmPP/getResultsToExcel.py ^
@REM --meshPath    D:/Paper3/Simulations/invivo/mi/la/sample11/results_mi_CL1000_3000ms_CUSTOM_noscar/myresults_complete.vtk ^
@REM --resExcel    D:/Paper3/Simulations/invivo/mi/la/results_vol.xlsx

@REM @REM SAMPLE 12------------------------------------------------

@REM python D:/Code/simOmPP/getResultsToExcel.py ^
@REM --meshPath    D:/Paper3/Simulations/invivo/mi/la/sample12/results_mi_CL1000_3000ms_CUSTOM_noscar/myresults_complete.vtk ^
@REM --resExcel    D:/Paper3/Simulations/invivo/mi/la/results_vol.xlsx

@REM Review

python D:/Code/simOmPP/getResultsToExcel.py ^
--meshPath    F:/Paper3/Simulations/invivo/mi/cx/sample6_x/results_mi_CL1000_3000ms_AVERAGE_noscar_BASE/myresults.vtk ^
--resExcel    F:/Paper3/Simulations/invivo/mi/cx/sample6_x/results_vol_review.xlsx

python D:/Code/simOmPP/getResultsToExcel.py ^
--meshPath    F:/Paper3/Simulations/invivo/mi/cx/sample6_x/results_mi_CL1000_3000ms_AVERAGE_noscar_BASE_revision_INam15/myresults.vtk ^
--resExcel    F:/Paper3/Simulations/invivo/mi/cx/sample6_x/results_vol_review.xlsx

python D:/Code/simOmPP/getResultsToExcel.py ^
--meshPath    F:/Paper3/Simulations/invivo/mi/cx/sample6_x/results_mi_CL1000_3000ms_AVERAGE_noscar_BASE_revision_INap15/myresults.vtk ^
--resExcel    F:/Paper3/Simulations/invivo/mi/cx/sample6_x/results_vol_review.xlsx