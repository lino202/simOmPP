@ECHO OFF
call conda activate simOmPP

@REM @REM SAMPLE 4 -----------------------------------------------------------------
@REM echo "Sample4 ------------------------------------------"
@REM python D:/Code/simOmPP/makeVideosWithParaview.py ^
@REM --resultsFolderPath     D:/Paper4/Simulations/invivo/mi/sample4/S2_280/results_mi_CL600_1800ms_stimAHA1_S2_280 ^
@REM                         D:/Paper4/Simulations/invivo/mi/sample4/S2_280/results_mi_CL600_1800ms_stimAHA17_S2_280 ^
@REM --paraviewScriptPath    D:/Paper4/Simulations/invivo/mi/sample4/S2_280/make_cs_tissue_video.py


@REM @REM SAMPLE 6_x -----------------------------------------------------------------
@REM echo "Sample6_x ------------------------------------------"
@REM python D:/Code/simOmPP/makeVideosWithParaview.py ^
@REM --resultsFolderPath     D:/Paper4/Simulations/invivo/mi/sample6_x/S2_280/results_mi_CL600_1800ms_stimAHA3_S2_280 ^
@REM                         D:/Paper4/Simulations/invivo/mi/sample6_x/S2_280/results_mi_CL600_1800ms_stimAHA17_S2_280 ^
@REM --paraviewScriptPath    D:/Paper4/Simulations/invivo/mi/sample6_x/S2_280/make_cs_tissue_video.py


@REM @REM SAMPLE 8 -----------------------------------------------------------------
@REM echo "Sample8 ------------------------------------------"
@REM python D:/Code/simOmPP/makeVideosWithParaview.py ^
@REM --resultsFolderPath     D:/Paper4/Simulations/invivo/mi/sample8/S2_280/results_mi_CL600_1800ms_stimAHA4_S2_280 ^
@REM                         D:/Paper4/Simulations/invivo/mi/sample8/S2_280/results_mi_CL600_1800ms_stimAHA5_S2_280 ^
@REM                         D:/Paper4/Simulations/invivo/mi/sample8/S2_280/results_mi_CL600_1800ms_stimAHA7_S2_280 ^
@REM --paraviewScriptPath    D:/Paper4/Simulations/invivo/mi/sample8/S2_280/make_cs_tissue_video_antpos.py


@REM SAMPLE 10 -----------------------------------------------------------------
echo "Sample10 ------------------------------------------"
python D:/Code/simOmPP/makeVideosWithParaview.py ^
--resultsFolderPath     D:/Paper4/Simulations/invivo/mi/sample10/S2_280/results_mi_CL600_1800ms_stimAHA3_S2_280_total ^
                        D:/Paper4/Simulations/invivo/mi/sample10/S2_280/results_mi_CL600_1800ms_stimAHA9_S2_280_total ^
                        D:/Paper4/Simulations/invivo/mi/sample10/S2_280/results_mi_CL600_1800ms_stimAHA18_S2_280_total ^
--paraviewScriptPath    D:/Paper4/Simulations/invivo/mi/sample10/S2_280/make_cs_tissue_video.py

@REM SAMPLE 11 -----------------------------------------------------------------
@REM echo "Sample11 ------------------------------------------"
@REM python D:/Code/simOmPP/makeVideosWithParaview.py ^
@REM --resultsFolderPath     D:/Paper4/Simulations/invivo/mi/sample11/S2_280/results_mi_CL600_1800ms_stimAHA7_S2_280_total ^
@REM                         D:/Paper4/Simulations/invivo/mi/sample11/S2_280/results_mi_CL600_1800ms_stimAHA8_S2_280_total ^
@REM --paraviewScriptPath    D:/Paper4/Simulations/invivo/mi/sample11/S2_280/make_cs_tissue_video.py



@REM @REM SAMPLE 12 -----------------------------------------------------------------
@REM echo "Sample12 ------------------------------------------"
@REM python D:/Code/simOmPP/makeVideosWithParaview.py ^
@REM --resultsFolderPath     D:/Paper4/Simulations/invivo/mi/sample12/S2_280/results_mi_CL600_1800ms_stimAHA5_S2_280 ^
@REM                         D:/Paper4/Simulations/invivo/mi/sample12/S2_280/results_mi_CL600_1800ms_stimAHA12_S2_280 ^
@REM --paraviewScriptPath    D:/Paper4/Simulations/invivo/mi/sample12/S2_280/make_cs_tissue_video_antpos.py