@REM @ECHO OFF
call conda activate simOmPP

@REM python D:/Code/simOmPP/getResults.py ^
@REM --resPath       D:/Paper4/Simulations/invivo/mi_EHT2/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total/tissue ^
@REM --myResPath     D:/Paper4/Simulations/invivo/mi_EHT2/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total/myresults_atapd_layers.vtk ^
@REM --meshPath      D:/Paper4/Models/sample6_x/EHT2/mesh/mesh_no_scar.vtk ^
@REM --timeStart     0 ^
@REM --timeEnd       304 ^
@REM --nDigits       4 ^
@REM --apd           90 ^
@REM --dt            1 ^
@REM --spaceUnit     mm ^
@REM --maxMem        16 ^
@REM --nCores        12 ^
@REM --maxDist       1 ^
@REM --maxCV         300 ^
@REM --resExcel      D:/Paper4/Simulations/invivo/mi_EHT2/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total/results.xlsx


@REM python D:/Code/simOmPP/getResults.py ^
@REM --resPath       E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total/tissue ^
@REM --myResPath     E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total/myresults_atapd_layers.vtk ^
@REM --meshPath      D:/Paper4/Models/sample6_x/EHT2/mesh/mesh_no_scar.vtk ^
@REM --timeStart     0 ^
@REM --timeEnd       304 ^
@REM --nDigits       4 ^
@REM --apd           90 ^
@REM --dt            1 ^
@REM --spaceUnit     mm ^
@REM --maxMem        16 ^
@REM --nCores        12 ^
@REM --maxDist       1 ^
@REM --maxCV         300 ^
@REM --resExcel      E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total/results.xlsx


@REM python D:/Code/simOmPP/getResults.py ^
@REM --resPath       G:/Paper4/Simulations/invivo/mi/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295/tissue ^
@REM --myResPath     G:/Paper4/Simulations/invivo/mi/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295/myresults_atapd_layers.vtk ^
@REM --meshPath      F:/Paper3/Models/invivo/mi/cx/sample6_x/mesh_mi_noscar.vtk ^
@REM --timeStart     0 ^
@REM --timeEnd       304 ^
@REM --nDigits       4 ^
@REM --apd           90 ^
@REM --dt            1 ^
@REM --spaceUnit     mm ^
@REM --maxMem        16 ^
@REM --nCores        12 ^
@REM --maxDist       1 ^
@REM --maxCV         300 ^
@REM --resExcel      G:/Paper4/Simulations/invivo/mi/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295/results.xlsx


@REM python D:/Code/simOmPP/getCVfromSimMesh.py ^
@REM --meshPath    D:/Paper4/Simulations/invivo/mi_EHT1/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total/sample6x_ATs_CVs_epi_lateral_view_06.vtu ^
@REM --spaceUnit   mm ^
@REM --maxDist     0.6 ^
@REM --maxCV       1000 ^
@REM --resExcel    D:/Paper4/Simulations/invivo/mi_EHT1/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total/results_epi_cv_from_epi_at.xlsx

@REM python D:/Code/simOmPP/getCVfromSimMesh.py ^
@REM --meshPath    D:/Paper4/Simulations/invivo/mi_EHT1/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total/sample6x_ATs_CVs_epi_lateral_view_10.vtu ^
@REM --spaceUnit   mm ^
@REM --maxDist     1 ^
@REM --maxCV       1000 ^
@REM --resExcel    D:/Paper4/Simulations/invivo/mi_EHT1/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total/results_epi_cv_from_epi_at.xlsx



@REM python D:/Code/simOmPP/getCVfromSimMesh.py ^
@REM --meshPath    D:/Paper4/Simulations/invivo/mi_EHT1/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total/sample6x_ATs_CVs_epi_lateral_view_20.vtu ^
@REM --spaceUnit   mm ^
@REM --maxDist     2 ^
@REM --maxCV       1000 ^
@REM --resExcel    D:/Paper4/Simulations/invivo/mi_EHT1/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total/results_epi_cv_from_epi_at.xlsx

@REM python D:/Code/simOmPP/getCVfromSimMesh.py ^
@REM --meshPath    D:/Paper4/Simulations/invivo/mi_EHT1/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total/sample6x_ATs_CVs_epi_lateral_view_30.vtu ^
@REM --spaceUnit   mm ^
@REM --maxDist     3 ^
@REM --maxCV       1000 ^
@REM --resExcel    D:/Paper4/Simulations/invivo/mi_EHT1/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total/results_epi_cv_from_epi_at.xlsx

