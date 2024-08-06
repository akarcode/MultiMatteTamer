# MultiMatte Tamer

![multimattetamer_122_722px](https://github.com/akarcode/MultiMatteTamer/assets/59408512/3b02d4ac-38f9-4428-8622-90fe2d65da13)

This MaxScript makes it very easy to apply Object ID's and store the MultiMatte Render Elements.

Objects are selected within the grid table. If objects and layers in your scene are not recognized by its name this script will not be much use.


### Manual

- **Add Button** will add another additional numbered ID button.
- **Refresh** reloads the objects in your scene. If an ID in your scene has been manually changed it will recognize it and add additional buttons if required.
- **Collect** will make use of all RGB slots and not sequential.
- **Selected** will only list the selected objects in your scene.
- **Filter** input selects all matches in the names column.
- **Elements** this will create the render elements based on your selection. If **Collect** is checked the elements will be created accordingly.
- **Double-clicking** inside a Cell will select either the same OID's, all items within a Layer or all related Names that end with a Number (\d+$) within the corresponding column. 


### Requirements

To create the render elements this script needs V-Ray since MultiMatteElement is part of V-Ray. Or else the 'Elements' button will be hidden but OID's can still be set.


### Changelog

v1.2.4

- Added HD mode
- Changed setting the IDs to use unique identifiers instead of Names

v1.2.3

- Fixed reopening form error

v1.2.2

- Added a filter input field
- Faster elements creation in 'Collect' mode
- Code cleanups and optimizations

v1.2.1

- Speed improvements in 'Collect' mode
- Small code cleanups

v1.2.0

- Major speed improvements
- Added script definitions
- Selected checkbox now refreshes the grid right away
- Disabled column ordering

v1.1.1

- Small fix for Collect checkbox

v1.1.0

- Rewrote the code responsible for cell coloring
- Added ability to select related by doubleclicking inside a cell
- Sorting columns is now possible
- Added V-Ray Decal and Clipper to ignore list

v1.0.1

- Fixed anchor problem
- Added a check if MultiMatte element is available and hide the 'Elements' button if not

v1.0 (Initial release)


