//
//  GJKeyboardProtocol.h
//  GJKeyBoard
//
//  Created by Yorke on 15/5/10.
//  Copyright (c) 2015年 wutongr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

#define SCREEN_SIZE       [UIScreen mainScreen].bounds.size
#define KEYBOARD_HEIGHT   216    
#define STATE_HEIGHT      30   //30x

typedef NS_ENUM(NSUInteger, GJKeyFunction) {
    GJKeyFunctionInsert = 1,
    GJKeyFunctionDelete,
    GJKeyFunctionNormal,
    GJKeyFunctionReturn,
    GJKeyFunctionUpdate
};

typedef NS_ENUM(NSUInteger, GJKeyboardButtonType) {
    GJKeyboardButtonTypeCharacterKey = 1,
    GJKeyboardButtonTypeFunctionKey
};

@protocol GJKeyboardProtocol <NSObject>

@property (nonatomic, strong) NSArray *characterKeys;
@property (nonatomic, strong) NSArray *functionKeys;
@property (nonatomic, strong) UIButton *crtButton;

- (void)initPad;

- (void)touchBegin:(UIButton *)b type:(GJKeyboardButtonType)type;
- (void)touchMove:(UIButton *)b type:(GJKeyboardButtonType)type;

- (void)touchEnd;
- (GJKeyFunction)touchEnd:(UIButton *)b;
- (GJKeyFunction)touchFunctionEnd:(UIButton *)b;

@end
