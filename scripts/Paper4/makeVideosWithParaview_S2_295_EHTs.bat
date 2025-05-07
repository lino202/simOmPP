@ECHO OFF
call conda activate simOmPP

@REM SAMPLE 4 -----------------------------------------------------------------
echo "Sample4 ------------------------------------------"
python D:/Code/simOmPP/makeVideosWithParaview.py ^
--resultsFolderPath     D:/Paper4/Simulations/invivo/mi_EHT1/sample4/S2_295/results_mi_CL600_1800ms_stimAHA2_S2_295 ^
                        D:/Paper4/Simulations/invivo/mi_EHT1/sample4/S2_295/results_mi_CL600_1800ms_stimAHA14_S2_295 ^
--paraviewScriptPath    D:/Paper4/Simulations/invivo/mi_EHT1/sample4/S2_295/make_cs_tissue_video_1305ms.py

python D:/Code/simOmPP/makeVideosWithParaview.py ^
--resultsFolderPath     D:/Paper4/Simulations/invivo/mi_EHT2/sample4/S2_295/results_mi_CL600_1800ms_stimAHA2_S2_295 ^
                        D:/Paper4/Simulations/invivo/mi_EHT2/sample4/S2_295/results_mi_CL600_1800ms_stimAHA14_S2_295 ^
--paraviewScriptPath    D:/Paper4/Simulations/invivo/mi_EHT2/sample4/S2_295/make_cs_tissue_video_1305ms.py


@REM SAMPLE 5 -----------------------------------------------------------------
echo "Sample5 ------------------------------------------"
python D:/Code/simOmPP/makeVideosWithParaview.py ^
--resultsFolderPath     D:/Paper4/Simulations/invivo/mi_EHT1/sample5/S2_295/results_mi_CL600_1800ms_stimAHA14_S2_295 ^
                        D:/Paper4/Simulations/invivo/mi_EHT1/sample5/S2_295/results_mi_CL600_1800ms_stimAHA17_S2_295 ^
--paraviewScriptPath    D:/Paper4/Simulations/invivo/mi_EHT1/sample5/S2_295/make_cs_tissue_video_1305ms.py

@REM python D:/Code/simOmPP/makeVideosWithParaview.py ^
@REM --resultsFolderPath     D:/Paper4/Simulations/invivo/mi_EHT1/sample5/S2_295/results_mi_CL600_1800ms_stimAHA3_S2_295_total ^
@REM --paraviewScriptPath    D:/Paper4/Simulations/invivo/mi_EHT1/sample5/S2_295/make_cs_tissue_video_2305ms.py

@REM python D:/Code/simOmPP/makeVideosWithParaview.py ^
@REM --resultsFolderPath     D:/Paper4/Simulations/invivo/mi_EHT2/sample5/S2_295/results_mi_CL600_1800ms_stimAHA17_S2_295 ^
@REM                         D:/Paper4/Simulations/invivo/mi_EHT2/sample5/S2_295/results_mi_CL600_1800ms_stimAHA12_S2_295 ^
@REM --paraviewScriptPath    D:/Paper4/Simulations/invivo/mi_EHT2/sample5/S2_295/make_cs_tissue_video_1305ms.py

@REM python D:/Code/simOmPP/makeVideosWithParaview.py ^
@REM --resultsFolderPath     D:/Paper4/Simulations/invivo/mi_EHT2/sample5/S2_295/results_mi_CL600_1800ms_stimAHA14_S2_295_total ^
@REM --paraviewScriptPath    D:/Paper4/Simulations/invivo/mi_EHT2/sample5/S2_295/make_cs_tissue_video_2305ms.py

