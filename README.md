# Gaia 50pc Investigation

The data visualization of the RECONS 25 Parsec Database, linked [here](https://www.youtube.com/watch?v=up_MqNBv0FE&t=2s), was the initial motivation for this work. Our first goal was to create similar visual aids in MATLAB using more recent data from the Gaia Early Data Release 3 catalog. Our take on the RECONS video can be seen [here](https://drive.google.com/file/d/1Xoa4088Al3fVqOWhdOVU72jc6Bd-hA5N/view?usp=sharing). Our second visual aid plots stellar data in 3D (see plotstars3d.m). For our data this revealed highly dense regions that did not align with known star clusters, associations, or moving groups. 

This led to our second goal: investigate and isolate the high-density regions within 50 pc of the Sun. We created a simple statistical process to extract the stars in dense regions by using only the distances of their nearest neighbors (see findclusters.m). 

Further analysis of results will be detailed in a future RNAAS. This repo contains the data and scripts necessary to recreate our results or apply this methodology to a different dataset. 


## 50pc_results

This folder contains resulting figures and statistics for our investigation into over-dense regions within 50 pc.

## Data

This folder contains our data, which we queried from this [Vizier Catalog](https://cdsarc.cds.unistra.fr/viz-bin/cat/I/352). See the [source paper](https://iopscience.iop.org/article/10.3847/1538-3881/abd806) for more information on how the distance values were calculated. 

## Functions

This folder contains the 2 main functions necessary to replicate our results and example outputs. 

- plotstars3d.m plots your stellar data in 3D for helpful visualization
- findclusters.m isolates over-dense areas in your input data
- To run either of these functions you must load one of the .mat files from the [Data](Data/) folder into MATLAB, or load in your own data in a similar format. Then, call the function accordingly. See the function scripts for example function calls.
- The [Examples](Functions/Examples/) folder contains example outputs of both of these functions when GEDR3_50pc_alldata.mat is the loaded data. PNGs are included for easy access, and .fig files are also included for more interactive understanding and modification when viewed in MATLAB.



This project made use of MATLAB version R2024b.
