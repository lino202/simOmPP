@REM @ECHO OFF
call conda activate simOmPP

@REM @REM SAMPLE 8 -----------------------------------------------------------------
python D:/Simulations/simOmPP/getResultsToExcel.py ^
--meshPath    D:/Paper3/Simulations/invivo/mi/la/sample8/results_mi_baseline_gk1_50_sigma_000095_800ms/myresults.vtk ^
--resExcel    D:/Paper3/Simulations/invivo/mi/la/results_vol.xlsx

@REM @REM SAMPLE 9------------------------------------------------

python D:/Simulations/simOmPP/getResultsToExcel.py ^
--meshPath    D:/Paper3/Simulations/invivo/mi/la/sample9/results_mi_baseline_gk1_50_sigma_000095_800ms/myresults.vtk ^
--resExcel    D:/Paper3/Simulations/invivo/mi/la/results_vol.xlsx


@REM @REM SAMPLE 10------------------------------------------------

python D:/Simulations/simOmPP/getResultsToExcel.py ^
--meshPath    D:/Paper3/Simulations/invivo/mi/la/sample10/results_mi_baseline_gk1_50_sigma_000095_800ms/myresults.vtk ^
--resExcel    D:/Paper3/Simulations/invivo/mi/la/results_vol.xlsx


@REM @REM SAMPLE 11------------------------------------------------

python D:/Simulations/simOmPP/getResultsToExcel.py ^
--meshPath    D:/Paper3/Simulations/invivo/mi/la/sample11/results_mi_baseline_gk1_50_sigma_000095_800ms/myresults.vtk ^
--resExcel    D:/Paper3/Simulations/invivo/mi/la/results_vol.xlsx

@REM @REM SAMPLE 12------------------------------------------------

@REM python D:/Simulations/simOmPP/getResultsToExcel.py ^
@REM --meshPath    D:/Paper3/Simulations/invivo/mi/la/sample12/results_mi_baseline_gk1_50_sigma_000095_800ms/myresults.vtk ^
@REM --resExcel    D:/Paper3/Simulations/invivo/mi/la/results_vol.xlsx