@REM SAMPLE 6_x -----------------------------------------------------------------
@REM echo "Sample6_X ------------------------------------------"
@REM python D:/Code/simOmPP/makeVideosWithParaview.py ^
@REM --resultsFolderPath     D:/Paper4/Simulations/invivo/mi_EHT1/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA3_S2_295_total ^
@REM                         D:/Paper4/Simulations/invivo/mi_EHT1/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total ^
@REM                         D:/Paper4/Simulations/invivo/mi_EHT1/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA14_S2_295_total ^
@REM                         D:/Paper4/Simulations/invivo/mi_EHT1/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA17_S2_295_total ^
@REM --paraviewScriptPath    D:/Paper4/Simulations/invivo/mi_EHT1/sample6_x/S2_295/make_cs_tissue_video_2305ms.py

@REM python D:/Code/simOmPP/makeVideosWithParaview.py ^
@REM --resultsFolderPath     D:/Paper4/Simulations/invivo/mi_EHT2/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA3_S2_295_total ^
@REM                         D:/Paper4/Simulations/invivo/mi_EHT2/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA13_S2_295_total ^
@REM                         D:/Paper4/Simulations/invivo/mi_EHT2/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA14_S2_295_total ^
@REM                         D:/Paper4/Simulations/invivo/mi_EHT2/sample6_x/S2_295/results_mi_CL600_1800ms_stimAHA17_S2_295_total ^
@REM --paraviewScriptPath    D:/Paper4/Simulations/invivo/mi_EHT2/sample6_x/S2_295/make_cs_tissue_video_2305ms.py

@REM SAMPLE 7 -----------------------------------------------------------------
@REM echo "Sample7 ------------------------------------------"
@REM python D:/Code/simOmPP/makeVideosWithParaview.py ^
@REM --resultsFolderPath     D:/Paper4/Simulations/invivo/mi_EHT1/sample7/S2_295/results_mi_CL600_1800ms_stimAHA1_S2_295_total ^
@REM                         D:/Paper4/Simulations/invivo/mi_EHT1/sample7/S2_295/results_mi_CL600_1800ms_stimAHA3_S2_295_total ^
@REM                         D:/Paper4/Simulations/invivo/mi_EHT1/sample7/S2_295/results_mi_CL600_1800ms_stimAHA14_S2_295_total ^
@REM                         D:/Paper4/Simulations/invivo/mi_EHT1/sample7/S2_295/results_mi_CL600_1800ms_stimAHA17_S2_295_total ^
@REM --paraviewScriptPath    D:/Paper4/Simulations/invivo/mi_EHT1/sample7/S2_295/make_cs_tissue_video_2305ms.py

@REM python D:/Code/simOmPP/makeVideosWithParaview.py ^
@REM --resultsFolderPath     D:/Paper4/Simulations/invivo/mi_EHT2/sample7/S2_295/results_mi_CL600_1800ms_stimAHA1_S2_295_total ^
@REM                         D:/Paper4/Simulations/invivo/mi_EHT2/sample7/S2_295/results_mi_CL600_1800ms_stimAHA3_S2_295_total ^
@REM                         D:/Paper4/Simulations/invivo/mi_EHT2/sample7/S2_295/results_mi_CL600_1800ms_stimAHA14_S2_295_total ^
@REM                         D:/Paper4/Simulations/invivo/mi_EHT2/sample7/S2_295/results_mi_CL600_1800ms_stimAHA17_S2_295_total ^
@REM --paraviewScriptPath    D:/Paper4/Simulations/invivo/mi_EHT2/sample7/S2_295/make_cs_tissue_video_2305ms.py


@REM @REM SAMPLE 8 -----------------------------------------------------------------
@REM echo "Sample8 ------------------------------------------"
@REM python D:/Code/simOmPP/makeVideosWithParaview.py ^
@REM --resultsFolderPath     D:/Paper4/Simulations/invivo/mi_EHT1/sample8/S2_295/results_mi_CL600_1800ms_stimAHA4_S2_295_total ^
@REM                         D:/Paper4/Simulations/invivo/mi_EHT1/sample8/S2_295/results_mi_CL600_1800ms_stimAHA7_S2_295_total ^
@REM                         D:/Paper4/Simulations/invivo/mi_EHT1/sample8/S2_295/results_mi_CL600_1800ms_stimAHA18_S2_295_total ^
@REM --paraviewScriptPath    D:/Paper4/Simulations/invivo/mi_EHT1/sample8/S2_295/make_cs_tissue_video_antpos_2305ms.py

