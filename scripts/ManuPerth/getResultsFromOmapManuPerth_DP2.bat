@REM @ECHO OFF
call conda activate simOmPP

@REM S is stimulated and B is basal, L is longitudinal and T is transversal, C is central

@REM DP2 ----------------------------------------------
python D:/Code/simOmPP/getResultsFromOmapFiltered.py ^
--folderPath                D:/Data/OM_BioVAD/Perth_24062024/total/DP2 ^
--videoName                 96 ^
--fileName                  FileTag096_video_filtered ^
--matVarName                wholav_images ^
--getSubRegions             ^
--subregionNames            L M S ^
--roisName                  roi_96 ^
--exposure                  10 ^
--reverse                   ^
--startTime                 300 ^
--endTime                   9700 ^
--before                    1150 ^
--after                     1150 ^
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
--stimCL                    2166 ^
--stimType                  Basal ^
--sampleType                Diam ^
--sampleName                DP2



python D:/Code/simOmPP/getResultsFromOmapFiltered.py ^
--folderPath                D:/Data/OM_BioVAD/Perth_24062024/total/DP2 ^
--videoName                 97 ^
--fileName                  FileTag097_video_filtered ^
--matVarName                wholav_images ^
--getSubRegions             ^
--subregionNames            L M S ^
--roisName                  roi_97 ^
--exposure                  10 ^
--reverse                   ^
--startTime                 5000 ^
--endTime                   9200 ^
--before                    1150 ^
--after                     1150 ^
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
--stimCL                    2000 ^
--stimType                  Long ^
--sampleType                Diam ^
--sampleName                DP2



python D:/Code/simOmPP/getResultsFromOmapFiltered.py ^
--folderPath                D:/Data/OM_BioVAD/Perth_24062024/total/DP2 ^
--videoName                 98 ^
--fileName                  FileTag098_video_filtered ^
--matVarName                wholav_images ^
--getSubRegions             ^
--subregionNames            L M S ^
--roisName                  roi_97 ^
--exposure                  10 ^
--reverse                   ^
--startTime                 4700 ^
--endTime                   7300 ^
--before                    550 ^
--after                     550 ^
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
--stimCL                    1000 ^
--stimType                  Long ^
--sampleType                Diam ^
--sampleName                DP2




python D:/Code/simOmPP/getResultsFromOmapFiltered.py ^
--folderPath                D:/Data/OM_BioVAD/Perth_24062024/total/DP2 ^
--videoName                 100 ^
--fileName                  FileTag100_video_filtered ^
--matVarName                wholav_images ^
--getSubRegions             ^
--subregionNames            L M S ^
--roisName                  roi_100 ^
--exposure                  10 ^
--reverse                   ^
--startTime                 3000 ^
--endTime                   9000 ^
--before                    1150 ^
--after                     1150 ^
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
--stimType                  Trans ^
--sampleType                Diam ^
--sampleName                DP2



python D:/Code/simOmPP/getResultsFromOmapFiltered.py ^
--folderPath                D:/Data/OM_BioVAD/Perth_24062024/total/DP2 ^
--videoName                 101 ^
--fileName                  FileTag101_video_filtered ^
--matVarName                wholav_images ^
--getSubRegions             ^
--subregionNames            L M S ^
--roisName                  roi_100 ^
--exposure                  10 ^
--reverse                   ^
--startTime                 500 ^
--endTime                   5900 ^
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
--sampleName                DP2