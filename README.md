# Warping Tensorfaces

Code for ["Warping TensorFaces: Preprocessing Images for Multilinear Analysis of Facial Image Ensembles"](http://shaydul.in/papers/tensorfaces.pdf).

An exploratory study of using preprocessing to improve the quality of multilinear analysis of facial images for facial recognition. Multilinear analysis is motivated by the fact that images are results of multiple factors like light conditions, pose and expression. However, we are not able to observe these latent variables. Multilinear analysis takes advantage of tensor decomposition methods to utilize those hidden variables. In this project we use Active Appearance models to warp the training images before using them to train the model. This project is based on the paper [Multilinear image analysis for facial recognition by Vasilescu et al.](https://ieeexplore.ieee.org/abstract/document/1048350/)

## Brief outline of the repo

Folder aam contains Jupyter Notebook that use Menpo framework to train the AAM, landmark the images and then warp them. jup_final builds AAM, uses it to landmark the images and exports landmarks. cootes_warp imports the corrected landmarks and warps the images. 

Folder tensor contains MATLAB scripts that build the model and perform recognition.

If you have any questions or are interested in reproducing the results, shoot me a message at [rshaydu@g.clemson.edu](mailto:rshaydu@g.clemson.edu).
