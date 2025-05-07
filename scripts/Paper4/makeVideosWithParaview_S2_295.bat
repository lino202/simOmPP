@ECHO OFF
call conda activate simOmPP

@REM SAMPLE 4 -----------------------------------------------------------------
echo "Sample4 ------------------------------------------"
python D:/Code/simOmPP/makeVideosWithParaview.py ^
--resultsFolderPath     G:/Paper4/Simulations/invivo/mi/sample4/S2_295/results_mi_CL600_1800ms_stimAHA1_S2_295 ^
                        G:/Paper4/Simulations/invivo/mi/sample4/S2_295/results_mi_CL600_1800ms_stimAHA2_S2_295 ^
                        G:/Paper4/Simulations/invivo/mi/sample4/S2_295/results_mi_CL600_1800ms_stimAHA4_S2_295 ^
                        G:/Paper4/Simulations/invivo/mi/sample4/S2_295/results_mi_CL600_1800ms_stimAHA12_S2_295 ^
                        G:/Paper4/Simulations/invivo/mi/sample4/S2_295/results_mi_CL600_1800ms_stimAHA14_S2_295 ^
                        G:/Paper4/Simulations/invivo/mi/sample4/S2_295/results_mi_CL600_1800ms_stimAHA17_S2_295 ^
--paraviewScriptPath    G:/Paper4/Simulations/invivo/mi/sample4/S2_295/make_cs_tissue_video_1305ms.py

@REM SAMPLE 5 -----------------------------------------------------------------
echo "Sample5 ------------------------------------------"
python D:/Code/simOmPP/makeVideosWithParaview.py ^
--resultsFolderPath     G:/Paper4/Simulations/invivo/mi/sample5/S2_295/results_mi_CL600_1800ms_stimAHA1_S2_295 ^
--paraviewScriptPath    G:/Paper4/Simulations/invivo/mi/sample5/S2_295/make_cs_tissue_video_1305ms.py

python D:/Code/simOmPP/makeVideosWithParaview.py ^
--resultsFolderPath     G:/Paper4/Simulations/invivo/mi/sample5/S2_295/results_mi_CL600_1800ms_stimAHA3_S2_295_total ^
                        G:/Paper4/Simulations/invivo/mi/sample5/S2_295/results_mi_CL600_1800ms_stimAHA7_S2_295_total ^
                        G:/Paper4/Simulations/invivo/mi/sample5/S2_295/results_mi_CL600_1800ms_stimAHA12_S2_295_total ^
                        G:/Paper4/Simulations/invivo/mi/sample5/S2_295/results_mi_CL600_1800ms_stimAHA14_S2_295_total ^
                        G:/Paper4/Simulations/invivo/mi/sample5/S2_295/results_mi_CL600_1800ms_stimAHA17_S2_295_total ^
--paraviewScriptPath    G:/Paper4/Simulations/invivo/mi/sample5/S2_295/make_cs_tissue_video_2305ms.py


@REM SAMPLE 6_x -----------------------------------------------------------------
echo "Sample6_x ------------------------------------------"
python D:/Code/simOmPP/makeVideosWithParaview.py ^
--resultsFolderPath     G:/Paper4/Simulations/invivo/mi/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA1_S2_295 ^
                        G:/Paper4/Simulations/invivo/mi/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA3_S2_295 ^
                        G:/Paper4/Simulations/invivo/mi/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295 ^
                        G:/Paper4/Simulations/invivo/mi/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA14_S2_295 ^
                        G:/Paper4/Simulations/invivo/mi/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA17_S2_295 ^
--paraviewScriptPath    G:/Paper4/Simulations/invivo/mi/sample6_x/S2_295/make_cs_tissue_video_1305ms.py

@REM SAMPLE 7 -----------------------------------------------------------------
echo "Sample7 ------------------------------------------"
python D:/Code/simOmPP/makeVideosWithParaview.py ^
--resultsFolderPath     G:/Paper4/Simulations/invivo/mi/sample7/S2_295/results_mi_CL600_1800ms_stimAHA1_S2_295_total ^
                        G:/Paper4/Simulations/invivo/mi/sample7/S2_295/results_mi_CL600_1800ms_stimAHA3_S2_295_total ^
                        G:/Paper4/Simulations/invivo/mi/sample7/S2_295/results_mi_CL600_1800ms_stimAHA14_S2_295_total ^
                        G:/Paper4/Simulations/invivo/mi/sample7/S2_295/results_mi_CL600_1800ms_stimAHA17_S2_295_total ^
