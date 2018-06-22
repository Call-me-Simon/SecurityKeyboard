//
//  GJKeyboard.h
//  GJKeyboard
//
//  Created by Simon on 15/5/9.
//  Copyright (c) 2015年 Simon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GJKeyboardType) {
    GJKeyboardTypeNumKeyPad = 1,    //数字键盘
    GJKeyboardTypeCharKeyPad,       //英文键盘
    GJKeyboardTypeCardKeyPad        //身份证键盘
};

@interface GJKeyboard : UIView<UIInputViewAudioFeedback>

- (instancetype)init;

@property (nonatomic, strong) UIImageView *keyboardBackground;  //背景图片
@property (nonatomic, strong) UILabel *stateLabel;              //顶部提示文字
@property (nonatomic, assign) GJKeyboardType keyboardtype;      //安全键盘类型
@property (nonatomic, strong) id<UITextInput> textView;         //键盘对象（传入UITextField或UITextView对象）

@end
