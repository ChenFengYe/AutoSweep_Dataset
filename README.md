# AutoSweep_Dataset
This is a instruction about Autosweep Dataset.

* **1\_ Cube\_Cylinder\_11658:** Contains all Images, masks and etc 
	* **cls:** FCIS data, classes level 
	* **gray:** Contour maps
	* **ImageSets:**Training lists,Testing lists
	* **img:** Image..。
	* **inst:** FCIS data, instances level 
	* **instanceIds_5classes:** Masks of MaskRCNN data, 5 classes
	* **instanceIds_6classes:** Masks of MaskRCNN data, 6 classes
	* **line:** Edge maps
	* **lineData:** For modeling, Record line Data.
	* **lineImage:** For modeling, visulization line.
	* **seg:** Masks of FCIS 
	* **tool:** Useful Tools 
	* **old_cube_files:** Old cube file with deficiency
* **2\_Cube\_Cylinder\_raw:** Backup data for deeplab, faster-rcnn
	* ... 
* **3\_Synthtic\_Data\_21467:** Synthtic Data with 10 models
	* ...
* **4\_Sub_Geonet\_data:** Training and Testing Data for Sub Geonet
	* ...
* **5_XiaoData:** XiaoData with Autosweep pattern in 1\_ Cube\_Cylinder\_11658.
* **6_AxisCurveData:**Training and Testing data for axis curve experiments
* **7_ExperimentData:**
	* **Exper_Cuboid:**Training Data for Cuboid Modeling and Detection Experiment
	* **Exper_FCIS_DCN:**Training Data for MeanAP Experiment 
	* **Exper_MeanAP:** Testing Data for MeanAP Experiment, For evaluation
	* **Exper_PointNet_VolexNet:** models for PointNet & VolexNet 
	* **Exper_XiaoCube:** Testing Data for Cuboid Modeling and Detection Experiment, For evaluation 
	* **Net_Model:**Config files and Models for FCIS, MaskRcnn & DCN 
	* **Rebuttal_Exper_Mask_RCN:** Rebuttal Experiments on MeanIOU.
 
