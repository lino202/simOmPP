@ECHO OFF
call conda activate simOmPP

echo "With SZ complete mesh ------------------------------------------------------------------------------"
echo "EHT1 -----------------------------------------------------------------------------------------------"
python D:/Code/simOmPP/plotEdgeLength.py ^
--filePath    D:/Paper4/Models/sample4/EHT1/mesh/tetmesh.vtk ^
--outPath     D:/Paper4/Models/sample4/EHT1/mesh/tetmesh_histedges.pdf ^
--numModes    2 ^
--resExcel    D:/Paper4/Models/results_edgelengths.xlsx

python D:/Code/simOmPP/plotEdgeLength.py ^
--filePath    D:/Paper4/Models/sample5/EHT1/mesh/tetmesh.vtk ^
--outPath     D:/Paper4/Models/sample5/EHT1/mesh/tetmesh_histedges.pdf ^
--numModes    2 ^
--resExcel    D:/Paper4/Models/results_edgelengths.xlsx

python D:/Code/simOmPP/plotEdgeLength.py ^
--filePath    D:/Paper4/Models/sample6_x/EHT1/mesh/tetmesh.vtk ^
--outPath     D:/Paper4/Models/sample6_x/EHT1/mesh/tetmesh_histedges.pdf ^
--numModes    2 ^
--resExcel    D:/Paper4/Models/results_edgelengths.xlsx

python D:/Code/simOmPP/plotEdgeLength.py ^
--filePath    D:/Paper4/Models/sample7/EHT1/mesh/tetmesh.vtk ^
--outPath     D:/Paper4/Models/sample7/EHT1/mesh/tetmesh_histedges.pdf ^
--numModes    2 ^
--resExcel    D:/Paper4/Models/results_edgelengths.xlsx

python D:/Code/simOmPP/plotEdgeLength.py ^
--filePath    D:/Paper4/Models/sample8/EHT1/mesh/tetmesh.vtk ^
--outPath     D:/Paper4/Models/sample8/EHT1/mesh/tetmesh_histedges.pdf ^
--numModes    2 ^
--resExcel    D:/Paper4/Models/results_edgelengths.xlsx

python D:/Code/simOmPP/plotEdgeLength.py ^
--filePath    D:/Paper4/Models/sample9/EHT1/mesh/tetmesh.vtk ^
--outPath     D:/Paper4/Models/sample9/EHT1/mesh/tetmesh_histedges.pdf ^
--numModes    2 ^
--resExcel    D:/Paper4/Models/results_edgelengths.xlsx

python D:/Code/simOmPP/plotEdgeLength.py ^
--filePath    D:/Paper4/Models/sample10/EHT1/mesh/tetmesh.vtk ^
--outPath     D:/Paper4/Models/sample10/EHT1/mesh/tetmesh_histedges.pdf ^
--numModes    2 ^
--resExcel    D:/Paper4/Models/results_edgelengths.xlsx

python D:/Code/simOmPP/plotEdgeLength.py ^
--filePath    D:/Paper4/Models/sample11/EHT1/mesh/tetmesh.vtk ^
--outPath     D:/Paper4/Models/sample11/EHT1/mesh/tetmesh_histedges.pdf ^
--numModes    2 ^
--resExcel    D:/Paper4/Models/results_edgelengths.xlsx

python D:/Code/simOmPP/plotEdgeLength.py ^
--filePath    D:/Paper4/Models/sample12/EHT1/mesh/tetmesh.vtk ^
--outPath     D:/Paper4/Models/sample12/EHT1/mesh/tetmesh_histedges.pdf ^
--numModes    3 ^
--resExcel    D:/Paper4/Models/results_edgelengths.xlsx


echo "EHT2 ------------------------------------------"
python D:/Code/simOmPP/plotEdgeLength.py ^
--filePath    D:/Paper4/Models/sample4/EHT2/mesh/tetmesh.vtk ^
--outPath     D:/Paper4/Models/sample4/EHT2/mesh/tetmesh_histedges.pdf ^
--numModes    2 ^
--resExcel    D:/Paper4/Models/results_edgelengths.xlsx

python D:/Code/simOmPP/plotEdgeLength.py ^
--filePath    D:/Paper4/Models/sample5/EHT2/mesh/tetmesh.vtk ^
--outPath     D:/Paper4/Models/sample5/EHT2/mesh/tetmesh_histedges.pdf ^
--numModes    2 ^
--resExcel    D:/Paper4/Models/results_edgelengths.xlsx

python D:/Code/simOmPP/plotEdgeLength.py ^
--filePath    D:/Paper4/Models/sample6_x/EHT2/mesh/tetmesh.vtk ^
--outPath     D:/Paper4/Models/sample6_x/EHT2/mesh/tetmesh_histedges.pdf ^
--numModes    2 ^
--resExcel    D:/Paper4/Models/results_edgelengths.xlsx