@REM python D:/Code/simOmPP/makeVideosWithParaview.py ^
@REM --resultsFolderPath     D:/Paper4/Simulations/invivo/mi_EHT1/sample8/S2_295/results_mi_CL600_1800ms_stimAHA5_S2_295 ^
@REM --paraviewScriptPath    D:/Paper4/Simulations/invivo/mi_EHT1/sample8/S2_295/make_cs_tissue_video_antpos_1305ms.py

@REM python D:/Code/simOmPP/makeVideosWithParaview.py ^
@REM --resultsFolderPath     D:/Paper4/Simulations/invivo/mi_EHT2/sample8/S2_295/results_mi_CL600_1800ms_stimAHA4_S2_295_total ^
@REM                         D:/Paper4/Simulations/invivo/mi_EHT2/sample8/S2_295/results_mi_CL600_1800ms_stimAHA5_S2_295_total ^
@REM                         D:/Paper4/Simulations/invivo/mi_EHT2/sample8/S2_295/results_mi_CL600_1800ms_stimAHA7_S2_295_total ^
@REM                         D:/Paper4/Simulations/invivo/mi_EHT2/sample8/S2_295/results_mi_CL600_1800ms_stimAHA18_S2_295_total ^
@REM --paraviewScriptPath    D:/Paper4/Simulations/invivo/mi_EHT2/sample8/S2_295/make_cs_tissue_video_antpos_2305ms.py

@REM @REM SAMPLE 9 -----------------------------------------------------------------
@REM echo "Sample9 ------------------------------------------"
@REM python D:/Code/simOmPP/makeVideosWithParaview.py ^
@REM --resultsFolderPath     D:/Paper4/Simulations/invivo/mi_EHT1/sample9/S2_295/results_mi_CL600_1800ms_stimAHA5_S2_295 ^
@REM --paraviewScriptPath    D:/Paper4/Simulations/invivo/mi_EHT1/sample9/S2_295/make_cs_tissue_video_antpos_1305ms.py

@REM python D:/Code/simOmPP/makeVideosWithParaview.py ^
@REM --resultsFolderPath     D:/Paper4/Simulations/invivo/mi_EHT1/sample9/S2_295/results_mi_CL600_1800ms_stimAHA8_S2_295_total ^
@REM                         D:/Paper4/Simulations/invivo/mi_EHT1/sample9/S2_295/results_mi_CL600_1800ms_stimAHA11_S2_295_total ^
@REM                         D:/Paper4/Simulations/invivo/mi_EHT1/sample9/S2_295/results_mi_CL600_1800ms_stimAHA14_S2_295_total ^
@REM --paraviewScriptPath    D:/Paper4/Simulations/invivo/mi_EHT1/sample9/S2_295/make_cs_tissue_video_antpos_2305ms.py

@REM python D:/Code/simOmPP/makeVideosWithParaview.py ^
@REM --resultsFolderPath     D:/Paper4/Simulations/invivo/mi_EHT2/sample9/S2_295/results_mi_CL600_1800ms_stimAHA5_S2_295 ^
@REM --paraviewScriptPath    D:/Paper4/Simulations/invivo/mi_EHT2/sample9/S2_295/make_cs_tissue_video_antpos_1305ms.py

