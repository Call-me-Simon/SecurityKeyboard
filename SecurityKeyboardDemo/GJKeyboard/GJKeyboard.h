//
//  GJKeyboard.h
//  GJKeyboard
//
//  Created by Yorke on 15/5/9.
//  Copyright (c) 2015年 wutongr. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GJKeyboardType) {
    GJKeyboardTypeNumKeyPad = 1,    //数字键盘
    GJKeyboardTypeCharKeyPad,       //英文键盘
    GJKeyboardTypeCardKeyPad        //身份证键盘
};

@interface GJKeyboard : UIView<UIInputViewAudioFeedback>

- (instancetype)init;

@property (nonatomic, strong) UIImageView *keyboardBackground;
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, assign) GJKeyboardType keyboardtype;
@property (nonatomic, strong) id<UITextInput> textView;

@end
