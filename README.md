#Fictional Physics

## Current Controls

* MouseDrag : Move scene in x and y.
* MouseWheel : Zoom in or out.
* a : Add an atom at mouse position. (Bugs when zoomed in or out).

## Element to JSON conversion convension

* Only personal attributes are transfered.	
	* A personal attribute is a attribute unique to the element being sent, such could be the current velocity, charge, behavioural paramaters etv.
* Toxiclibs provides a set of Vector classes which we will mimic using arrays in JSON
	* A Vec#D will be stored as an Array[#].
	* The axial organisatioin remains "xyz" with "x=[0]", "y=[1]" and "z=[2]".
