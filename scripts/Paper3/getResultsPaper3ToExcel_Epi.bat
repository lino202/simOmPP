@REM @ECHO OFF
call conda activate simOmPP

@REM @REM @REM SAMPLE 1 -----------------------------------------------------------------
@REM python D:/Code/simOmPP/getResultsToExcel.py ^
@REM --meshPath    D:/Paper3/Simulations/invivo/he/sample1/results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL1000_meijbord/results_anterior_view.vtk ^
@REM --resExcel    D:/Paper3/Simulations/invivo/he/results_epi.xlsx

@REM python D:/Code/simOmPP/getResultsToExcel.py ^
@REM --meshPath    D:/Paper3/Simulations/invivo/he/sample1/results_fib_fromdwi_cs_intra_gaur_rv_septum_lv_down_CL1000_meijbord/results_anterior_view.vtk ^
@REM --resExcel    D:/Paper3/Simulations/invivo/he/results_epi.xlsx


@REM python D:/Code/simOmPP/getResultsToExcel.py ^
@REM --meshPath    D:/Paper3/Simulations/invivo/he/sample1/results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL1000_meijbord/results_posterior_view.vtk ^
@REM --resExcel    D:/Paper3/Simulations/invivo/he/results_epi.xlsx

@REM python D:/Code/simOmPP/getResultsToExcel.py ^
@REM --meshPath    D:/Paper3/Simulations/invivo/he/sample1/results_fib_fromdwi_cs_intra_gaur_rv_septum_lv_down_CL1000_meijbord/results_posterior_view.vtk ^
@REM --resExcel    D:/Paper3/Simulations/invivo/he/results_epi.xlsx




@REM @REM SAMPLE 2------------------------------------------------
@REM python D:/Code/simOmPP/getResultsToExcel.py ^
@REM --meshPath    D:/Paper3/Simulations/invivo/he/sample2/results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL1000_meijbord/results_anterior_view.vtk ^
@REM --resExcel    D:/Paper3/Simulations/invivo/he/results_epi.xlsx

@REM python D:/Code/simOmPP/getResultsToExcel.py ^
@REM --meshPath    D:/Paper3/Simulations/invivo/he/sample2/results_fib_fromdwi_cs_intra_gaur_rv_septum_lv_down_CL1000_meijbord/results_anterior_view.vtk ^
@REM --resExcel    D:/Paper3/Simulations/invivo/he/results_epi.xlsx


@REM python D:/Code/simOmPP/getResultsToExcel.py ^
@REM --meshPath    D:/Paper3/Simulations/invivo/he/sample2/results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL1000_meijbord/results_posterior_view.vtk ^
@REM --resExcel    D:/Paper3/Simulations/invivo/he/results_epi.xlsx

@REM python D:/Code/simOmPP/getResultsToExcel.py ^
@REM --meshPath    D:/Paper3/Simulations/invivo/he/sample2/results_fib_fromdwi_cs_intra_gaur_rv_septum_lv_down_CL1000_meijbord/results_posterior_view.vtk ^
@REM --resExcel    D:/Paper3/Simulations/invivo/he/results_epi.xlsx


@REM @REM @REM SAMPLE 3------------------------------------------------
@REM python D:/Code/simOmPP/getResultsToExcel.py ^
@REM --meshPath    D:/Paper3/Simulations/invivo/he/sample3/results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL1000_meijbord/results_anterior_view.vtk ^
@REM --resExcel    D:/Paper3/Simulations/invivo/he/results_epi.xlsx

@REM python D:/Code/simOmPP/getResultsToExcel.py ^
@REM --meshPath    D:/Paper3/Simulations/invivo/he/sample3/results_fib_fromdwi_cs_intra_gaur_rv_septum_lv_down_CL1000_meijbord/results_anterior_view.vtk ^
@REM --resExcel    D:/Paper3/Simulations/invivo/he/results_epi.xlsx


@REM python D:/Code/simOmPP/getResultsToExcel.py ^
@REM --meshPath    D:/Paper3/Simulations/invivo/he/sample3/results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL1000_meijbord/results_posterior_view.vtk ^
@REM --resExcel    D:/Paper3/Simulations/invivo/he/results_epi.xlsx

@REM python D:/Code/simOmPP/getResultsToExcel.py ^
@REM --meshPath    D:/Paper3/Simulations/invivo/he/sample3/results_fib_fromdwi_cs_intra_gaur_rv_septum_lv_down_CL1000_meijbord/results_posterior_view.vtk ^
@REM --resExcel    D:/Paper3/Simulations/invivo/he/results_epi.xlsx



@REM review

python D:/Code/simOmPP/getResultsToExcel.py ^
--meshPath    F:/Paper3/Simulations/invivo/he/sample1/results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769_meijbord/results_anterior_view.vtu ^
--resExcel    F:/Paper3/Simulations/invivo/he/sample1/results_epi_review.xlsx ^
--oldLayers

python D:/Code/simOmPP/getResultsToExcel.py ^
--meshPath    F:/Paper3/Simulations/invivo/he/sample1/results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769_meijbord_APDSHL1/results_anterior_view.vtu ^
--resExcel    F:/Paper3/Simulations/invivo/he/sample1/results_epi_review.xlsx ^
--oldLayers

