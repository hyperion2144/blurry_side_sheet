![](https://raw.githubusercontent.com/hyperion2144/blurry_side_sheet/main/assets/Material%20design%203%20side%20sheet.jpg)

- [Material Design 3 modal side sheet](#material-design-3-modal-side-sheet)
  - [Features](#features)
  - [Usage](#usage)
  - [Example](#example)

# Material Design 3 modal side sheet
A Flutter package that provides a Material Design 3 side sheet as a general dialog with blur background.

Please check out the [official documentation](https://m3.material.io/components/side-sheets/overview) for more information on Material Design side sheet

## Features
- Custom header and body widgets.
- Option to add a back button and close button.
- Option to add confirm and cancel action buttons.
- Option to show/hide a divider between the body and action buttons.
- Customizable button text and tooltips.
- Option to dismiss the dialog by tapping outside of it.
- Blur background.
  
## Usage
To use this package, add `blurry_side_sheet` as a dependency in your pubspec.yaml file.

```dart
dependencies:
  blurry_side_sheet: ^0.0.1
```

## Example
```dart
await showModalSideSheet(
  context: context,
  header: 'Edit Profile',
  body: ProfileEditForm(), // Put your content widget here
  addBackIconButton: true,
  addActions: true,
  addDivider: true,
  confirmActionTitle: 'Save',
  cancelActionTitle: 'Cancel',
  confirmActionOnPressed: () {
    // Do something
  },

  // If null, Navigator.pop(context) will used
  cancelActionOnPressed: () {
    // Do something
  },
  sigma: 10,
);
```
Please check out the [full example](https://pub.dev/documentation/blurry_side_sheet/example) for more information on how to use this package.