@REM python D:/Code/simOmPP/getCVfromSimMesh.py ^
@REM --meshPath    D:/Paper4/Simulations/invivo/mi_EHT1/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total/sample6x_ATs_CVs_epi_lateral_view_40.vtu ^
@REM --spaceUnit   mm ^
@REM --maxDist     4 ^
@REM --maxCV       1000 ^
@REM --resExcel    D:/Paper4/Simulations/invivo/mi_EHT1/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total/results_epi_cv_from_epi_at.xlsx


@REM python D:/Code/simOmPP/getCVfromSimMesh.py ^
@REM --meshPath    D:/Paper4/Simulations/invivo/mi_EHT1/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total/sample6x_ATs_CVs_epi_lateral_view_50.vtu ^
@REM --spaceUnit   mm ^
@REM --maxDist     5 ^
@REM --maxCV       1000 ^
@REM --resExcel    D:/Paper4/Simulations/invivo/mi_EHT1/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total/results_epi_cv_from_epi_at.xlsx

@REM python D:/Code/simOmPP/getCVfromSimMesh.py ^
@REM --meshPath    D:/Paper4/Simulations/invivo/mi_EHT1/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total/sample6x_ATs_CVs_epi_lateral_view_60.vtu ^
@REM --spaceUnit   mm ^
@REM --maxDist     6 ^
@REM --maxCV       1000 ^
@REM --resExcel    D:/Paper4/Simulations/invivo/mi_EHT1/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total/results_epi_cv_from_epi_at.xlsx


@REM python D:/Code/simOmPP/getCVfromSimMesh.py ^
@REM --meshPath    D:/Paper4/Simulations/invivo/mi_EHT1/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total/sample6x_ATs_CVs_epi_lateral_view_70.vtu ^
@REM --spaceUnit   mm ^
@REM --maxDist     7 ^
@REM --maxCV       1000 ^
@REM --resExcel    D:/Paper4/Simulations/invivo/mi_EHT1/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total/results_epi_cv_from_epi_at.xlsx


@REM python D:/Code/simOmPP/getCVfromSimMesh.py ^
@REM --meshPath    D:/Paper4/Simulations/invivo/mi_EHT1/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total/sample6x_ATs_CVs_epi_lateral_view_80.vtu ^
@REM --spaceUnit   mm ^
@REM --maxDist     8 ^
@REM --maxCV       1000 ^
@REM --resExcel    D:/Paper4/Simulations/invivo/mi_EHT1/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total/results_epi_cv_from_epi_at.xlsx





@REM python D:/Code/simOmPP/getCVfromSimMesh.py ^
@REM --meshPath    E:/Paper4/Simulations/invivo/mi_EHT1_highcond/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total/sample6x_ATs_CVs_epi_lateral_view_10.vtu ^
@REM --spaceUnit   mm ^
@REM --maxDist     1 ^
@REM --maxCV       1000 ^
@REM --resExcel    E:/Paper4/Simulations/invivo/mi_EHT1_highcond/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total/results_epi_cv_from_epi_at.xlsx

@REM python D:/Code/simOmPP/getCVfromSimMesh.py ^
@REM --meshPath    E:/Paper4/Simulations/invivo/mi_EHT1_highcond/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total/sample6x_ATs_CVs_epi_lateral_view_20.vtu ^
@REM --spaceUnit   mm ^
@REM --maxDist     2 ^
@REM --maxCV       1000 ^
@REM --resExcel    E:/Paper4/Simulations/invivo/mi_EHT1_highcond/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total/results_epi_cv_from_epi_at.xlsx

@REM python D:/Code/simOmPP/getCVfromSimMesh.py ^
@REM --meshPath    E:/Paper4/Simulations/invivo/mi_EHT1_highcond/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total/sample6x_ATs_CVs_epi_lateral_view_30.vtu ^
@REM --spaceUnit   mm ^
@REM --maxDist     3 ^
@REM --maxCV       1000 ^
@REM --resExcel    E:/Paper4/Simulations/invivo/mi_EHT1_highcond/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total/results_epi_cv_from_epi_at.xlsx








@REM python D:/Code/simOmPP/getCVfromSimMesh.py ^
@REM --meshPath    D:/Paper4/Simulations/invivo/mi_EHT2/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total/sample6x_ATs_CVs_epi_lateral_view_10.vtu ^
@REM --spaceUnit   mm ^
@REM --maxDist     1 ^
@REM --maxCV       1000 ^
@REM --resExcel    D:/Paper4/Simulations/invivo/mi_EHT2/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total/results_epi_cv_from_epi_at.xlsx

