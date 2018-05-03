# Warping Tensorfaces

Code for ["Warping TensorFaces: Preprocessing Images for Multilinear Analysis of Facial Image Ensembles"](http://shaydul.in/papers/tensorfaces.pdf).

Folder aam contains Jupyter Notebook that use Menpo framework to train the AAM, landmark the images and then warp them. jup_final builds AAM, uses it to landmark the images and exports landmarks. cootes_warp imports the corrected landmarks and warps the images. 

Folder tensor contains MATLAB scripts that build the model and perform recognition.

If you have any questions or are interested in reproducing the results, shoot me a message at [rshaydu@g.clemson.edu](mailto:rshaydu@g.clemson.edu).
