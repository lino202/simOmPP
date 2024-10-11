@REM @ECHO OFF
call conda activate simOmPP

@REM @REM SAMPLE 8 -----------------------------------------------------------------
python D:/Code/simOmPP/getResultsToExcel.py ^
--meshPath    D:/Paper3/Simulations/invivo/mi/la/sample8/results_mi_CL1000_3000ms_CUSTOM/myresults.vtk ^
--resExcel    D:/Paper3/Simulations/invivo/mi/la/results_vol.xlsx

@REM @REM SAMPLE 9------------------------------------------------

python D:/Code/simOmPP/getResultsToExcel.py ^
--meshPath    D:/Paper3/Simulations/invivo/mi/la/sample9/results_mi_CL1000_3000ms_CUSTOM/myresults.vtk ^
--resExcel    D:/Paper3/Simulations/invivo/mi/la/results_vol.xlsx


@REM @REM SAMPLE 10------------------------------------------------

python D:/Code/simOmPP/getResultsToExcel.py ^
--meshPath    D:/Paper3/Simulations/invivo/mi/la/sample10/results_mi_CL1000_3000ms_CUSTOM/myresults.vtk ^
--resExcel    D:/Paper3/Simulations/invivo/mi/la/results_vol.xlsx


@REM @REM SAMPLE 11------------------------------------------------

python D:/Code/simOmPP/getResultsToExcel.py ^
--meshPath    D:/Paper3/Simulations/invivo/mi/la/sample11/results_mi_CL1000_3000ms_CUSTOM/myresults.vtk ^
--resExcel    D:/Paper3/Simulations/invivo/mi/la/results_vol.xlsx

@REM @REM SAMPLE 12------------------------------------------------

python D:/Code/simOmPP/getResultsToExcel.py ^
--meshPath    D:/Paper3/Simulations/invivo/mi/la/sample12/results_mi_CL1000_3000ms_CUSTOM/myresults.vtk ^
--resExcel    D:/Paper3/Simulations/invivo/mi/la/results_vol.xlsx

