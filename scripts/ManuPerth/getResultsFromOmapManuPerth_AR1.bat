@REM @REM @ECHO OFF
@REM call conda activate simOmPP

@REM @REM S is stimulated and B is basal L is longitudinal and T is transversal C is central

@REM @REM @REM AR1 ----------------------------------------------

python D:/Code/simOmPP/getResultsFromOmapFiltered.py ^
--folderPath                D:/Data/OM_BioVAD/Perth_24062024/total/AR1 ^
--videoName                 3 ^
--fileName                  FileTag003_video_filtered ^
--matVarName                wholav_images ^
--getSubRegions             ^
--subregionNames            L M S ^
--roisName                  roi_3 ^
--exposure                  10 ^
--reverse                   ^
--startTime                 880 ^
--endTime                   8030 ^
--before                    600 ^
--after                     1050 ^
--nBeats                    4 ^
--cleanProcess              0 ^
--blockDown                 0 ^
--blockUp                   0 ^
--shouldNotHaveAllPoints    ^
--pixRes                    0.0136 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--apdtype                   90 ^
--stimCL                    1880 ^
--stimType                  Basal ^
--sampleType                Rect ^
--sampleName                AR1

@REM python D:/Code/simOmPP/getResultsFromOmapFiltered.py ^
@REM --folderPath                D:/Data/OM_BioVAD/Perth_24062024/total/AR1 ^
@REM --videoName                 4 ^
@REM --fileName                  FileTag004_video_filtered ^
@REM --matVarName                wholav_images ^
@REM --getSubRegions             ^
@REM --subregionNames            L M S ^
@REM --roisName                  roi_4 ^
@REM --exposure                  10 ^
@REM --reverse                   ^
@REM --startTime                 730 ^
@REM --endTime                   5180 ^
@REM --before                    420 ^
@REM --after                     520 ^
@REM --nBeats                    4 ^
@REM --cleanProcess              0 ^
@REM --blockDown                 0 ^
@REM --blockUp                   0 ^
@REM --shouldNotHaveAllPoints    ^
@REM --pixRes                    0.0136 ^
@REM --maxDist                   3 ^
@REM --maxCV                     300 ^
@REM --cvCalcMethod              vanilla ^
@REM --scaleVectors              1. ^
@REM --apdtype                   90 ^
@REM --stimCL                    1000 ^
@REM --stimType                  Long ^
@REM --sampleType                Rect ^
@REM --sampleName                AR1



@REM python D:/Code/simOmPP/getResultsFromOmapFiltered.py ^
@REM --folderPath                D:/Data/OM_BioVAD/Perth_24062024/total/AR1 ^
@REM --videoName                 8 ^
@REM --fileName                  FileTag008_video_filtered ^
@REM --matVarName                wholav_images ^
@REM --getSubRegions             ^
@REM --subregionNames            L M S ^
@REM --roisName                  roi_8 ^
@REM --exposure                  10 ^
@REM --reverse                   ^
@REM --startTime                 2000 ^
@REM --endTime                   12000 ^
@REM --before                    800 ^
@REM --after                     1100 ^
@REM --nBeats                    5 ^
@REM --cleanProcess              0 ^
@REM --blockDown                 0 ^
@REM --blockUp                   0 ^
@REM --shouldNotHaveAllPoints    ^
@REM --pixRes                    0.0136 ^
@REM --maxDist                   3 ^
@REM --maxCV                     300 ^
@REM --cvCalcMethod              vanilla ^
@REM --scaleVectors              1. ^
@REM --apdtype                   90 ^
@REM --stimCL                    2000 ^
@REM --stimType                  Long ^
@REM --sampleType                Rect ^
@REM --sampleName                AR1



@REM python D:/Code/simOmPP/getResultsFromOmapFiltered.py ^
@REM --folderPath                D:/Data/OM_BioVAD/Perth_24062024/total/AR1 ^
@REM --videoName                 12 ^
@REM --fileName                  FileTag012_video_filtered ^
@REM --matVarName                wholav_images ^
@REM --getSubRegions             ^
@REM --subregionNames            L M S ^
@REM --roisName                  roi_12 ^
@REM --exposure                  10 ^
@REM --reverse                   ^
@REM --startTime                 1000 ^
@REM --endTime                   10850 ^
@REM --before                    800 ^
@REM --after                     1100 ^
@REM --nBeats                    5 ^
@REM --cleanProcess              0 ^
@REM --blockDown                 0 ^
@REM --blockUp                   0 ^
@REM --shouldNotHaveAllPoints    ^
@REM --pixRes                    0.0136 ^
@REM --maxDist                   3 ^
@REM --maxCV                     300 ^
@REM --cvCalcMethod              vanilla ^
@REM --scaleVectors              1. ^
@REM --apdtype                   90 ^
@REM --stimCL                    2000 ^
@REM --stimType                  Trans ^
@REM --sampleType                Rect ^
@REM --sampleName                AR1


@REM python D:/Code/simOmPP/getResultsFromOmapFiltered.py ^
@REM --folderPath                D:/Data/OM_BioVAD/Perth_24062024/total/AR1 ^
@REM --videoName                 13 ^
@REM --fileName                  FileTag013_video_filtered ^
@REM --matVarName                wholav_images ^
@REM --getSubRegions             ^
@REM --subregionNames            L M S ^
@REM --roisName                  roi_12 ^
@REM --exposure                  10 ^
@REM --reverse                   ^
@REM --startTime                 0 ^
@REM --endTime                   5500 ^
@REM --before                    550 ^
@REM --after                     550 ^
@REM --nBeats                    5 ^
@REM --cleanProcess              0 ^
@REM --blockDown                 0 ^
@REM --blockUp                   0 ^
@REM --shouldNotHaveAllPoints    ^
@REM --pixRes                    0.0136 ^
@REM --maxDist                   3 ^
@REM --maxCV                     300 ^
@REM --cvCalcMethod              vanilla ^
@REM --scaleVectors              1. ^
@REM --apdtype                   90 ^
@REM --stimCL                    1000 ^
@REM --stimType                  Trans ^
@REM --sampleType                Rect ^
@REM --sampleName                AR1