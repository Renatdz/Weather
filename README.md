# Weather

This is a weather sample app.

## Installation

This project only uses Swift Package Manager, so just open the project and be happy. :)

## Archtecture

The project is built using VIP architecture. I choose this pattern because it separates layers and responsibilities very well, and it makes creating tests easier.

Each scene can use the layers below:

**Factory** - Used to make the links between the other layers.
**Coordinator/Router** - Used to create the navigation between scenes.
**Service** - Used to make api/cache/database calls
**Interactor** - Used to create the business logic of the scene.
**Presenter** - Used to format the data and present to ViewController or call a new scene by calling the coordinator.
**ViewController** - Used to handle UI events, User gestures, life cycle events and etc.
**View** - Used to separate the layout creation from ViewController.

## Helpers

ViewController - Used to wrap some behaviors of the ViewController.
ViewLayoutable - Used to create and follow the right order of the view code function calls.
Size - Used to set some different sizes of spacings.
Localizable - Used to store strings.

## Tests & Coverage

Tests are built with XCTest, I didn't use Quick & Nimble, because XCTest already does the work, so no need for a third party.

## Libs

This project uses the libraries below:

[SnapKit](https://github.com/SnapKit/SnapKit) - Used to create the layout/constraints easier.