python D:/Code/simOmPP/plotEdgeLength.py ^
--filePath    D:/Paper4/Models/sample7/EHT2/mesh/tetmesh.vtk ^
--outPath     D:/Paper4/Models/sample7/EHT2/mesh/tetmesh_histedges.pdf ^
--numModes    2 ^
--resExcel    D:/Paper4/Models/results_edgelengths.xlsx

python D:/Code/simOmPP/plotEdgeLength.py ^
--filePath    D:/Paper4/Models/sample8/EHT2/mesh/tetmesh.vtk ^
--outPath     D:/Paper4/Models/sample8/EHT2/mesh/tetmesh_histedges.pdf ^
--numModes    2 ^
--resExcel    D:/Paper4/Models/results_edgelengths.xlsx

python D:/Code/simOmPP/plotEdgeLength.py ^
--filePath    D:/Paper4/Models/sample9/EHT2/mesh/tetmesh.vtk ^
--outPath     D:/Paper4/Models/sample9/EHT2/mesh/tetmesh_histedges.pdf ^
--numModes    2 ^
--resExcel    D:/Paper4/Models/results_edgelengths.xlsx

python D:/Code/simOmPP/plotEdgeLength.py ^
--filePath    D:/Paper4/Models/sample10/EHT2/mesh/tetmesh.vtk ^
--outPath     D:/Paper4/Models/sample10/EHT2/mesh/tetmesh_histedges.pdf ^
--numModes    2 ^
--resExcel    D:/Paper4/Models/results_edgelengths.xlsx

python D:/Code/simOmPP/plotEdgeLength.py ^
--filePath    D:/Paper4/Models/sample11/EHT2/mesh/tetmesh.vtk ^
--outPath     D:/Paper4/Models/sample11/EHT2/mesh/tetmesh_histedges.pdf ^
--numModes    2 ^
--resExcel    D:/Paper4/Models/results_edgelengths.xlsx

python D:/Code/simOmPP/plotEdgeLength.py ^
--filePath    D:/Paper4/Models/sample12/EHT2/mesh/tetmesh.vtk ^
--outPath     D:/Paper4/Models/sample12/EHT2/mesh/tetmesh_histedges.pdf ^
--numModes    2 ^
--resExcel    D:/Paper4/Models/results_edgelengths.xlsx


















echo "WithOUT SZ INcomplete mesh ------------------------------------------------------------------------------"
echo "EHT1 -----------------------------------------------------------------------------------------------"
python D:/Code/simOmPP/plotEdgeLength.py ^
--filePath    D:/Paper4/Models/sample4/EHT1/mesh/mesh_no_scar.vtk ^
--outPath     D:/Paper4/Models/sample4/EHT1/mesh/mesh_no_scar_histedges.pdf ^
--numModes    2 ^
--resExcel    D:/Paper4/Models/results_edgelengths.xlsx

python D:/Code/simOmPP/plotEdgeLength.py ^
--filePath    D:/Paper4/Models/sample5/EHT1/mesh/mesh_no_scar.vtk ^
--outPath     D:/Paper4/Models/sample5/EHT1/mesh/mesh_no_scar_histedges.pdf ^
--numModes    2 ^
--resExcel    D:/Paper4/Models/results_edgelengths.xlsx

python D:/Code/simOmPP/plotEdgeLength.py ^
--filePath    D:/Paper4/Models/sample6_x/EHT1/mesh/mesh_no_scar.vtk ^
--outPath     D:/Paper4/Models/sample6_x/EHT1/mesh/mesh_no_scar_histedges.pdf ^
--numModes    2 ^
--resExcel    D:/Paper4/Models/results_edgelengths.xlsx

python D:/Code/simOmPP/plotEdgeLength.py ^
--filePath    D:/Paper4/Models/sample7/EHT1/mesh/mesh_no_scar.vtk ^
--outPath     D:/Paper4/Models/sample7/EHT1/mesh/mesh_no_scar_histedges.pdf ^
--numModes    2 ^
--resExcel    D:/Paper4/Models/results_edgelengths.xlsx

python D:/Code/simOmPP/plotEdgeLength.py ^
--filePath    D:/Paper4/Models/sample8/EHT1/mesh/mesh_no_scar.vtk ^
--outPath     D:/Paper4/Models/sample8/EHT1/mesh/mesh_no_scar_histedges.pdf ^
--numModes    2 ^
--resExcel    D:/Paper4/Models/results_edgelengths.xlsx

python D:/Code/simOmPP/plotEdgeLength.py ^
--filePath    D:/Paper4/Models/sample9/EHT1/mesh/mesh_no_scar.vtk ^
--outPath     D:/Paper4/Models/sample9/EHT1/mesh/mesh_no_scar_histedges.pdf ^
--numModes    2 ^
--resExcel    D:/Paper4/Models/results_edgelengths.xlsx

