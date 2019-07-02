# LTFPS


## Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like AFNetworking in your projects. See the ["Getting Started" guide for more information](https://github.com/AFNetworking/AFNetworking/wiki/Getting-Started-with-AFNetworking). You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 0.39.0+ is required to build AFNetworking 3.0.0+.

#### Podfile

To integrate AFNetworking into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

target 'TargetName' do
pod 'LTFPS', '~> 1.0'
end
```

Then, run the following command:

```bash
$ pod install
```
## how to use
you can start LTFPS by write a line code in monted `didFinishLaunchingWithOptions` with `Appdelegate`class like this
``` objc
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
#if DEBUG
    LTFPS.share.enable = YES;
#endif
    return YES;
}
```

<image src="https://raw.githubusercontent.com/LTOVEM/LTFPS/master/screenimage.png" width=50% alt="screen"/>
