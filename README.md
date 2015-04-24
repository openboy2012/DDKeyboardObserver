# DDKeyboardObserver
a fast kit handle the keyboard cover issue

##Effects
<img src="http://ipa-download.qiniudn.com/KeyboardObserver.gif" width="321"/>
<img src="http://ipa-download.qiniudn.com/KeyboardObserver2.gif" width="321"/>

##Installation

[![Version](http://cocoapod-badges.herokuapp.com/v/DDKeyboardObserver/badge.png)](http://cocoapod-badges.herokuapp.com/v/DDKeyboardObserver) [![Platform](http://cocoapod-badges.herokuapp.com/v/DDKeyboardObserver/badge.png)](http://cocoapod-badges.herokuapp.com/v/DDKeyboardObserver)   
DDKeyboardObserver is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

    pod 'DDKeyboardObserver'
Alternatively, you can just drag the files from `DDKeyboardObserver/KeyboardObserver` into your own project. 

## Usage

import `UIView+DDKeyboardObserver.h` in your project    

for example:
```

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.carryView.contentSize = CGSizeMake(0, self.carryView.frame.size.height);
    
    // handle the toolView;
    [self.toolView addKeyboardObserver];
    
    // also handle the carry view;
    [self.carryView addKeyboardObserver];
}

```

you can see more infomation in the example project.


## Requirements

- Xcode 6.3
- iOS 6.0

## Author

DeJohn Dong, dongjia_9251@126.com

## License

DDKeyboardObserver is available under the MIT license. See the LICENSE file for more info.


