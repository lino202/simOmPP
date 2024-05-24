@REM @ECHO OFF

@REM cd C:\Program Files\MATLAB\R2021a\bin

matlab -nosplash -nojvm -r "try; cd('D:\Simulations\simOmPP\pECG'); sample = 'sample2/'; experiment = 'results_fib_standard_cs_endo_tentusscher/'; compPECG_script; catch; end; quit"
matlab -nosplash -nojvm -r "try; cd('D:\Simulations\simOmPP\pECG'); sample = 'sample2/'; experiment = 'results_fib_fromdwi_cs_endo_tentusscher/'; compPECG_script; catch; end; quit"
matlab -nosplash -nojvm -r "try; cd('D:\Simulations\simOmPP\pECG'); sample = 'sample2/'; experiment = 'results_fib_standard_cs_intra_tentusscher/'; compPECG_script; catch; end; quit"
@REM matlab -nosplash -nojvm -r "try; cd('D:\Simulations\simOmPP\pECG'); sample = 'sample2/'; experiment = 'results_fib_standard_cs_endo_ohara/'; compPECG_script; catch; end; quit"
@REM matlab -nosplash -nojvm -r "try; cd('D:\Simulations\simOmPP\pECG'); sample = 'sample2/'; experiment = 'results_fib_standard_cs_endo_gaur/'; compPECG_script; catch; end; quit"
@REM matlab -nosplash -nojvm -r "try; cd('D:\Simulations\simOmPP\pECG'); sample = 'sample2/'; experiment = 'results_fib_standard_cs_intra_gaur/'; compPECG_script; catch; end; quit"
@REM 
@REM 
matlab -nosplash -nojvm -r "try; cd('D:\Simulations\simOmPP\pECG'); sample = 'sample3/'; experiment = 'results_fib_standard_cs_endo_tentusscher/'; compPECG_script; catch; end; quit"
matlab -nosplash -nojvm -r "try; cd('D:\Simulations\simOmPP\pECG'); sample = 'sample3/'; experiment = 'results_fib_fromdwi_cs_endo_tentusscher/'; compPECG_script; catch; end; quit"
matlab -nosplash -nojvm -r "try; cd('D:\Simulations\simOmPP\pECG'); sample = 'sample3/'; experiment = 'results_fib_standard_cs_intra_tentusscher/'; compPECG_script; catch; end; quit"
matlab -nosplash -nojvm -r "try; cd('D:\Simulations\simOmPP\pECG'); sample = 'sample3/'; experiment = 'results_fib_standard_cs_endo_ohara/'; compPECG_script; catch; end; quit"
matlab -nosplash -nojvm -r "try; cd('D:\Simulations\simOmPP\pECG'); sample = 'sample3/'; experiment = 'results_fib_standard_cs_endo_gaur/'; compPECG_script; catch; end; quit"
matlab -nosplash -nojvm -r "try; cd('D:\Simulations\simOmPP\pECG'); sample = 'sample3/'; experiment = 'results_fib_standard_cs_intra_gaur/'; compPECG_script; catch; end; quit"