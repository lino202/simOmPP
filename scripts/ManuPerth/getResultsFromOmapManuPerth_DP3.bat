@REM @REM @ECHO OFF
@REM call conda activate simOmPP

@REM @REM S is stimulated and B is basal, L is longitudinal and T is transversal, C is central

@REM @REM DP3 ----------------------------------------------
python D:/Code/simOmPP/getResultsFromOmapFiltered.py ^
--folderPath                D:/Data/OM_BioVAD/Perth_24062024/total/DP3 ^
--videoName                 110 ^
--fileName                  FileTag110_video_filtered ^
--matVarName                wholav_images ^
--getSubRegions             ^
--subregionNames            L M S ^
--roisName                  roi_110 ^
--exposure                  10 ^
--reverse                   ^
--startTime                 6000 ^
--endTime                   9500 ^
--before                    550 ^
--after                     550 ^
--nBeats                    3 ^
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
--stimCL                    1052 ^
--stimType                  Basal ^
--sampleType                Diam ^
--sampleName                DP3



python D:/Code/simOmPP/getResultsFromOmapFiltered.py ^
--folderPath                D:/Data/OM_BioVAD/Perth_24062024/total/DP3 ^
--videoName                 112 ^
--fileName                  FileTag112_video_filtered ^
--matVarName                wholav_images ^
--getSubRegions             ^
--subregionNames            L M S ^
--roisName                  roi_112 ^
--exposure                  10 ^
--reverse                   ^
--startTime                 1800 ^
--endTime                   5600 ^
--before                    550 ^
--after                     550 ^
--nBeats                    3 ^
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
--sampleName                DP3



python D:/Code/simOmPP/getResultsFromOmapFiltered.py ^
--folderPath                D:/Data/OM_BioVAD/Perth_24062024/total/DP3 ^
--videoName                 117 ^
--fileName                  FileTag117_video_filtered ^
--matVarName                wholav_images ^
--getSubRegions             ^
--subregionNames            L M S ^
--roisName                  roi_117 ^
--exposure                  10 ^
--reverse                   ^
--startTime                 5700 ^
--endTime                   9800 ^
--before                    550 ^
--after                     550 ^
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
--stimCL                    1000 ^
--stimType                  Trans ^
--sampleType                Diam ^
--sampleName                DP3