@REM python D:/Code/simOmPP/getCVfromSimMesh.py ^
@REM --meshPath    D:/Paper4/Simulations/invivo/mi_EHT2/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total/sample6x_ATs_CVs_epi_lateral_view_20.vtu ^
@REM --spaceUnit   mm ^
@REM --maxDist     2 ^
@REM --maxCV       1000 ^
@REM --resExcel    D:/Paper4/Simulations/invivo/mi_EHT2/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total/results_epi_cv_from_epi_at.xlsx

@REM python D:/Code/simOmPP/getCVfromSimMesh.py ^
@REM --meshPath    D:/Paper4/Simulations/invivo/mi_EHT2/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total/sample6x_ATs_CVs_epi_lateral_view_30.vtu ^
@REM --spaceUnit   mm ^
@REM --maxDist     3 ^
@REM --maxCV       1000 ^
@REM --resExcel    D:/Paper4/Simulations/invivo/mi_EHT2/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total/results_epi_cv_from_epi_at.xlsx



@REM python D:/Code/simOmPP/getCVfromSimMesh.py ^
@REM --meshPath    E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total/sample6x_ATs_CVs_epi_lateral_view_10.vtu ^
@REM --spaceUnit   mm ^
@REM --maxDist     1 ^
@REM --maxCV       1000 ^
@REM --resExcel    E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total/results_epi_cv_from_epi_at.xlsx

@REM python D:/Code/simOmPP/getCVfromSimMesh.py ^
@REM --meshPath    E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total/sample6x_ATs_CVs_epi_lateral_view_20.vtu ^
@REM --spaceUnit   mm ^
@REM --maxDist     2 ^
@REM --maxCV       1000 ^
@REM --resExcel    E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total/results_epi_cv_from_epi_at.xlsx

@REM python D:/Code/simOmPP/getCVfromSimMesh.py ^
@REM --meshPath    E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total/sample6x_ATs_CVs_epi_lateral_view_30.vtu ^
@REM --spaceUnit   mm ^
@REM --maxDist     3 ^
@REM --maxCV       1000 ^
@REM --resExcel    E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total/results_epi_cv_from_epi_at.xlsx






@REM python D:/Code/simOmPP/getCVfromSimMesh.py ^
@REM --meshPath    G:/Paper4/Simulations/invivo/mi/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295/sample6x_ATs_CVs_epi_lateral_view_20.vtu ^
@REM --spaceUnit   mm ^
@REM --maxDist     2 ^
@REM --maxCV       1000 ^
@REM --resExcel    G:/Paper4/Simulations/invivo/mi/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295/results_epi_cv_from_epi_at.xlsx


@REM python D:/Code/simOmPP/getCVfromSimMesh.py ^
@REM --meshPath    G:/Paper4/Simulations/invivo/mi/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295/sample6x_ATs_CVs_epi_posterior_view_20.vtu ^
@REM --spaceUnit   mm ^
@REM --maxDist     2 ^
@REM --maxCV       1000 ^
@REM --resExcel    G:/Paper4/Simulations/invivo/mi/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295/results_epi_cv_from_epi_at.xlsx



@REM  Review anterograde retrograde pmj results

@REM python D:/Code/simOmPP/getResults.py ^
@REM --resPath       G:/Paper4/Simulations/invivo/mi/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295/tissue ^
@REM --myResPath     G:/Paper4/Simulations/invivo/mi/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295/biv_ats.vtk ^
@REM --meshPath      F:/Paper3/Models/invivo/mi/cx/sample6_x/mesh_mi_noscar.vtk ^
@REM --timeStart     0 ^
@REM --timeEnd       304 ^
@REM --nDigits       4 ^
@REM --apd           90 ^
@REM --dt            1 ^
@REM --spaceUnit     mm ^
@REM --maxMem        16 ^
@REM --nCores        12 ^
@REM --maxDist       1 ^
@REM --maxCV         300 ^
@REM --resExcel      G:/Paper4/Simulations/invivo/mi/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295/results.xlsx



@REM python D:/Code/simOmPP/getResults.py ^
@REM --resPath       G:/Paper4/Simulations/invivo/mi/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295/cs ^
@REM --myResPath     G:/Paper4/Simulations/invivo/mi/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295/cs_ats.vtk ^
@REM --meshPath      F:/Paper3/Models/invivo/mi/cx/sample6_x/stim/cs/final/cs_subendo_intramyo.vtk ^
@REM --soluName      cs_solution ^
@REM --timeStart     0 ^
@REM --timeEnd       304 ^
@REM --nDigits       4 ^
@REM --apd           90 ^
@REM --dt            1 ^
@REM --spaceUnit     mm ^
@REM --maxMem        16 ^
@REM --nCores        12 ^
@REM --maxDist       1 ^
@REM --maxCV         300 ^
@REM --resExcel      G:/Paper4/Simulations/invivo/mi/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295/results.xlsx