
# simOMPP

simOMPP stands for Simulation - Optical Mapping Post Processing. Here you can find a collection of Python scripts for post-processing Electra simulations results and MatLab action potential durations and activation times from optical mappings.


### Glossary
 
* AT activation time
* APD action potential duration
* CV conduction velocity
* RT repolarization time


### Features

* Compute APDs from Electra simulation results (.ens files) or from OMap's filtered signals (.mat)   
* Get plots of ATs and APDs from OMap
* Generate .vtk for visualization on paraview of RTs, ATs, CVs and APDs
* Interpolate data on mesh as ATs
* Also you can find some utilities for post processing the aforementioned files.


## Installation

1. Install Python 3.X and install all dependencies using pip or conda
2. [Optional] It is recommended to use VS code.
3. Clone the repo
   ```sh
   git clone https://github.com/lino202/simOmPP
   ```
4. Try the code



<!-- USAGE EXAMPLES -->
## Usage

Every script receives a group of arguments, the specific information for these arguments is in the code, READ IT carefully.
You can run
   ```sh
   /path-to-script/script.py --help 
   ```
In order to see the arguments needed it and what they do. Some more complicate code is explain in the following.

### CV computation

CV can be computed from AT maps in meshes and matlab matrices coming from simulations (Laura GM) or optical mapping data. The CV is always output in cm/s but for this to be true it is compulsory to input and AT map in ms and the pixel resolution correctly in cm. 

For AT maps coming as MatLab matrices the zero value is interpretated as a Nan so if all the pixel in a image/matrix coming from MatLab are valid AT values, any of them should be zero in order to avoid their interpretation as Nans.

Three types of CV can be computed for MatLab matrices *Bayly*, *Vanilla* and *2Points*. The first two are a pixel-wise calculation while the other is defined in between two points selected by the user (see [getCV2Points.py](./getCV2Points.py)). 

* The bayly method is described in [Bayly et al](https://ieeexplore.ieee.org/document/668746) but it basically aproximates a surface with the least-squared method in a region of the AT map center in the pixel of interest and computes dx and dy. 
* The vanilla simply computes the CV in a pixel as the mean of the CV among this pixel and the ones in a specific circle with radious determined by the user.


<!-- CONTRIBUTING -->
### Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

Please if you find any issue or desire a new feature you can submit them in the issue section of this repo.





