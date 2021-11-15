# COMP523 Cafe Reservation
The COMP523 cafe reservation app was created to help users be able to reserve seats in Chapel Hill cafes while also assisting business owners maximize seating and business in a comprehensive manner.

## Getting Started
### Developer Preqrequisites
+ macOS device in order to run and build the application
+ macOS installation of Flutter SDK:
  + `git clone https://github.com/flutter/flutter.git -b stable`
  + Update your path for Flutter: `export PATH="$PATH:[PATH_OF_FLUTTER_GIT_DIRECTORY]/bin`
+ A working installation of Xcode:
  + Download from the web or app store
  + Run the following commands to configure Xcode CLI tools and sign licenses: 
```
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch
sudo xcodebuild -license
```
### Installation and Running the App Locally
Once the prerequisites have been installed on the local machine, clone the repository and change into the working app directory as follows:
```
git clone https://github.com/{user}/comp523-cafe-reservation.git
cd comp523-cafe-reservation/cafe_reservation/
```
If Xcode has been installed and is running properly, then you can open the iOS simulator and run the app using:
```
open -a Simulator
flutter run
```
### Warranty
These instructions were last tested and verified on November 10, 2021 by Yang Chen on a Macbook Air M1 Chip machine.
## Testing
In order to run the test suite and view test results, first install the `lcov` package using Homebrew:
```
brew install lcov
```
`lcov` is used to compile test results into a `.lcov` file while can be converted into a visual graphic compiled into an HTML file. Next, run the next two commands to generate a test coverage report along with its corresponding HTML graphic:
```
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```
## Deployment
Currently, the production system takes place on TestFlight, an Apple Developer program feature designed to allow internal and external testing of app beta builds. In order to get access to TestFlight management, email [yangrc.chen@gmail.com](mailto:yangrc.chen@gmail.com) with a request and list of reasons for management of TestFlight builds.

Continous integration is not enabled for the project at present.
## Technologies Used
+ Flutter SDK
+ Xcode
+ Firebase (Firestore, Authentication)
The architecture diagrams describing high-level interactions between the technologies we use can be found at our [project website](https://tarheels.live/carolinacafereserve/application-architecture/).
## Authors
The major authors have been Yang Chen, Mohammad Haveliwala, Ammar Puri.
## License
## Acknowledgements
We would like to thank John Lim and Christopher Gsell, our clients, for their cooperation and friendly work ethic in the process of developing this application. We would also like to thank Stacey Wright, our mentor, for her insightful advice on project management, tech career strategies, and working experiences.
