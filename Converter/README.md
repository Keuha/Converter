#  Converter App for PayPay

## How to run the project 

please open ContentWorkspace with Xcode to acces the project

the project is split in 3 targets 

- Converter (the app)
- ConverterUtility (utilities methods and extensions)
- ConverterUI (UI Components used within the app)

## Targets

Each target can be build.

Only Converter can be run on a device. minimum iOS version is iOS 16.0 

Converter target and ConverterUtility target both got unit tests. those unit tests are grouped together within Converter.testplan

when running unit test on Converter target, testplan is executed to run all unit test present within the workspace

## Technologies

the app is made using SwiftUI & Combine since no requirement mention usage of UIKit only.

## Dependencies 

for storage data purpose, Realm has been added to the project though SPM.

### others

- all landscape should be handle.
- a small customisation of the colors has been done for dark mode.
- currency full name depends on your device language

Hope you enjoyed reviewing the project and that it meets your requirement. I am looking forward to hearing from you ! 

Franck Petriz (フランック　ペットリズ)
