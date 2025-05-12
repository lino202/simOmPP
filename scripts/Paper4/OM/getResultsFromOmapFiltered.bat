@REM @ECHO OFF
call conda activate simOmPP

@REM Pig 2 in OM, which is pig 8 in papers
python D:/Code/simOmPP/getResultsFromOmapFiltered.py ^
--folderPath                G:/Data/OM_PigHeart/MI/20211111_PigInfarcted2 ^
--videoName                 36 ^
--fileName                  FileTag036_video_filtered ^
--matVarName                wholav_images ^
--roisName                  roi_36 ^
--exposure                  2 ^
--reverse                   ^
--startTime                 2250 ^
--endTime                   3036 ^
--before                    130 ^
--after                     130 ^
--nBeats                    3 ^
--cleanProcess              0  ^
--blockDown                 0  ^
--blockUp                   0 ^
--shouldNotHaveAllPoints    ^
--pixRes                    0.081 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--apdtype                   90 ^
--stimCL                    230 ^
--stimType                  VI ^
--sampleType                AV ^
--sampleName                Pig8


@REM python D:/Code/simOmPP/getResultsFromOmapFiltered.py ^
@REM --folderPath                G:/Data/OM_PigHeart/MI/20211111_PigInfarcted2 ^
@REM --videoName                 37 ^
@REM --fileName                  FileTag037_video_filtered ^
@REM --matVarName                wholav_images ^
@REM --roisName                  roi_37 ^
@REM --exposure                  2 ^
@REM --reverse                   ^
@REM --startTime                 3028 ^
@REM --endTime                   3482 ^
@REM --before                    100 ^
@REM --after                     100 ^
@REM --nBeats                    2 ^
@REM --cleanProcess              0  ^
@REM --blockDown                 0  ^
@REM --blockUp                   0 ^
@REM --shouldNotHaveAllPoints    ^
@REM --pixRes                    0.081 ^
@REM --maxDist                   3 ^
@REM --maxCV                     300 ^
@REM --cvCalcMethod              vanilla ^
@REM --scaleVectors              1. ^
@REM --apdtype                   90 ^
@REM --stimCL                    200 ^
@REM --stimType                  VI ^
@REM --sampleType                PV ^
@REM --sampleName                Pig8



@REM Pig 3 in OM, which is pig 9 in papers
@REM python D:/Code/simOmPP/getResultsFromOmapFiltered.py ^
@REM --folderPath                G:/Data/OM_PigHeart/MI/20211112_PigInfarcted3 ^
@REM --videoName                 48 ^
@REM --fileName                  FileTag048_video_filtered ^
@REM --matVarName                wholav_images ^
@REM --roisName                  roi_48 ^
@REM --exposure                  2 ^
@REM --reverse                   ^
@REM --startTime                 6800 ^
@REM --endTime                   7478 ^
@REM --before                    150 ^
@REM --after                     150 ^
@REM --nBeats                    2 ^
@REM --cleanProcess              0  ^
@REM --blockDown                 0  ^
@REM --blockUp                   0 ^
@REM --shouldNotHaveAllPoints    ^
@REM --pixRes                    0.073 ^
@REM --maxDist                   3 ^
@REM --maxCV                     300 ^
@REM --cvCalcMethod              vanilla ^
@REM --scaleVectors              1. ^
@REM --apdtype                   90 ^
@REM --stimCL                    300 ^
@REM --stimType                  AI ^
@REM --sampleType                AV ^
@REM --sampleName                Pig9



@REM !!!!!Getting clean maps in this way is difficult, maybe just use the video and images and avoid computing an AT map
