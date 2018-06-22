//
//  GJKeyboardNumPad.m
//  GJKeyBoard
//
//  Created by Simon on 15/5/10.
//  Copyright (c) 2015年 Simon. All rights reserved.
//

#import "GJKeyboardNumPad.h"
#import "UIImage+Addtions.h"

#define kNums   @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"]
#define kFuncs  @[@"⬅︎",@"完 成"]

@interface GJKeyboardNumPad ()

@end

@implementation GJKeyboardNumPad
@synthesize characterKeys,functionKeys,crtButton;

- (void)initPad{
    NSMutableArray *keys = [self randomSortKeyArray:kNums];
    [keys insertObject:kFuncs[1] atIndex:keys.count - 1];
    [keys addObject:kFuncs[0]];
    
    NSMutableArray * __block btns = [NSMutableArray array];
    NSMutableArray * __block funcbtns = [NSMutableArray array];
    [keys enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(idx % 3 * (SCREEN_SIZE.width - 2) / 3, STATE_HEIGHT + idx / 3 * KEYBOARD_HEIGHT / 4, (SCREEN_SIZE.width - 2) / 3, KEYBOARD_HEIGHT / 4)];
        [btn setUserInteractionEnabled:NO];
        [btn setBackgroundImage:[UIImage imageWithHexString:@"309fea"] forState:UIControlStateSelected];
        [btn setTitle:obj forState:UIControlStateNormal];
        [btn setTitle:obj forState:UIControlStateSelected];
        
        if([kNums containsObject:obj])
        {
            [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:30]];
            [btns addObject:btn];
        }
        else if ([kFuncs containsObject:obj])
        {
            [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
            [funcbtns addObject:btn];
        }
    }];
    
    self.characterKeys = btns;
    self.functionKeys = funcbtns;
}

- (void)touchBegin:(UIButton *)b type:(GJKeyboardButtonType)type{
    b.selected = YES;
    self.crtButton = b;
}

- (void)touchMove:(UIButton *)b type:(GJKeyboardButtonType)type{
    b.selected = YES;
    if(self.crtButton != b){
        self.crtButton.selected = NO;
        self.crtButton = b;
    }
}

- (void)touchEnd{
    for(UIButton *btn in self.characterKeys) btn.selected = NO;
    for(UIButton *btn in self.functionKeys) btn.selected = NO;
}

- (GJKeyFunction)touchEnd:(UIButton *)b{
    b.selected = NO;
    return GJKeyFunctionInsert;
}

- (GJKeyFunction)touchFunctionEnd:(UIButton *)b{
    b.selected = NO;
    if([b.titleLabel.text isEqualToString:@"完 成"]){
        return GJKeyFunctionReturn;
    }else if ([b.titleLabel.text isEqualToString:@"⬅︎"]){
        return GJKeyFunctionDelete;
    }
    return GJKeyFunctionNormal;
}

//随机排列键盘按键(洗牌算法)
-(NSMutableArray *)randomSortKeyArray:(NSArray *)keyArray{
    NSMutableArray *array = [NSMutableArray arrayWithArray:keyArray];
    for(int i = 0; i < array.count; i++){
        int value = arc4random() % (array.count - i) + i;
        [array exchangeObjectAtIndex:i withObjectAtIndex:value];
    }
    return array;
}


@end
