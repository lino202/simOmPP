@REM @ECHO OFF
call conda activate simOmPP

@REM S is stimulated and B is basal, L is longitudinal and T is transversal, C is central

@REM @REM DF ----------------------------------------------
python D:/Code/simOmPP/getResultsFromOmapFiltered.py ^
--folderPath                D:/Data/OM_BioVAD/Perth_24062024/total/DF ^
--videoName                 40 ^
--fileName                  FileTag040_video_filtered ^
--matVarName                wholav_images ^
--getSubRegions             ^
--subregionNames            L M S ^
--roisName                  roi_40 ^
--exposure                  10 ^
--reverse                   ^
--startTime                 400 ^
--endTime                   5800 ^
--before                    650 ^
--after                     650 ^
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
--stimCL                    1274 ^
--stimType                  Basal ^
--sampleType                Diam ^
--sampleName                DF




python D:/Code/simOmPP/getResultsFromOmapFiltered.py ^
--folderPath                D:/Data/OM_BioVAD/Perth_24062024/total/DF ^
--videoName                 42 ^
--fileName                  FileTag042_video_filtered ^
--matVarName                wholav_images ^
--getSubRegions             ^
--subregionNames            L M S ^
--roisName                  roi_42 ^
--exposure                  10 ^
--reverse                   ^
--startTime                 0 ^
--endTime                   5500 ^
--before                    550 ^
--after                     550 ^
--nBeats                    5 ^
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
--stimCL                    1000 ^
--stimType                  Long ^
--sampleType                Diam ^
--sampleName                DF



python D:/Code/simOmPP/getResultsFromOmapFiltered.py ^
--folderPath                D:/Data/OM_BioVAD/Perth_24062024/total/DF ^
--videoName                 45 ^
--fileName                  FileTag045_video_filtered ^
--matVarName                wholav_images ^
--getSubRegions             ^
--subregionNames            L M S ^
--roisName                  roi_45 ^
--exposure                  10 ^
--reverse                   ^
--startTime                 500 ^
--endTime                   6000 ^
--before                    550 ^
--after                     550 ^
--nBeats                    5 ^
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
--stimCL                    1000 ^
--stimType                  Trans ^
--sampleType                Diam ^
--sampleName                DF