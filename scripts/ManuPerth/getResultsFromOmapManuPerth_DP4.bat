@REM @REM @ECHO OFF
@REM call conda activate simOmPP

@REM @REM S is stimulated and B is basal, L is longitudinal and T is transversal, C is central

@REM @REM DP4 ----------------------------------------------
python D:/Code/simOmPP/getResultsFromOmapFiltered.py ^
--folderPath                D:/Data/OM_BioVAD/Perth_24062024/total/DP4 ^
--videoName                 126 ^
--fileName                  FileTag126_video_filtered ^
--matVarName                wholav_images ^
--getSubRegions             ^
--subregionNames            L M S ^
--roisName                  roi_126 ^
--exposure                  10 ^
--reverse                   ^
--startTime                 2000 ^
--endTime                   7000 ^
--before                    1250 ^
--after                     1250 ^
--nBeats                    2 ^
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
--stimCL                    2503 ^
--stimType                  Basal ^
--sampleType                Diam ^
--sampleName                DP4



python D:/Code/simOmPP/getResultsFromOmapFiltered.py ^
--folderPath                D:/Data/OM_BioVAD/Perth_24062024/total/DP4 ^
--videoName                 127 ^
--fileName                  FileTag127_video_filtered ^
--matVarName                wholav_images ^
--getSubRegions             ^
--subregionNames            L M S ^
--roisName                  roi_127 ^
--exposure                  10 ^
--reverse                   ^
--startTime                 1000 ^
--endTime                   6800 ^
--before                    1000 ^
--after                     1000 ^
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
--stimCL                    2000 ^
--stimType                  Long ^
--sampleType                Diam ^
--sampleName                DP4



python D:/Code/simOmPP/getResultsFromOmapFiltered.py ^
--folderPath                D:/Data/OM_BioVAD/Perth_24062024/total/DP4 ^
--videoName                 128 ^
--fileName                  FileTag128_video_filtered ^
--matVarName                wholav_images ^
--getSubRegions             ^
--subregionNames            L M S ^
--roisName                  roi_127 ^
--exposure                  10 ^
--reverse                   ^
--startTime                 200 ^
--endTime                   5800 ^
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
--sampleName                DP4
