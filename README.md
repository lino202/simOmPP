# simOMPP

**simOMPP** stands for **Simulation – Optical Mapping Post-Processing**. This repository contains a collection of Python scripts for post-processing **Electra simulation results** and **optical mapping** experiments. Moreover, plotting scripts for creating graphs for publication are integrated.

---

### 📖 Glossary

| Acronym | Meaning |
|----------|----------|
| **AT** | Activation Time |
| **APD** | Action Potential Duration |
| **CV** | Conduction Velocity |
| **RT** | Repolarization Time |
| **DWI** | Diffusion-Weighted Imaging |
| **MD** | Mean Diffusivity |
| **FA** | Fractional Anisotropy |

---

### 🚀 Features

- Compute **APDs** from **Electra simulation results** (`.ens` files) or **Optical Mapping** filtered signals (`.mat`).  
- Generate plots of **ATs**, **APDs**, **RT gradients** and **CVs** from optical mapping data and simulations.  
- Calculation of the pseudo-ECG as reported in [10.3389/fphys.2019.01103](https://doi.org/10.3389/fphys.2019.01103)
- Export **VTK** files for visualization in [ParaView](https://www.paraview.org/) (RTs, ATs, CVs, and APDs).  
- Interpolate scalar data (e.g., ATs) over a mesh.  
- Include utilities for post-processing and visualization of electrophysiological data. For example, create and modify simulation videos from [ParaView](https://www.paraview.org/).

---

## ⚙️ Installation

1. **Install Python 3.X** and all dependencies using `pip` or `conda`.  
2. *(Optional)* It is recommended to use **Visual Studio Code** for development.  
3. **Clone the repository:**
   ```sh
   git clone https://github.com/lino202/simOmPP
   cd simOmPP
   ```
4. *(Optional)* Recreate the Conda environment using the provided file:  
   ```sh
   conda env create -f environment.yml
   ```
   See [Conda environment management](https://conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#create-env-file-manually) for details.
5. Try running a script, for example, reproduce one of the conduction velocity examples in [examples/CV](./examples/CV).

---

## 🧮 Usage

Each script accepts a set of command-line arguments. You can check the [`.vscode/launch.json`](.vscode/launch.json) file for examples of how to run scripts and what arguments they require. Also, you can check available options by running:
```sh
python /path-to-script/script.py --help
```
Read the code carefully to understand argument details — some scripts including advanced functionality described below.

---

### Conduction Velocity (CV) Computation

CV can be computed from **activation time (AT) maps** derived from:
- Electrophysiological simulations
- Optical mapping experiments  

CV is always reported in **cm/s**, assuming the input AT map is in **ms** and the **pixel resolution** is correctly provided in **cm**.

> ⚠️ For MATLAB matrices, pixels with a value of `0` are treated as invalid (`NaN`).  
> If your data uses `0` as a valid AT value, simply add a small offset (e.g., +1) to all pixels.

Three CV computation methods are implemented for MATLAB matrices:

- **Bayly** – Based on [Bayly et al.](https://ieeexplore.ieee.org/document/668746), fits a local surface using a least-squares method to estimate ∂x and ∂y of AT maps.  
- **Vanilla** – Computes the CV as the mean of local CVs within a circular region centered on each pixel.  
- **2Points** – Calculates CV between two user-defined points (see [getCV2Points.py](./getCV2Points.py)).

The output includes:
- CV magnitude maps (per pixel)  
- Histograms and boxplots of CV magnitudes  
- Mean and median CV values  
- Vector field plots of CV direction (HSV color-coded versor maps)  
- Exported images in `.png` or `.pdf` formats  

---

### 🧰 CV Script Main Arguments

| Argument | Description |
|-----------|--------------|
| **filePath** | Path to AT map in ms (typically `.mat`); pixels with zero value are treated as invalid (`NaN`). |
| **maxDist** | Maximum distance (in pixels) from the reference pixel for inclusion in CV computation. |
| **shouldNotHaveAllPoints** | If `False`, CV is only computed when all neighboring pixels (within `maxDist`) are available. |
| **atMapName** | Name of the AT map variable in the MATLAB file. |
| **cleanProcess** | Data cleaning option (0 = none). |
| **blockDown** | Lower threshold to exclude AT values (0 = none). |
| **blockUp** | Upper threshold to exclude AT values (0 = none). |
| **pixRes** | Pixel resolution (cm/pixel). |
| **maxCV** | Maximum CV value (cm/s) to consider. |
| **calcMethod** | CV computation method: `bayly` or `vanilla`. |
| **scaleVectors** | Scaling factor for quiver plots (depends on CV magnitude). |
| **outPath** | Output directory for results (if `0`, images are only displayed). |
| **outType** | Output image format: `png` or `pdf`. |


For more information regarding CV-related or other scripts please read the code carefully.
---

### 🎥 Notes

Videos created with OpenCV may not play properly in PowerPoint.  
Convert them using **FFmpeg**:

```sh
ffmpeg -i video.mp4 -vcodec libx264 -pix_fmt yuv420p -movflags +faststart video_ppt.mp4
```

---

### 🤝 Contributing

Contributions are what make the open-source community such an inspiring place to learn, share, and improve.  
Any contributions — from bug fixes to feature requests — are **greatly appreciated**.
