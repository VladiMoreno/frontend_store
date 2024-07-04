# frontend_store

## Autor
    Realizado por Vladimir Moreno

## Versions that I use
    Flutter version 3.19.5
    Dart version 3.3.3
    DevTools 2.31.1

## Tools that you need before to clone the repository
    1. You need to install dart -- https://dart.dev/get-dart or https://dart.dev/get-dart/archive to select the version
    2. After to install dart, you need to modify the PATH to add Dart. Read the guide -- https://dart.dev/get-dart
    3. Then you have to install flutter -- https://docs.flutter.dev/get-started/install/ or https://docs.flutter.dev/release/archive?tab=windows
    4. Also, you have to modify the PATH to add Flutter. Read the guide -- https://docs.flutter.dev/get-started/install/
    5. You have to install and configure android studio for testing the app in mobile or tablets devices (not optional)
    6. Install chrome
    7. Finally run this command in your console and verify that all it's ok
    command to run : flutter doctor -v

    **you can use visual studio code or android studio to work**

## Run this commands after cloning this repository
    flutter pub get ---------------> to get all packages that this project need

    flutter doctor -v -------------> to review that all things are ok

## Running Locally
    flutter run -d "id_of_the_device"

    for example if you want to run this project in the web
    the command will be like this:

    flutter run -d chrome

    where chrome its the id of my device, to get the id please run flutter doctor -v

## To test
    after to run the project u have to duplicate the browser tab and go to "project:port"/home
    to watch the products and the barcode to scan the barcode after that you can "login" with seller profile
    and make a "purchase" then you can go to admins profile and management the products, make a purcharse and watch the purchases that exist in the database