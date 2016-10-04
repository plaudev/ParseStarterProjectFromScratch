# 1 Uber App - A Parse Starter Project From Scratch

Patrick Lau @plaudev 2016-09-13

Initiating project without relying on a starter project or 3rd party guides. For use with Rob Percival's iOS 9 Developer Course Lecture #170 Uber App. Instructions along with initial Xcode files you need before any Uber specific code is implemented are provided herein. You just need to insert & link to the required frameworks & libraries as detailed below.


## 1.1 Creating Parse Server on Heroku

https://devcenter.heroku.com/articles/deploying-a-parse-server-to-heroku

### 1.1.1 Deploy To Heroku

Click purple "Deploy To Heroku" button & follow instructions to create a Parse app on Heroku. Specify a unique application name. A free Heroku account is required.

#### 1.1.1.1 Heroku Environment Variables

These environment variables must be set up:

* appID
* masterKey
* server URL (must be in the form "https://__your_app_name__.herokuapp.com/parse")
* mongoDB URI
* database URI (set same as mongoDB URI)

#### 1.1.1.2 Test Parse Server on Heroku

From Terminal prompt ("$"), enter:

$ curl -X POST -H "X-Parse-Application-Id: __your_appID__" -H "Content-Type: application/json" -d '{}' __your_server_URL__/functions/hello

If your Parse Server is deployed successfully on Heroku, you should get the result:

{"result":"Hi"}

### 1.1.2 Install Parse Dashborad

TBC

### 1.1.3 Set Up Push Notification

https://github.com/plaudev/ParseHerokuPushNotification


## 1.2 Installing Parse SDK Into Existing (or New) Project

Create a new single view Xcode project then insert the Parse components.

Note: https://parse.com/apps/quickstart#parse_data/mobile/ios/swift/existing

### 1.2.1 Download & unzip the SDK

Make sure you are using the latest version of Xcode (7.0+) and targeting iOS 7.0 or higher.

Download the latest iOS starter project as a reference. 

Note: Above link (https://parse.com/downloads/ios/parse-library/latest
) downloads v1.12.0 but latest version should be v.1.14.2.

### 1.2.2 Add the SDKs to your app

Drag the Parse.framework and Bolts.framework you downloaded into your Xcode project folder target. 

Make sure the "Copy items to destination's group folder" checkbox is checked.

#### 1.2.2.1 Adding ParseUI.framework

For the Snapchat clone (Lecture #209), you will need to use PFImageView() which is found in ParseUI.framework. The latest copy I've managed to find of this framework is found in the link mentioned in #1.2.1, ie v1.12.0. Unzip this library & drag ParseUI.framework into your Xcode project (select "Copy items to destination").

This ParseUI.framework is written in Obj-C which means you will need a bridging header to import it into your Swift project. The easiest way to create a bridging header is to do the following in Xcode:

* File->New->File
* Select iOs->Source->Objective-C file
* Name this file (extension .m) anything you want (we will discard it once bridging header is created)
* When asked "Would you like to configure an Objective-C bridging header?", select yes
* Once the bridging header is created (filename is likely yourAppName-Bridging-Header.h), you can delete the Objective-C file just created
* Insert "#import <ParseUI/ParseUI.h>" into the bridging header file

Note: https://www.raywenderlich.com/98831/parse-tutorial-getting-started-web-backends

### 1.2.3 Add the dependencies

Click on Targets → Your app name → and then the 'Build Phases' tab.

Expand 'Link Binary With Libraries' as shown.

Click the + button in the bottom left of the 'Link Binary With Libraries' section and add the following libraries:

* AudioToolbox.framework
* CFNetwork.framework
* CoreGraphics.framework
* CoreLocation.framework
* QuartzCore.framework
* Security.framework
* StoreKit.framework
* SystemConfiguration.framework
* libz.tbd
* libsqlite3.tbd

Note: This is a comprehensive list of dependencies for a typical app. You may be able to omit some of these if you are not using the -ObjC linker flag or if you do not plan to implement Location Services or In-App Purchases, for example.

Note: http://stackoverflow.com/a/31636570/1827488

#### 1.2.3.1 Libraries Needed for Uber App

* AudioToolbox.framework
* SystemConfiguration.framework
* libsqlite3.tbd

#### 1.2.3.4 Libraries Needed for Facebook Login

Please see relevant Parse github.

### 1.2.4 Other installation options

Did not test these methods.

#### 1.2.4.1 CocoaPods
Add pod 'Parse' to your podfile and run pod install.

#### 1.2.4.2 Compiling for yourself
If you want to manually compile the SDK, you can find the source code on GitHub.

### 1.2.5 Prepare Project Files

#### 1.2.5.1 AppDelegate.swift

Add `import Parse`.

Copy code from starter project into corresponding functions in your own Xcode project.

Insert your own Heroku environment variable values into these variables:

* $0.applicationId
* $0.server

Set `$0.clientKey = ""`.

#### 1.2.5.2 ViewController.swift

Add `import Parse`.

Insert the following function above `class ViewController: UIViewController { ... }`:

    func testParseConnection(table: String, column: String, value: String) {
        let testObject = PFObject(className: table)
        testObject[column] = value
        testObject.saveInBackgroundWithBlock { (success, error) -> Void in
            if error != nil {
                print("testParseConnection(): \(error)")
            } else {
                print("testParseConnection(): object has been saved")
            }
        }
    }

Insert the following line in `viewDidLoad()`:

`testParseConnection("test", column: "data", value: "hello ooohber")`

Change parameter values if desired.

#### 1.2.5.3 Test Your iOS App

Run your app on simulator. Check on Parse Dashboard that the specified entry is inserted into your Parse database.

