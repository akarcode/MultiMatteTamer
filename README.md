# MultiMatte Tamer

![multimattetamer_100](https://user-images.githubusercontent.com/59408512/230003487-4078d82c-b12f-4b6b-bf16-43bc137c4145.png)

This MaxScript makes it very easy to apply Object ID's and store the MultiMatte Render Elements.

Objects are selected within the grid table. If objects and layers in your scene are not recognized by its name this script will not be much use.


### Manual

- **Add Button** will add another additional numbered ID button.
- **Refresh** reloads the objects in your scene. If an ID in your scene has been manually changed it will recognize it and add additional buttons if required.
- **Collect** will make use of all RGB slots and not sequential.
- **Selected** will only list the selected objects in your scene.
- **Elements** this will create the render elements based on your selection. If **Collect** is checked the elements will be created accordingly.


### Requirements

To create the render elements this script needs V-Ray since MultiMatteElement is part of V-Ray.


### Changelog

v1.0.1

- fixed anchor problem

v1.0 (Initial release)
