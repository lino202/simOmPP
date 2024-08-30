@REM @ECHO OFF
call conda activate simOmPP

@REM S is stimulated and B is basal, L is longitudinal and T is transversal, C is central

@REM @REM DP1 ----------------------------------------------
python D:/Code/simOmPP/getResultsFromOmapFiltered.py ^
--folderPath                D:/Data/OM_BioVAD/Perth_24062024/total/DP1 ^
--videoName                 82 ^
--fileName                  FileTag082_video_filtered ^
--matVarName                wholav_images ^
--getSubRegions             ^
--subregionNames            L M S ^
--roisName                  roi_82 ^
--exposure                  10 ^
--reverse                   ^
--startTime                 0 ^
--endTime                   10000 ^
--before                    1300 ^
--after                     1300 ^
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
--stimCL                    2470 ^
--stimType                  Basal ^
--sampleType                Diam ^
--sampleName                DP1




python D:/Code/simOmPP/getResultsFromOmapFiltered.py ^
--folderPath                D:/Data/OM_BioVAD/Perth_24062024/total/DP1 ^
--videoName                 83 ^
--fileName                  FileTag083_video_filtered ^
--matVarName                wholav_images ^
--getSubRegions             ^
--subregionNames            L M S ^
--roisName                  roi_83 ^
--exposure                  10 ^
--reverse                   ^
--startTime                 500 ^
--endTime                   8900 ^
--before                    1050 ^
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
--stimCL                    2000 ^
--stimType                  Long ^
--sampleType                Diam ^
--sampleName                DP1


python D:/Code/simOmPP/getResultsFromOmapFiltered.py ^
--folderPath                D:/Data/OM_BioVAD/Perth_24062024/total/DP1 ^
--videoName                 84 ^
--fileName                  FileTag084_video_filtered ^
--matVarName                wholav_images ^
--getSubRegions             ^
--subregionNames            L M S ^
--roisName                  roi_83 ^
--exposure                  10 ^
--reverse                   ^
--startTime                 4800 ^
--endTime                   9200 ^
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
--stimType                  Long ^
--sampleType                Diam ^
--sampleName                DP1


python D:/Code/simOmPP/getResultsFromOmapFiltered.py ^
--folderPath                D:/Data/OM_BioVAD/Perth_24062024/total/DP1 ^
--videoName                 86 ^
--fileName                  FileTag086_video_filtered ^
--matVarName                wholav_images ^
--getSubRegions             ^
--subregionNames            L M S ^
--roisName                  roi_86 ^
--exposure                  10 ^
--reverse                   ^
--startTime                 0 ^
--endTime                   10000 ^
--before                    1100 ^
--after                     1100 ^
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
--stimCL                    2000 ^
--stimType                  Trans ^
--sampleType                Diam ^
--sampleName                DP1


python D:/Code/simOmPP/getResultsFromOmapFiltered.py ^
--folderPath                D:/Data/OM_BioVAD/Perth_24062024/total/DP1 ^
--videoName                 87 ^
--fileName                  FileTag087_video_filtered ^
--matVarName                wholav_images ^
--getSubRegions             ^
--subregionNames            L M S ^
--roisName                  roi_86 ^
--exposure                  10 ^
--reverse                   ^
--startTime                 800 ^
--endTime                   9200 ^
--before                    550 ^
--after                     550 ^
--nBeats                    8 ^
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
--sampleName                DP1