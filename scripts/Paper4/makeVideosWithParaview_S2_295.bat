@ECHO OFF
call conda activate simOmPP



@REM @REM SAMPLE 8 -----------------------------------------------------------------
@REM echo "Sample8 ------------------------------------------"
@REM python D:/Code/simOmPP/makeVideosWithParaview.py ^
@REM --resultsFolderPath     D:/Paper4/Simulations/invivo/mi/sample8/S2_295/results_mi_CL600_1800ms_stimAHA18_S2_295_total ^
@REM --paraviewScriptPath    D:/Paper4/Simulations/invivo/mi/sample8/S2_295/make_cs_tissue_video_antpos.py


@REM @REM SAMPLE 9 -----------------------------------------------------------------
@REM echo "Sample9 ------------------------------------------"
@REM python D:/Code/simOmPP/makeVideosWithParaview.py ^
@REM --resultsFolderPath     D:/Paper4/Simulations/invivo/mi/sample9/S2_295/results_mi_CL600_1800ms_stimAHA11_S2_295_total ^
@REM                         D:/Paper4/Simulations/invivo/mi/sample9/S2_295/results_mi_CL600_1800ms_stimAHA8_S2_295_total ^
@REM                         D:/Paper4/Simulations/invivo/mi/sample9/S2_295/results_mi_CL600_1800ms_stimAHA14_S2_295_total ^
@REM --paraviewScriptPath    D:/Paper4/Simulations/invivo/mi/sample9/S2_295/make_cs_tissue_video_antpos.py


@REM SAMPLE 10 -----------------------------------------------------------------
echo "Sample10 ------------------------------------------"
python D:/Code/simOmPP/makeVideosWithParaview.py ^
--resultsFolderPath     D:/Paper4/Simulations/invivo/mi/sample10/S2_295/results_mi_CL600_1800ms_stimAHA9_S2_295_total ^
                        D:/Paper4/Simulations/invivo/mi/sample10/S2_295/results_mi_CL600_1800ms_stimAHA18_S2_295_total ^
--paraviewScriptPath    D:/Paper4/Simulations/invivo/mi/sample10/S2_295/make_cs_tissue_video_antpos.py

@REM @REM SAMPLE 11 -----------------------------------------------------------------
@REM echo "Sample11 ------------------------------------------"
@REM python D:/Code/simOmPP/makeVideosWithParaview.py ^
@REM --resultsFolderPath     D:/Paper4/Simulations/invivo/mi/sample11/S2_295/results_mi_CL600_1800ms_stimAHA5_S2_295_total ^
@REM                         D:/Paper4/Simulations/invivo/mi/sample11/S2_295/results_mi_CL600_1800ms_stimAHA7_S2_295_total ^
@REM                         D:/Paper4/Simulations/invivo/mi/sample11/S2_295/results_mi_CL600_1800ms_stimAHA8_S2_295_total ^
@REM                         D:/Paper4/Simulations/invivo/mi/sample11/S2_295/results_mi_CL600_1800ms_stimAHA18_S2_295_total ^
@REM --paraviewScriptPath    D:/Paper4/Simulations/invivo/mi/sample11/S2_295/make_cs_tissue_video_antpos.py



@REM @REM SAMPLE 12 -----------------------------------------------------------------
@REM echo "Sample12 ------------------------------------------"
@REM python D:/Code/simOmPP/makeVideosWithParaview.py ^
@REM --resultsFolderPath     D:/Paper4/Simulations/invivo/mi/sample12/S2_295/results_mi_CL600_1800ms_stimAHA7_S2_295_total ^
@REM                         D:/Paper4/Simulations/invivo/mi/sample12/S2_295/results_mi_CL600_1800ms_stimAHA18_S2_295_total ^
@REM --paraviewScriptPath    D:/Paper4/Simulations/invivo/mi/sample12/S2_295/make_cs_tissue_video_antpos.py


@REM pause