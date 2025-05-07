@ECHO OFF
call conda activate simOmPP


@REM @REM SAMPLE 6_x -----------------------------------------------------------------
@REM echo "Sample6_x ------------------------------------------"
@REM python D:/Code/simOmPP/makeVideosWithParaview.py ^
@REM --resultsFolderPath     E:/Paper4/Simulations/invivo/mi_nocs/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA14_S2_295 ^
@REM                         E:/Paper4/Simulations/invivo/mi_nocs/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA17_S2_295 ^
@REM --paraviewScriptPath    E:/Paper4/Simulations/invivo/mi_nocs/sample6_x/S2_295/make_tissue_video_1305ms.py

@REM python D:/Code/simOmPP/makeVideosWithParaview.py ^
@REM --resultsFolderPath     E:/Paper4/Simulations/invivo/mi_nocs/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA3_S2_295_total ^
@REM --paraviewScriptPath    E:/Paper4/Simulations/invivo/mi_nocs/sample6_x/S2_295/make_tissue_video_2305ms.py

@REM @REM SAMPLE 7 -----------------------------------------------------------------
@REM echo "Sample7 ------------------------------------------"
@REM python D:/Code/simOmPP/makeVideosWithParaview.py ^
@REM --resultsFolderPath     E:/Paper4/Simulations/invivo/mi_nocs/sample7/S2_295/results_mi_CL600_1800ms_stimAHA1_S2_295 ^
@REM                         E:/Paper4/Simulations/invivo/mi_nocs/sample7/S2_295/results_mi_CL600_1800ms_stimAHA14_S2_295 ^
@REM                         E:/Paper4/Simulations/invivo/mi_nocs/sample7/S2_295/results_mi_CL600_1800ms_stimAHA17_S2_295 ^
@REM --paraviewScriptPath    E:/Paper4/Simulations/invivo/mi_nocs/sample7/S2_295/make_tissue_video_1305ms.py



@REM SAMPLE 11 -----------------------------------------------------------------
echo "Sample11 ------------------------------------------"
python D:/Code/simOmPP/makeVideosWithParaview.py ^
--resultsFolderPath     E:/Paper4/Simulations/invivo/mi_nocs/sample11/S2_295/results_mi_CL600_1800ms_stimAHA7_S2_295 ^
                        E:/Paper4/Simulations/invivo/mi_nocs/sample11/S2_295/results_mi_CL600_1800ms_stimAHA8_S2_295 ^
                        E:/Paper4/Simulations/invivo/mi_nocs/sample11/S2_295/results_mi_CL600_1800ms_stimAHA18_S2_295 ^
--paraviewScriptPath    E:/Paper4/Simulations/invivo/mi_nocs/sample11/S2_295/make_tissue_video_antpos_1305ms.py

python D:/Code/simOmPP/makeVideosWithParaview.py ^
--resultsFolderPath     E:/Paper4/Simulations/invivo/mi_nocs/sample11/S2_295/results_mi_CL600_1800ms_stimAHA5_S2_295_total ^
--paraviewScriptPath    E:/Paper4/Simulations/invivo/mi_nocs/sample11/S2_295/make_tissue_video_antpos_2305ms.py



@REM SAMPLE 12 -----------------------------------------------------------------
echo "Sample12 ------------------------------------------"
python D:/Code/simOmPP/makeVideosWithParaview.py ^
--resultsFolderPath     E:/Paper4/Simulations/invivo/mi_nocs/sample12/S2_295/results_mi_CL600_1800ms_stimAHA5_S2_295 ^
                        E:/Paper4/Simulations/invivo/mi_nocs/sample12/S2_295/results_mi_CL600_1800ms_stimAHA7_S2_295 ^
                        E:/Paper4/Simulations/invivo/mi_nocs/sample12/S2_295/results_mi_CL600_1800ms_stimAHA18_S2_295 ^
--paraviewScriptPath    E:/Paper4/Simulations/invivo/mi_nocs/sample12/S2_295/make_tissue_video_antpos_1305ms.py

python D:/Code/simOmPP/makeVideosWithParaview.py ^
--resultsFolderPath     E:/Paper4/Simulations/invivo/mi_nocs/sample12/S2_295/results_mi_CL600_1800ms_stimAHA6_S2_295_total ^
                        E:/Paper4/Simulations/invivo/mi_nocs/sample12/S2_295/results_mi_CL600_1800ms_stimAHA8_S2_295_total ^
                        E:/Paper4/Simulations/invivo/mi_nocs/sample12/S2_295/results_mi_CL600_1800ms_stimAHA12_S2_295_total ^
--paraviewScriptPath    E:/Paper4/Simulations/invivo/mi_nocs/sample12/S2_295/make_tissue_video_antpos_2305ms.py