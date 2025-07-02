# Gaia 50pc Investigation

Star clusters are typically identified through probability models and verified by their stellar factors (color, age, proper motion, etc.). The closest confirmed star cluster to the Sun is the Hyades at ~47 parsecs. Here, we present preliminary findings of 7 other spatial over-densities within 50 parsecs. 

The initial motivation for this work was the data visualization of the RECONS 25 Parsec Database (https://www.youtube.com/watch?v=up_MqNBv0FE&t=2s). Our first goal was to create similar visual aids using more recent data from the Gaia Early Data Release 3 Catalog. Our visual aids can be found in the Products folder. See plotstars3d.m to generate a 3D MATLAB figure of stellar data. 

Using our visualization tools for our dataset revealed clear over-densities besides the Hyades cluster, which was unexpected. These populations do not seem to correspond to known moving groups of stars. Wanting to investigate these high density regions further, we created a simple statistical process to extract the stars in dense regions, using only the distances of their nearest neighbors. See findclusters.m for more details on our methods. 

Associated figures and a summary of results can be found under Products for our investigation. Further analysis of results will be detailed in a future RNAAS.

Data to replicate these results can be found ... somewhere
