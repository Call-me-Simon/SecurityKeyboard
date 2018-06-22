//
//  GJKeyboardStockPad.m
//  GJKeyBoard
//
//  Created by Yorke on 15/5/10.
//  Copyright (c) 2015年 wutongr. All rights reserved.
//

#import "GJKeyboardStockPad.h"

@implementation GJKeyboardStockPad
@synthesize characterKeys,functionKeys,crtButton;

- (void)initPad{
    
}

- (void)touchBegin:(UIButton *)b type:(GJKeyboardButtonType)type{
    
}
- (void)touchMove:(UIButton *)b type:(GJKeyboardButtonType)type{
    
}

- (void)touchEnd{
    
}
- (GJKeyFunction)touchEnd:(UIButton *)b{
    return GJKeyFunctionInsert;
}
- (GJKeyFunction)touchFunctionEnd:(UIButton *)b{
    return GJKeyFunctionNormal;
}

@end