@REM python D:/Code/simOmPP/makeVideosWithParaview.py ^
@REM --resultsFolderPath     D:/Paper4/Simulations/invivo/mi_EHT2/sample9/S2_295/results_mi_CL600_1800ms_stimAHA8_S2_295_total ^
@REM                         D:/Paper4/Simulations/invivo/mi_EHT2/sample9/S2_295/results_mi_CL600_1800ms_stimAHA11_S2_295_total ^
@REM                         D:/Paper4/Simulations/invivo/mi_EHT2/sample9/S2_295/results_mi_CL600_1800ms_stimAHA14_S2_295_total ^
@REM --paraviewScriptPath    D:/Paper4/Simulations/invivo/mi_EHT2/sample9/S2_295/make_cs_tissue_video_antpos_2305ms.py


@REM SAMPLE 10 -----------------------------------------------------------------
echo "Sample10 ------------------------------------------"
python D:/Code/simOmPP/makeVideosWithParaview.py ^
--resultsFolderPath     D:/Paper4/Simulations/invivo/mi_EHT1/sample10/S2_295/results_mi_CL600_1800ms_stimAHA9_S2_295_total ^
                        D:/Paper4/Simulations/invivo/mi_EHT1/sample10/S2_295/results_mi_CL600_1800ms_stimAHA18_S2_295_total ^
--paraviewScriptPath    D:/Paper4/Simulations/invivo/mi_EHT1/sample10/S2_295/make_cs_tissue_video_antpos_2305ms.py

python D:/Code/simOmPP/makeVideosWithParaview.py ^
--resultsFolderPath     D:/Paper4/Simulations/invivo/mi_EHT1/sample10/S2_295/results_mi_CL600_1800ms_stimAHA16_S2_295 ^
                        D:/Paper4/Simulations/invivo/mi_EHT1/sample10/S2_295/results_mi_CL600_1800ms_stimAHA3_S2_295 ^
--paraviewScriptPath    D:/Paper4/Simulations/invivo/mi_EHT1/sample10/S2_295/make_cs_tissue_video_antpos_1305ms.py

python D:/Code/simOmPP/makeVideosWithParaview.py ^
--resultsFolderPath     D:/Paper4/Simulations/invivo/mi_EHT2/sample10/S2_295/results_mi_CL600_1800ms_stimAHA9_S2_295_total ^
                        D:/Paper4/Simulations/invivo/mi_EHT2/sample10/S2_295/results_mi_CL600_1800ms_stimAHA18_S2_295_total ^
--paraviewScriptPath    D:/Paper4/Simulations/invivo/mi_EHT2/sample10/S2_295/make_cs_tissue_video_antpos_2305ms.py

python D:/Code/simOmPP/makeVideosWithParaview.py ^
--resultsFolderPath     D:/Paper4/Simulations/invivo/mi_EHT2/sample10/S2_295/results_mi_CL600_1800ms_stimAHA16_S2_295 ^
                        D:/Paper4/Simulations/invivo/mi_EHT2/sample10/S2_295/results_mi_CL600_1800ms_stimAHA3_S2_295 ^
--paraviewScriptPath    D:/Paper4/Simulations/invivo/mi_EHT2/sample10/S2_295/make_cs_tissue_video_antpos_1305ms.py


@REM @REM SAMPLE 11 -----------------------------------------------------------------
@REM echo "Sample11 ------------------------------------------"
@REM python D:/Code/simOmPP/makeVideosWithParaview.py ^
@REM --resultsFolderPath     D:/Paper4/Simulations/invivo/mi_EHT1/sample11/S2_295/results_mi_CL600_1800ms_stimAHA5_S2_295_total ^
@REM                         D:/Paper4/Simulations/invivo/mi_EHT1/sample11/S2_295/results_mi_CL600_1800ms_stimAHA7_S2_295_total ^
@REM                         D:/Paper4/Simulations/invivo/mi_EHT1/sample11/S2_295/results_mi_CL600_1800ms_stimAHA8_S2_295_total ^
@REM                         D:/Paper4/Simulations/invivo/mi_EHT1/sample11/S2_295/results_mi_CL600_1800ms_stimAHA18_S2_295_total ^
@REM --paraviewScriptPath    D:/Paper4/Simulations/invivo/mi_EHT1/sample11/S2_295/make_cs_tissue_video_antpos_2305ms.py

