@ECHO OFF
call conda activate simOmPP

@REM SAMPLE 4 -----------------------------------------------------------------
echo "Sample4 ------------------------------------------"
python D:/Code/simOmPP/makeVideosWithParaview.py ^
--resultsFolderPath     E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample4/S2_295/results_mi_CL600_1800ms_stimAHA4_S2_295 ^
--paraviewScriptPath    E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample4/S2_295/make_cs_tissue_video_1305ms.py


@REM SAMPLE 5 -----------------------------------------------------------------
echo "Sample5 ------------------------------------------"
python D:/Code/simOmPP/makeVideosWithParaview.py ^
--resultsFolderPath     E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample5/S2_295/results_mi_CL600_1800ms_stimAHA3_S2_295_total ^
--paraviewScriptPath    E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample5/S2_295/make_cs_tissue_video_2305ms.py


@REM SAMPLE 6_x -----------------------------------------------------------------
echo "Sample6_X ------------------------------------------"
python D:/Code/simOmPP/makeVideosWithParaview.py ^
--resultsFolderPath     E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total ^
--paraviewScriptPath    E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample6_x/S2_295/make_cs_tissue_video_2305ms.py


@REM SAMPLE 7 -----------------------------------------------------------------
echo "Sample7 ------------------------------------------"
python D:/Code/simOmPP/makeVideosWithParaview.py ^
--resultsFolderPath     E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample7/S2_295/results_mi_CL600_1800ms_stimAHA17_S2_295_total ^
--paraviewScriptPath    E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample7/S2_295/make_cs_tissue_video_2305ms.py


@REM SAMPLE 8 -----------------------------------------------------------------
echo "Sample8 ------------------------------------------"
python D:/Code/simOmPP/makeVideosWithParaview.py ^
--resultsFolderPath     E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample8/S2_295/results_mi_CL600_1800ms_stimAHA4_S2_295 ^
--paraviewScriptPath    E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample8/S2_295/make_cs_tissue_video_antpos_1305ms.py


@REM SAMPLE 9 -----------------------------------------------------------------
echo "Sample9 ------------------------------------------"
python D:/Code/simOmPP/makeVideosWithParaview.py ^
--resultsFolderPath     E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample9/S2_295/results_mi_CL600_1800ms_stimAHA11_S2_295_total ^
--paraviewScriptPath    E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample9/S2_295/make_cs_tissue_video_antpos_2305ms.py



@REM SAMPLE 10 -----------------------------------------------------------------
echo "Sample10 ------------------------------------------"
python D:/Code/simOmPP/makeVideosWithParaview.py ^
--resultsFolderPath     E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample10/S2_295/results_mi_CL600_1800ms_stimAHA9_S2_295_total ^
--paraviewScriptPath    E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample10/S2_295/make_cs_tissue_video_antpos_2305ms.py



@REM SAMPLE 11 -----------------------------------------------------------------
echo "Sample11 ------------------------------------------"
python D:/Code/simOmPP/makeVideosWithParaview.py ^
--resultsFolderPath     E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample11/S2_295/results_mi_CL600_1800ms_stimAHA5_S2_295_total ^
--paraviewScriptPath    E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample11/S2_295/make_cs_tissue_video_antpos_2305ms.py


@REM SAMPLE 12 -----------------------------------------------------------------
echo "Sample12 ------------------------------------------"
python D:/Code/simOmPP/makeVideosWithParaview.py ^
--resultsFolderPath     E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample12/S2_295/results_mi_CL600_1800ms_stimAHA7_S2_295 ^
--paraviewScriptPath    E:/Paper4/Simulations/invivo/mi_EHT2_highcond/sample12/S2_295/make_cs_tissue_video_antpos_1305ms.py
