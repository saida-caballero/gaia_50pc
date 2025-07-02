# Gaia 50pc Investigation

The initial motivation for this work was the data visualization of the RECONS 25 Parsec Database, linked [here](https://www.youtube.com/watch?v=up_MqNBv0FE&t=2s). Our first goal was to create similar visual aids using more recent data from the Gaia Early Data Release 3 catalog. Our take on the RECONS video can be seen [here](https://drive.google.com/file/d/1Xoa4088Al3fVqOWhdOVU72jc6Bd-hA5N/view?usp=sharing). Our second visual aid plots stellar data in 3D (see plotstars3d.m). For our data this revealed highly dense regions that did not align with known star clusters, associations, or moving groups. 

This led to our second goal: investigate and isolate the high-density regions within 50pc of the Sun. We created a simple statistical process to extract the stars in dense regions by using only the distances of their nearest neighbors (see findclusters.m). 

Further analysis of results will be detailed in a future RNAAS. This repo contains the data and scripts necessary to recreate our results or apply this methodology to a different dataset. 


## 50pc_results

This folder contains resulting figures and statistics for our investigation into over-dense regions within 50pc.

## Data

This folder contains our data which was queried from this [Vizier Catalog](https://cdsarc.cds.unistra.fr/viz-bin/cat/I/352). See the [source paper](https://iopscience.iop.org/article/10.3847/1538-3881/abd806) for more information on how the distance values were calculated. 

## Functions

This folder contains the 2 main functions necessary to replicate our results and example outputs. plotstars3d.m plots your stellar data in 3D for helpful visualization. findclusters.m isolates over-dense areas in your input data. 


This project made use of MATLAB version R2024b.