@REM python D:/Code/simOmPP/makeVideosWithParaview.py ^
@REM --resultsFolderPath     D:/Paper4/Simulations/invivo/mi_EHT2/sample11/S2_295/results_mi_CL600_1800ms_stimAHA5_S2_295_total ^
@REM                         D:/Paper4/Simulations/invivo/mi_EHT2/sample11/S2_295/results_mi_CL600_1800ms_stimAHA7_S2_295_total ^
@REM                         D:/Paper4/Simulations/invivo/mi_EHT2/sample11/S2_295/results_mi_CL600_1800ms_stimAHA8_S2_295_total ^
@REM                         D:/Paper4/Simulations/invivo/mi_EHT2/sample11/S2_295/results_mi_CL600_1800ms_stimAHA18_S2_295_total ^
@REM --paraviewScriptPath    D:/Paper4/Simulations/invivo/mi_EHT2/sample11/S2_295/make_cs_tissue_video_antpos_2305ms.py

@REM SAMPLE 12 -----------------------------------------------------------------
echo "Sample12 ------------------------------------------"
python D:/Code/simOmPP/makeVideosWithParaview.py ^
--resultsFolderPath     D:/Paper4/Simulations/invivo/mi_EHT1/sample12/S2_295/results_mi_CL600_1800ms_stimAHA5_S2_295 ^
                        D:/Paper4/Simulations/invivo/mi_EHT1/sample12/S2_295/results_mi_CL600_1800ms_stimAHA6_S2_295 ^
                        D:/Paper4/Simulations/invivo/mi_EHT1/sample12/S2_295/results_mi_CL600_1800ms_stimAHA12_S2_295 ^
--paraviewScriptPath    D:/Paper4/Simulations/invivo/mi_EHT1/sample12/S2_295/make_cs_tissue_video_antpos_1305ms.py

@REM python D:/Code/simOmPP/makeVideosWithParaview.py ^
@REM --resultsFolderPath     D:/Paper4/Simulations/invivo/mi_EHT1/sample12/S2_295/results_mi_CL600_1800ms_stimAHA18_S2_295_total ^
@REM --paraviewScriptPath    D:/Paper4/Simulations/invivo/mi_EHT1/sample12/S2_295/make_cs_tissue_video_antpos_2305ms.py

python D:/Code/simOmPP/makeVideosWithParaview.py ^
--resultsFolderPath     D:/Paper4/Simulations/invivo/mi_EHT2/sample12/S2_295/results_mi_CL600_1800ms_stimAHA5_S2_295 ^
                        D:/Paper4/Simulations/invivo/mi_EHT2/sample12/S2_295/results_mi_CL600_1800ms_stimAHA6_S2_295 ^
                        D:/Paper4/Simulations/invivo/mi_EHT2/sample12/S2_295/results_mi_CL600_1800ms_stimAHA12_S2_295 ^
--paraviewScriptPath    D:/Paper4/Simulations/invivo/mi_EHT2/sample12/S2_295/make_cs_tissue_video_antpos_1305ms.py

@REM python D:/Code/simOmPP/makeVideosWithParaview.py ^
@REM --resultsFolderPath     D:/Paper4/Simulations/invivo/mi_EHT2/sample12/S2_295/results_mi_CL600_1800ms_stimAHA8_S2_295_total ^
@REM                         D:/Paper4/Simulations/invivo/mi_EHT2/sample12/S2_295/results_mi_CL600_1800ms_stimAHA18_S2_295_total ^
@REM --paraviewScriptPath    D:/Paper4/Simulations/invivo/mi_EHT2/sample12/S2_295/make_cs_tissue_video_antpos_2305ms.py
