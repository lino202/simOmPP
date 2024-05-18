@REM @ECHO OFF
call conda activate simOmPP

@REM SAMPLE 8 -----------------------------------------------------------------
python D:/Simulations/simOmPP/getCVfromSimMesh.py ^
--meshPath    D:/Paper3/Simulations/invivo/mi/la/sample8/results_mi_baseline/results_anterior_view.vtk ^
--spaceUnit   mm ^
--maxDist     0.6 ^
--maxCV       300 ^
--resExcel    D:/Paper3/Simulations/invivo/mi/la/results_epi_cv_from_epi_at.xlsx


python D:/Simulations/simOmPP/getCVfromSimMesh.py ^
--meshPath    D:/Paper3/Simulations/invivo/mi/la/sample8/results_mi_baseline/results_posterior_view.vtk ^
--spaceUnit   mm ^
--maxDist     0.6 ^
--maxCV       300 ^
--resExcel    D:/Paper3/Simulations/invivo/mi/la/results_epi_cv_from_epi_at.xlsx



@REM SAMPLE 9 -----------------------------------------------------------------
python D:/Simulations/simOmPP/getCVfromSimMesh.py ^
--meshPath    D:/Paper3/Simulations/invivo/mi/la/sample9/results_mi_baseline/results_anterior_view.vtk ^
--spaceUnit   mm ^
--maxDist     0.6 ^
--maxCV       300 ^
--resExcel    D:/Paper3/Simulations/invivo/mi/la/results_epi_cv_from_epi_at.xlsx


python D:/Simulations/simOmPP/getCVfromSimMesh.py ^
--meshPath    D:/Paper3/Simulations/invivo/mi/la/sample9/results_mi_baseline/results_posterior_view.vtk ^
--spaceUnit   mm ^
--maxDist     0.6 ^
--maxCV       300 ^
--resExcel    D:/Paper3/Simulations/invivo/mi/la/results_epi_cv_from_epi_at.xlsx


@REM SAMPLE 10 -----------------------------------------------------------------
python D:/Simulations/simOmPP/getCVfromSimMesh.py ^
--meshPath    D:/Paper3/Simulations/invivo/mi/la/sample10/results_mi_baseline/results_anterior_view.vtk ^
--spaceUnit   mm ^
--maxDist     0.6 ^
--maxCV       300 ^
--resExcel    D:/Paper3/Simulations/invivo/mi/la/results_epi_cv_from_epi_at.xlsx


python D:/Simulations/simOmPP/getCVfromSimMesh.py ^
--meshPath    D:/Paper3/Simulations/invivo/mi/la/sample10/results_mi_baseline/results_posterior_view.vtk ^
--spaceUnit   mm ^
--maxDist     0.6 ^
--maxCV       300 ^
--resExcel    D:/Paper3/Simulations/invivo/mi/la/results_epi_cv_from_epi_at.xlsx


@REM SAMPLE 11 -----------------------------------------------------------------
python D:/Simulations/simOmPP/getCVfromSimMesh.py ^
--meshPath    D:/Paper3/Simulations/invivo/mi/la/sample11/results_mi_baseline/results_anterior_view.vtk ^
--spaceUnit   mm ^
--maxDist     0.6 ^
--maxCV       300 ^
--resExcel    D:/Paper3/Simulations/invivo/mi/la/results_epi_cv_from_epi_at.xlsx


python D:/Simulations/simOmPP/getCVfromSimMesh.py ^
--meshPath    D:/Paper3/Simulations/invivo/mi/la/sample11/results_mi_baseline/results_posterior_view.vtk ^
--spaceUnit   mm ^
--maxDist     0.6 ^
--maxCV       300 ^
--resExcel    D:/Paper3/Simulations/invivo/mi/la/results_epi_cv_from_epi_at.xlsx


@REM SAMPLE 12 -----------------------------------------------------------------
python D:/Simulations/simOmPP/getCVfromSimMesh.py ^
--meshPath    D:/Paper3/Simulations/invivo/mi/la/sample12/results_mi_baseline/results_anterior_view.vtk ^
--spaceUnit   mm ^
--maxDist     0.6 ^
--maxCV       300 ^
--resExcel    D:/Paper3/Simulations/invivo/mi/la/results_epi_cv_from_epi_at.xlsx


python D:/Simulations/simOmPP/getCVfromSimMesh.py ^
--meshPath    D:/Paper3/Simulations/invivo/mi/la/sample12/results_mi_baseline/results_posterior_view.vtk ^
--spaceUnit   mm ^
--maxDist     0.6 ^
--maxCV       300 ^
--resExcel    D:/Paper3/Simulations/invivo/mi/la/results_epi_cv_from_epi_at.xlsx
