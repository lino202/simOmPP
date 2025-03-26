@ECHO OFF
call conda activate simOmPP

@REM @REM SAMPLE 4 -----------------------------------------------------------------
@REM echo "Sample4 ------------------------------------------"
@REM python D:/Code/simOmPP/makeVideosWithParaview.py ^
@REM --resultsFolderPath     D:/Paper4/Simulations/invivo/mi/sample4/S2_265/results_mi_CL600_1800ms_stimAHA17_S2_265_total ^
@REM --paraviewScriptPath    D:/Paper4/Simulations/invivo/mi/sample4/S2_265/make_cs_tissue_video.py

@REM SAMPLE 5 -----------------------------------------------------------------
echo "Sample5 ------------------------------------------"
python D:/Code/simOmPP/makeVideosWithParaview.py ^
--resultsFolderPath     D:/Paper4/Simulations/invivo/mi/sample5/S2_265/results_mi_CL600_1800ms_stimAHA3_S2_265_total ^
                        D:/Paper4/Simulations/invivo/mi/sample5/S2_265/results_mi_CL600_1800ms_stimAHA14_S2_265_total ^
--paraviewScriptPath    D:/Paper4/Simulations/invivo/mi/sample5/S2_265/make_cs_tissue_video.py


@REM SAMPLE 5 -----------------------------------------------------------------
echo "Sample5 ------------------------------------------"
python D:/Code/simOmPP/makeVideosWithParaview.py ^
--resultsFolderPath     D:/Paper4/Simulations/invivo/mi/sample5/S2_280/results_mi_CL600_1800ms_stimAHA1_S2_280_total ^
                        D:/Paper4/Simulations/invivo/mi/sample5/S2_280/results_mi_CL600_1800ms_stimAHA3_S2_280_total ^
                        D:/Paper4/Simulations/invivo/mi/sample5/S2_280/results_mi_CL600_1800ms_stimAHA14_S2_280_total ^
--paraviewScriptPath    D:/Paper4/Simulations/invivo/mi/sample5/S2_280/make_cs_tissue_video.py


@REM @REM SAMPLE 6_x -----------------------------------------------------------------
@REM echo "Sample6_x ------------------------------------------"
@REM python D:/Code/simOmPP/makeVideosWithParaview.py ^
@REM --resultsFolderPath     D:/Paper4/Simulations/invivo/mi/sample6_x/S2_265/results_mi_CL600_1800ms_stimAHA17_S2_265_total ^
@REM --paraviewScriptPath    D:/Paper4/Simulations/invivo/mi/sample6_x/S2_265/make_cs_tissue_video.py

@REM SAMPLE 7 -----------------------------------------------------------------
echo "Sample7 ------------------------------------------"
python D:/Code/simOmPP/makeVideosWithParaview.py ^
--resultsFolderPath     D:/Paper4/Simulations/invivo/mi/sample7/S2_280/results_mi_CL600_1800ms_stimAHA1_S2_280_total ^
                        D:/Paper4/Simulations/invivo/mi/sample7/S2_280/results_mi_CL600_1800ms_stimAHA14_S2_280_total ^
--paraviewScriptPath    D:/Paper4/Simulations/invivo/mi/sample7/S2_280/make_cs_tissue_video.py


@REM @REM SAMPLE 8 -----------------------------------------------------------------
@REM echo "Sample8 ------------------------------------------"
@REM python D:/Code/simOmPP/makeVideosWithParaview.py ^
@REM --resultsFolderPath     D:/Paper4/Simulations/invivo/mi/sample8/S2_265/results_mi_CL600_1800ms_stimAHA4_S2_265_total ^
@REM --paraviewScriptPath    D:/Paper4/Simulations/invivo/mi/sample8/S2_265/results_mi_CL600_1800ms_stimAHA4_S2_265_total/make_cs_tissue_video_antpos.py


@REM @REM SAMPLE 12 -----------------------------------------------------------------
@REM echo "Sample12 ------------------------------------------"
@REM python D:/Code/simOmPP/makeVideosWithParaview.py ^
@REM --resultsFolderPath     D:/Paper4/Simulations/invivo/mi/sample12/S2_265/results_mi_CL600_1800ms_stimAHA6_S2_265_total ^
@REM --paraviewScriptPath    D:/Paper4/Simulations/invivo/mi/sample12/S2_265/make_cs_tissue_video_antpos.py