python D:/Code/simOmPP/plotEdgeLength.py ^
--filePath    D:/Paper4/Models/sample10/EHT1/mesh/mesh_no_scar.vtk ^
--outPath     D:/Paper4/Models/sample10/EHT1/mesh/mesh_no_scar_histedges.pdf ^
--numModes    2 ^
--resExcel    D:/Paper4/Models/results_edgelengths.xlsx

python D:/Code/simOmPP/plotEdgeLength.py ^
--filePath    D:/Paper4/Models/sample11/EHT1/mesh/mesh_no_scar.vtk ^
--outPath     D:/Paper4/Models/sample11/EHT1/mesh/mesh_no_scar_histedges.pdf ^
--numModes    2 ^
--resExcel    D:/Paper4/Models/results_edgelengths.xlsx

python D:/Code/simOmPP/plotEdgeLength.py ^
--filePath    D:/Paper4/Models/sample12/EHT1/mesh/mesh_no_scar.vtk ^
--outPath     D:/Paper4/Models/sample12/EHT1/mesh/mesh_no_scar_histedges.pdf ^
--numModes    3 ^
--resExcel    D:/Paper4/Models/results_edgelengths.xlsx


echo "EHT2 ------------------------------------------"
python D:/Code/simOmPP/plotEdgeLength.py ^
--filePath    D:/Paper4/Models/sample4/EHT2/mesh/mesh_no_scar.vtk ^
--outPath     D:/Paper4/Models/sample4/EHT2/mesh/mesh_no_scar_histedges.pdf ^
--numModes    2 ^
--resExcel    D:/Paper4/Models/results_edgelengths.xlsx

python D:/Code/simOmPP/plotEdgeLength.py ^
--filePath    D:/Paper4/Models/sample5/EHT2/mesh/mesh_no_scar.vtk ^
--outPath     D:/Paper4/Models/sample5/EHT2/mesh/mesh_no_scar_histedges.pdf ^
--numModes    2 ^
--resExcel    D:/Paper4/Models/results_edgelengths.xlsx

python D:/Code/simOmPP/plotEdgeLength.py ^
--filePath    D:/Paper4/Models/sample6_x/EHT2/mesh/mesh_no_scar.vtk ^
--outPath     D:/Paper4/Models/sample6_x/EHT2/mesh/mesh_no_scar_histedges.pdf ^
--numModes    2 ^
--resExcel    D:/Paper4/Models/results_edgelengths.xlsx

python D:/Code/simOmPP/plotEdgeLength.py ^
--filePath    D:/Paper4/Models/sample7/EHT2/mesh/mesh_no_scar.vtk ^
--outPath     D:/Paper4/Models/sample7/EHT2/mesh/mesh_no_scar_histedges.pdf ^
--numModes    2 ^
--resExcel    D:/Paper4/Models/results_edgelengths.xlsx

python D:/Code/simOmPP/plotEdgeLength.py ^
--filePath    D:/Paper4/Models/sample8/EHT2/mesh/mesh_no_scar.vtk ^
--outPath     D:/Paper4/Models/sample8/EHT2/mesh/mesh_no_scar_histedges.pdf ^
--numModes    2 ^
--resExcel    D:/Paper4/Models/results_edgelengths.xlsx

python D:/Code/simOmPP/plotEdgeLength.py ^
--filePath    D:/Paper4/Models/sample9/EHT2/mesh/mesh_no_scar.vtk ^
--outPath     D:/Paper4/Models/sample9/EHT2/mesh/mesh_no_scar_histedges.pdf ^
--numModes    2 ^
--resExcel    D:/Paper4/Models/results_edgelengths.xlsx

python D:/Code/simOmPP/plotEdgeLength.py ^
--filePath    D:/Paper4/Models/sample10/EHT2/mesh/mesh_no_scar.vtk ^
--outPath     D:/Paper4/Models/sample10/EHT2/mesh/mesh_no_scar_histedges.pdf ^
--numModes    2 ^
--resExcel    D:/Paper4/Models/results_edgelengths.xlsx

python D:/Code/simOmPP/plotEdgeLength.py ^
--filePath    D:/Paper4/Models/sample11/EHT2/mesh/mesh_no_scar.vtk ^
--outPath     D:/Paper4/Models/sample11/EHT2/mesh/mesh_no_scar_histedges.pdf ^
--numModes    2 ^
--resExcel    D:/Paper4/Models/results_edgelengths.xlsx

python D:/Code/simOmPP/plotEdgeLength.py ^
--filePath    D:/Paper4/Models/sample12/EHT2/mesh/mesh_no_scar.vtk ^
--outPath     D:/Paper4/Models/sample12/EHT2/mesh/mesh_no_scar_histedges.pdf ^
--numModes    2 ^
--resExcel    D:/Paper4/Models/results_edgelengths.xlsx