--paraviewScriptPath    G:/Paper4/Simulations/invivo/mi/sample7/S2_295/make_cs_tissue_video_2305ms.py


@REM SAMPLE 8 -----------------------------------------------------------------
echo "Sample8 ------------------------------------------"
python D:/Code/simOmPP/makeVideosWithParaview.py ^
--resultsFolderPath     G:/Paper4/Simulations/invivo/mi/sample8/S2_295/results_mi_CL600_1800ms_stimAHA4_S2_295 ^
                        G:/Paper4/Simulations/invivo/mi/sample8/S2_295/results_mi_CL600_1800ms_stimAHA5_S2_295 ^
                        G:/Paper4/Simulations/invivo/mi/sample8/S2_295/results_mi_CL600_1800ms_stimAHA7_S2_295 ^
--paraviewScriptPath    G:/Paper4/Simulations/invivo/mi/sample8/S2_295/make_cs_tissue_video_antpos_1305ms.py

python D:/Code/simOmPP/makeVideosWithParaview.py ^
--resultsFolderPath     G:/Paper4/Simulations/invivo/mi/sample8/S2_295/results_mi_CL600_1800ms_stimAHA18_S2_295_total ^
--paraviewScriptPath    G:/Paper4/Simulations/invivo/mi/sample8/S2_295/make_cs_tissue_video_antpos_2305ms.py


@REM SAMPLE 9 -----------------------------------------------------------------
echo "Sample9 ------------------------------------------"
python D:/Code/simOmPP/makeVideosWithParaview.py ^
--resultsFolderPath     G:/Paper4/Simulations/invivo/mi/sample9/S2_295/results_mi_CL600_1800ms_stimAHA5_S2_295 ^
--paraviewScriptPath    G:/Paper4/Simulations/invivo/mi/sample9/S2_295/make_cs_tissue_video_antpos_1305ms.py


@REM SAMPLE 10 -----------------------------------------------------------------
echo "Sample10 ------------------------------------------"
python D:/Code/simOmPP/makeVideosWithParaview.py ^
--resultsFolderPath     G:/Paper4/Simulations/invivo/mi/sample10/S2_295/results_mi_CL600_1800ms_stimAHA3_S2_295 ^
                        G:/Paper4/Simulations/invivo/mi/sample10/S2_295/results_mi_CL600_1800ms_stimAHA16_S2_295 ^
--paraviewScriptPath    G:/Paper4/Simulations/invivo/mi/sample10/S2_295/make_cs_tissue_video_antpos_1305ms.py

@REM @REM SAMPLE 11 -----------------------------------------------------------------
@REM echo "Sample11 ------------------------------------------"
@REM python D:/Code/simOmPP/makeVideosWithParaview.py ^
@REM --resultsFolderPath     G:/Paper4/Simulations/invivo/mi/sample11/S2_295/results_mi_CL600_1800ms_stimAHA5_S2_295_total ^
@REM                         G:/Paper4/Simulations/invivo/mi/sample11/S2_295/results_mi_CL600_1800ms_stimAHA7_S2_295_total ^
@REM                         G:/Paper4/Simulations/invivo/mi/sample11/S2_295/results_mi_CL600_1800ms_stimAHA8_S2_295_total ^
@REM                         G:/Paper4/Simulations/invivo/mi/sample11/S2_295/results_mi_CL600_1800ms_stimAHA18_S2_295_total ^
@REM --paraviewScriptPath    G:/Paper4/Simulations/invivo/mi/sample11/S2_295/make_cs_tissue_video_antpos.py



@REM SAMPLE 12 -----------------------------------------------------------------
echo "Sample12 ------------------------------------------"
python D:/Code/simOmPP/makeVideosWithParaview.py ^
--resultsFolderPath     G:/Paper4/Simulations/invivo/mi/sample12/S2_295/results_mi_CL600_1800ms_stimAHA5_S2_295 ^
                        G:/Paper4/Simulations/invivo/mi/sample12/S2_295/results_mi_CL600_1800ms_stimAHA6_S2_295 ^
                        G:/Paper4/Simulations/invivo/mi/sample12/S2_295/results_mi_CL600_1800ms_stimAHA8_S2_295 ^
                        G:/Paper4/Simulations/invivo/mi/sample12/S2_295/results_mi_CL600_1800ms_stimAHA12_S2_295 ^
--paraviewScriptPath    G:/Paper4/Simulations/invivo/mi/sample12/S2_295/make_cs_tissue_video_antpos_1305ms.py