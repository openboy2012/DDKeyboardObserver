//
//  UIView+KeyboardHandler.m
//  DDKeyboardHandler
//
//  Created by diaoshu on 15/4/23.
//  Copyright (c) 2015年 DDKit. All rights reserved.
//

#import "UIView+KeyboardObserver.h"
#import <objc/runtime.h>

@interface UIView()

@property (nonatomic, assign) CGRect keyboardViewRect;
@property (nonatomic, assign) CGRect originRectOfSelf;
@property (nonatomic, assign) BOOL isKeyboardShow;

@end

static char originRectOfSelfKey;
static char keyboardViewRectKey;
static char keyboardShowKey;

@implementation UIView (KeyboardHandler)


#pragma mark - runtime get&set Methods

- (void)setKeyboardViewRect:(CGRect)keyboardViewRect{
    objc_setAssociatedObject(self, &keyboardViewRectKey, [NSValue valueWithCGRect:keyboardViewRect], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGRect)keyboardViewRect{
    return [objc_getAssociatedObject(self, &keyboardViewRectKey) CGRectValue];
}

- (void)setIsKeyboardShow:(BOOL)isKeyboardShow{
    objc_setAssociatedObject(self, &keyboardShowKey, [NSNumber numberWithBool:isKeyboardShow], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isKeyboardShow{
    return [objc_getAssociatedObject(self, &keyboardShowKey) boolValue];
}

- (void)setOriginRectOfSelf:(CGRect)originRectOfSelf{
    objc_setAssociatedObject(self, &originRectOfSelfKey, [NSValue valueWithCGRect:originRectOfSelf], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGRect)originRectOfSelf{
    return [objc_getAssociatedObject(self, &originRectOfSelfKey) CGRectValue];
}

#pragma mark - Public Methods

- (void)addKeyboardObserver{
    self.originRectOfSelf = self.frame;
    [self registerKeyboardNotifications];
}

- (void)removeKeyboardObserver{
    [self removeKeyboardNotifications];
}

#pragma mark - Keyboad Notification Methods

- (void)registerKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)removeKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification{
    // get keyboard size and loctaion
    CGRect keyboardBounds;
    [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardBounds];
    NSNumber *duration = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // Need to translate the bounds to account for rotation.
    if(!CGRectEqualToRect(self.keyboardViewRect, keyboardBounds) || self.isKeyboardShow)
        self.keyboardViewRect = keyboardBounds;
    
    self.translatesAutoresizingMaskIntoConstraints = YES;
    
    // get a rect for the self's origin frame
    CGRect containerFrame = self.originRectOfSelf;
    if([self isKindOfClass:[UIScrollView class]]){
        containerFrame.size.height -= self.keyboardViewRect.size.height;
    }else{
        containerFrame.origin.y -= self.keyboardViewRect.size.height;
    }
    // animations settings
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
    // set views with new info
    self.frame = containerFrame;
    
    // commit animations
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)notification{
    NSNumber *duration = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];

    // animations settings
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    // set views with new info
    self.frame = self.originRectOfSelf;
    
    // commit animations
    [UIView commitAnimations];
    
    self.isKeyboardShow = NO;
    self.translatesAutoresizingMaskIntoConstraints = NO;
}


@end
