//
//  UIView+KeyboardHandler.h
//  DDKeyboardHandler
//
//  Created by diaoshu on 15/4/23.
//  Copyright (c) 2015年 DDKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (KeyboardObserver)

/**
 *  add the keyboard observer on self,
 *  please add the method in 'viewDidAppear' method
 */
- (void)addKeyboardObserver;

/**
 *  remove the keyboard observer on self
 *  please add the method in 'viewDidDisappear' method
 */
- (void)removeKeyboardObserver;

@end
