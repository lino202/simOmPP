@REM @ECHO OFF
call conda activate simOmPP

@REM SAMPLE 8 -----------------------------------------------------------------
python D:/Simulations/simOmPP/getResultsToExcel.py ^
--meshPath    D:/Paper3/Simulations/invivo/mi/la/sample8/results_mi_baseline_gk1_50_sigma_0000675_800ms/results_anterior_view.vtk ^
--resExcel    D:/Paper3/Simulations/invivo/mi/la/results_epi.xlsx


python D:/Simulations/simOmPP/getResultsToExcel.py ^
--meshPath    D:/Paper3/Simulations/invivo/mi/la/sample8/results_mi_baseline_gk1_50_sigma_0000675_800ms/results_posterior_view.vtk ^
--resExcel    D:/Paper3/Simulations/invivo/mi/la/results_epi.xlsx


@REM SAMPLE 9 -----------------------------------------------------------------
python D:/Simulations/simOmPP/getResultsToExcel.py ^
--meshPath    D:/Paper3/Simulations/invivo/mi/la/sample9/results_mi_baseline_gk1_50_sigma_0000675_800ms/results_anterior_view.vtk ^
--resExcel    D:/Paper3/Simulations/invivo/mi/la/results_epi.xlsx


python D:/Simulations/simOmPP/getResultsToExcel.py ^
--meshPath    D:/Paper3/Simulations/invivo/mi/la/sample9/results_mi_baseline_gk1_50_sigma_0000675_800ms/results_posterior_view.vtk ^
--resExcel    D:/Paper3/Simulations/invivo/mi/la/results_epi.xlsx


@REM SAMPLE 10 -----------------------------------------------------------------
python D:/Simulations/simOmPP/getResultsToExcel.py ^
--meshPath    D:/Paper3/Simulations/invivo/mi/la/sample10/results_mi_baseline_gk1_50_sigma_0000675_800ms/results_anterior_view.vtk ^
--resExcel    D:/Paper3/Simulations/invivo/mi/la/results_epi.xlsx


python D:/Simulations/simOmPP/getResultsToExcel.py ^
--meshPath    D:/Paper3/Simulations/invivo/mi/la/sample10/results_mi_baseline_gk1_50_sigma_0000675_800ms/results_posterior_view.vtk ^
--resExcel    D:/Paper3/Simulations/invivo/mi/la/results_epi.xlsx


@REM SAMPLE 11 -----------------------------------------------------------------
python D:/Simulations/simOmPP/getResultsToExcel.py ^
--meshPath    D:/Paper3/Simulations/invivo/mi/la/sample11/results_mi_baseline_gk1_50_sigma_0000675_800ms/results_anterior_view.vtk ^
--resExcel    D:/Paper3/Simulations/invivo/mi/la/results_epi.xlsx


python D:/Simulations/simOmPP/getResultsToExcel.py ^
--meshPath    D:/Paper3/Simulations/invivo/mi/la/sample11/results_mi_baseline_gk1_50_sigma_0000675_800ms/results_posterior_view.vtk ^
--resExcel    D:/Paper3/Simulations/invivo/mi/la/results_epi.xlsx


@REM SAMPLE 12 -----------------------------------------------------------------
python D:/Simulations/simOmPP/getResultsToExcel.py ^
--meshPath    D:/Paper3/Simulations/invivo/mi/la/sample12/results_mi_baseline_gk1_50_sigma_0000675_800ms/results_anterior_view.vtk ^
--resExcel    D:/Paper3/Simulations/invivo/mi/la/results_epi.xlsx


python D:/Simulations/simOmPP/getResultsToExcel.py ^
--meshPath    D:/Paper3/Simulations/invivo/mi/la/sample12/results_mi_baseline_gk1_50_sigma_0000675_800ms/results_posterior_view.vtk ^
--resExcel    D:/Paper3/Simulations/invivo/mi/la/results_epi.xlsx