python D:/Code/simOmPP/getResultsToExcel.py ^
--meshPath    F:/Paper3/Simulations/invivo/he/sample1/results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769_meijbord_APDSHL2/results_anterior_view.vtu ^
--resExcel    F:/Paper3/Simulations/invivo/he/sample1/results_epi_review.xlsx ^
--oldLayers

python D:/Code/simOmPP/getResultsToExcel.py ^
--meshPath    F:/Paper3/Simulations/invivo/he/sample1/results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769_meijbord_APDSHL3/results_anterior_view.vtu ^
--resExcel    F:/Paper3/Simulations/invivo/he/sample1/results_epi_review.xlsx ^
--oldLayers

python D:/Code/simOmPP/getResultsToExcel.py ^
--meshPath    F:/Paper3/Simulations/invivo/he/sample1/results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769_meijbord_APDSHL4/results_anterior_view.vtu ^
--resExcel    F:/Paper3/Simulations/invivo/he/sample1/results_epi_review.xlsx ^
--oldLayers

python D:/Code/simOmPP/getResultsToExcel.py ^
--meshPath    F:/Paper3/Simulations/invivo/he/sample1/results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769_meijbord_APDSHL5/results_anterior_view.vtu ^
--resExcel    F:/Paper3/Simulations/invivo/he/sample1/results_epi_review.xlsx ^
--oldLayers

python D:/Code/simOmPP/getResultsToExcel.py ^
--meshPath    F:/Paper3/Simulations/invivo/he/sample1/results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769_meijbord_APDSHL6/results_anterior_view.vtu ^
--resExcel    F:/Paper3/Simulations/invivo/he/sample1/results_epi_review.xlsx ^
--oldLayers

python D:/Code/simOmPP/getResultsToExcel.py ^
--meshPath    F:/Paper3/Simulations/invivo/he/sample1/results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769_meijbord_APDSHT1/results_anterior_view.vtu ^
--resExcel    F:/Paper3/Simulations/invivo/he/sample1/results_epi_review.xlsx ^
--oldLayers

python D:/Code/simOmPP/getResultsToExcel.py ^
--meshPath    F:/Paper3/Simulations/invivo/he/sample1/results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769_meijbord_APDSHT2/results_anterior_view.vtu ^
--resExcel    F:/Paper3/Simulations/invivo/he/sample1/results_epi_review.xlsx ^
--oldLayers

python D:/Code/simOmPP/getResultsToExcel.py ^
--meshPath    F:/Paper3/Simulations/invivo/he/sample1/results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769_meijbord_APDSHT3/results_anterior_view.vtu ^
--resExcel    F:/Paper3/Simulations/invivo/he/sample1/results_epi_review.xlsx ^
--oldLayers

python D:/Code/simOmPP/getResultsToExcel.py ^
--meshPath    F:/Paper3/Simulations/invivo/he/sample1/results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769_meijbord_APDSHT4/results_anterior_view.vtu ^
--resExcel    F:/Paper3/Simulations/invivo/he/sample1/results_epi_review.xlsx ^
--oldLayers

python D:/Code/simOmPP/getResultsToExcel.py ^
--meshPath    F:/Paper3/Simulations/invivo/he/sample1/results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769_meijbord_APDSHT5/results_anterior_view.vtu ^
--resExcel    F:/Paper3/Simulations/invivo/he/sample1/results_epi_review.xlsx ^
--oldLayers

python D:/Code/simOmPP/getResultsToExcel.py ^
--meshPath    F:/Paper3/Simulations/invivo/he/sample1/results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769_meijbord_APDSHT6/results_anterior_view.vtu ^
--resExcel    F:/Paper3/Simulations/invivo/he/sample1/results_epi_review.xlsx ^
--oldLayers

python D:/Code/simOmPP/getResultsToExcel.py ^
--meshPath    F:/Paper3/Simulations/invivo/he/sample1/results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL1000_meijbord/results_anterior_view.vtu ^
--resExcel    F:/Paper3/Simulations/invivo/he/sample1/results_epi_review.xlsx ^
--oldLayers

python D:/Code/simOmPP/getResultsToExcel.py ^
--meshPath    F:/Paper3/Simulations/invivo/he/sample1/results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL1000_meijbord_CSLDCm20/results_anterior_view.vtu ^
--resExcel    F:/Paper3/Simulations/invivo/he/sample1/results_epi_review.xlsx ^
--oldLayers

python D:/Code/simOmPP/getResultsToExcel.py ^
--meshPath    F:/Paper3/Simulations/invivo/he/sample1/results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL1000_meijbord_CSLDCp20/results_anterior_view.vtu ^
--resExcel    F:/Paper3/Simulations/invivo/he/sample1/results_epi_review.xlsx ^
--oldLayers

python D:/Code/simOmPP/getResultsToExcel.py ^
--meshPath    F:/Paper3/Simulations/invivo/he/sample1/results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL1000_meijbord_LDCm20/results_anterior_view.vtu ^
--resExcel    F:/Paper3/Simulations/invivo/he/sample1/results_epi_review.xlsx ^
--oldLayers

python D:/Code/simOmPP/getResultsToExcel.py ^
--meshPath    F:/Paper3/Simulations/invivo/he/sample1/results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL1000_meijbord_LDCp20/results_anterior_view.vtu ^
--resExcel    F:/Paper3/Simulations/invivo/he/sample1/results_epi_review.xlsx ^
--oldLayers