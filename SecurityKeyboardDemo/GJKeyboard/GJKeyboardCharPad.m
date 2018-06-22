//
//  GJKeyboardCharPad.m
//  GJKeyBoard
//
//  Created by Simon on 15/5/10.
//  Copyright (c) 2015年 Simon. All rights reserved.
//

#import "GJKeyboardCharPad.h"

typedef NS_ENUM(NSUInteger, GJKeyboardViewImageKind) {
    GJKeyboardViewImageKindLeft = 0,
    GJKeyboardViewImageKindInner,
    GJKeyboardViewImageKindRight,
    GJKeyboardViewImageKindMax
};

typedef NS_ENUM(NSUInteger, GJKeyboardCharState) {
    GJKeyboardCharStateNormal = 1,
    GJKeyboardCharStateUpper,
    GJKeyboardCharStateNum,
    GJKeyboardCharStateSymbol
};

#define kChars    @[@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P",    \
                    @"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L",         \
                    @"Z",@"X",@"C",@"V",@"B",@"N",@"M"]

#define kchars    @[@"q",@"w",@"e",@"r",@"t",@"y",@"u",@"i",@"o",@"p",    \
                    @"a",@"s",@"d",@"f",@"g",@"h",@"j",@"k",@"l",         \
                    @"z",@"x",@"c",@"v",@"b",@"n",@"m"]

#define kSymbol1  @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",    \
                    @"-",@"/",@":",@";",@"(",@")",@"$",@"&",@"@",@"\"",   \
                    @".",@",",@"?",@"!",@"'"]

#define kSymbol2  @[@"[",@"]",@"{",@"}",@"#",@"%",@"^",@"*",@"+",@"=",    \
                    @"_",@"\\",@"|",@"~",@"<",@">",@"€",@"£",@"¥",@"・",  \
                    @".",@",",@"?",@"!",@"'"]

#define kFuncs   @[@"⬆︎",@"#+=",@"⬅︎",@"#+123",@"ABC",@"空 格",@"完 成"]

@interface GJKeyboardCharPad ()

@property (nonatomic, assign, getter=isSymbolPad) BOOL symbolPad;//英文、数字符号切换
@property (nonatomic, assign, getter=isShifted)   BOOL shifted;//大小写切换、数字符号切换

@end

@implementation GJKeyboardCharPad
@synthesize characterKeys,functionKeys,crtButton;

- (void)initPad{
    [self createPadWithType:GJKeyboardCharStateNormal];
    
}

- (void)createPadWithType:(GJKeyboardCharState)state{
    NSMutableArray * __block btns = [NSMutableArray array];
    NSMutableArray * __block funcbtns = [NSMutableArray array];
    
    //两种布局都生成
    //第一页字母
    
    for (int i = 0; i < 26; i++) {
        
        if(i < 10){//1.第一排
            UIButton *bt = [[UIButton alloc]initWithFrame:CGRectMake(5 + (SCREEN_SIZE.width - 10) / 10 * i, STATE_HEIGHT, (SCREEN_SIZE.width - 10) / 10, 44)];
            [bt setUserInteractionEnabled:NO];
            bt.layer.borderColor = [UIColor blackColor].CGColor;
            bt.layer.borderWidth = 1.0f;
            [bt setTitle:kchars[i] forState:UIControlStateNormal];
            [btns addObject:bt];
        }else if (i < 19){//2.第二排
            UIButton *bt = [[UIButton alloc]initWithFrame:CGRectMake(20 + (SCREEN_SIZE.width - 40) / 9 * (i - 10), STATE_HEIGHT + 44 + 10, (SCREEN_SIZE.width - 40) / 9, 44)];
            [bt setUserInteractionEnabled:NO];
            bt.layer.borderColor = [UIColor blackColor].CGColor;
            bt.layer.borderWidth = 1.0f;
            [bt setTitle:kchars[i] forState:UIControlStateNormal];
            [btns addObject:bt];
        }else{//3.第三排
            UIButton *bt = [[UIButton alloc]initWithFrame:CGRectMake(20 + (SCREEN_SIZE.width  - 40) / 9 * (i - 18), STATE_HEIGHT + (44 + 10) * 2, (SCREEN_SIZE.width - 40) / 9, 44)];
            [bt setUserInteractionEnabled:NO];
            bt.layer.borderColor = [UIColor blackColor].CGColor;
            bt.layer.borderWidth = 1.0f;
            [bt setTitle:kchars[i] forState:UIControlStateNormal];
            [btns addObject:bt];
        }
       
    }
    
    //第二页数字符号（隐藏）
    for(int i = 0; i < 25; i++){
        if(i < 10){//1.第一排
            UIButton *bt = [[UIButton alloc]initWithFrame:CGRectMake(5 + (SCREEN_SIZE.width - 10) / 10 * i, STATE_HEIGHT, (SCREEN_SIZE.width - 10) / 10, 44)];
            [bt setUserInteractionEnabled:NO];
            bt.hidden = YES;
            bt.layer.borderColor = [UIColor blackColor].CGColor;
            bt.layer.borderWidth = 1.0f;
            [bt setTitle:kSymbol1[i] forState:UIControlStateNormal];
            [btns addObject:bt];
        }else if (i < 20){//2.第二排
            UIButton *bt = [[UIButton alloc]initWithFrame:CGRectMake(5 + (SCREEN_SIZE.width - 10) / 10 * (i - 10), STATE_HEIGHT + 44 + 10, (SCREEN_SIZE.width - 10) / 10, 44)];
            [bt setUserInteractionEnabled:NO];
            bt.hidden = YES;
            bt.layer.borderColor = [UIColor blackColor].CGColor;
            bt.layer.borderWidth = 1.0f;
            [bt setTitle:kSymbol1[i] forState:UIControlStateNormal];
            [btns addObject:bt];
        }else{//3.第三排
            UIButton *bt = [[UIButton alloc]initWithFrame:CGRectMake(20 + (SCREEN_SIZE.width  - 40) / 9 + (SCREEN_SIZE.width - 40) / 9 * 7 / 5 * (i - 20), STATE_HEIGHT + (44 + 10) * 2, (SCREEN_SIZE.width - 40) / 9 * 7 / 5, 44)];
            [bt setUserInteractionEnabled:NO];
            bt.hidden = YES;
            bt.layer.borderColor = [UIColor blackColor].CGColor;
            bt.layer.borderWidth = 1.0f;
            [bt setTitle:kSymbol1[i] forState:UIControlStateNormal];
            [btns addObject:bt];
        }
    }
    
    //第四排固定位置
    //1.shift
    UIButton *shiftbt = [[UIButton alloc]initWithFrame:CGRectMake(5, STATE_HEIGHT + (44 + 10) * 2, (SCREEN_SIZE.width - 40) / 9 + 10, 44)];
    [shiftbt setUserInteractionEnabled:NO];
    shiftbt.layer.borderColor = [UIColor blueColor].CGColor;
    shiftbt.layer.borderWidth = 1.0f;
    [shiftbt setTitle:@"⬆︎" forState:UIControlStateNormal];
    [funcbtns addObject:shiftbt];
    //2.delete
    UIButton *deletebt = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_SIZE.width - 5 - (SCREEN_SIZE.width - 40) / 9 - 10, STATE_HEIGHT + (44 + 10) * 2, (SCREEN_SIZE.width - 40) / 9 + 10, 44)];
    [deletebt setUserInteractionEnabled:NO];
    deletebt.layer.borderColor = [UIColor blueColor].CGColor;
    deletebt.layer.borderWidth = 1.0f;
    [deletebt setTitle:@"⬅︎" forState:UIControlStateNormal];
    [funcbtns addObject:deletebt];
    //3.#+123
    UIButton *ABCbt = [[UIButton alloc]initWithFrame:CGRectMake(5, STATE_HEIGHT + (44 + 10) * 3, 80, 44)];
    [ABCbt setUserInteractionEnabled:NO];
    ABCbt.layer.borderColor = [UIColor blueColor].CGColor;
    ABCbt.layer.borderWidth = 1.0f;
    [ABCbt setTitle:@"#+123" forState:UIControlStateNormal];
    [funcbtns addObject:ABCbt];
    //4.空格
    UIButton *blankbt = [[UIButton alloc]initWithFrame:CGRectMake(5 + 80, STATE_HEIGHT + (44 + 10) * 3, SCREEN_SIZE.width - 160 - 10, 44)];
    [blankbt setUserInteractionEnabled:NO];
    blankbt.layer.borderColor = [UIColor blueColor].CGColor;
    blankbt.layer.borderWidth = 1.0f;
    [blankbt setTitle:@"空 格" forState:UIControlStateNormal];
    [funcbtns addObject:blankbt];
    //5.完成
    UIButton *OKbt = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_SIZE.width - 5 - 80, STATE_HEIGHT + (44 + 10) * 3, 80, 44)];
    [OKbt setUserInteractionEnabled:NO];
    OKbt.layer.borderColor = [UIColor blueColor].CGColor;
    OKbt.layer.borderWidth = 1.0f;
    [OKbt setTitle:@"完 成" forState:UIControlStateNormal];
    [funcbtns addObject:OKbt];
    
    self.characterKeys = btns;
    self.functionKeys = funcbtns;
}

- (void)refrashPad:(GJKeyboardCharState)state{
    switch (state) {
        case GJKeyboardCharStateNormal:
        {
            [self.characterKeys enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
                if([kChars containsObject:btn.titleLabel.text]){
                    NSString *title = [btn.titleLabel.text lowercaseString];
                    [btn setTitle:title forState:UIControlStateNormal];
                }
            }];
        }
            break;
        case GJKeyboardCharStateUpper:
        {
            [self.characterKeys enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
                if([kchars containsObject:btn.titleLabel.text]){
                    NSString *title = [btn.titleLabel.text uppercaseString];
                    [btn setTitle:title forState:UIControlStateNormal];
                }
            }];
        }
            break;
        case GJKeyboardCharStateSymbol:
        {
            [self.characterKeys enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
                if([kSymbol1 containsObject:btn.titleLabel.text]){
                    NSInteger index = [kSymbol1 indexOfObject:btn.titleLabel.text];
                    [btn setTitle:kSymbol2[index] forState:UIControlStateNormal];
                }
            }];
        }
            break;
        case GJKeyboardCharStateNum:
        {
            [self.characterKeys enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
                if([kSymbol2 containsObject:btn.titleLabel.text]){
                    NSInteger index = [kSymbol2 indexOfObject:btn.titleLabel.text];
                    [btn setTitle:kSymbol1[index] forState:UIControlStateNormal];
                }
            }];
        }
            break;
    }
}


- (void)touchBegin:(UIButton *)b type:(GJKeyboardButtonType)type{
    if(type == GJKeyboardButtonTypeCharacterKey){
        [self addPopupToButton:b];
    }
    
    self.crtButton = b;
}

- (void)touchMove:(UIButton *)b type:(GJKeyboardButtonType)type{
    if(self.crtButton != b && type == GJKeyboardButtonTypeCharacterKey){
        //移除imageview
        if ([self.crtButton subviews].count > 1) {
            [[[self.crtButton subviews] objectAtIndex:1] removeFromSuperview];
        }
        //添加imageview
        [self addPopupToButton:b];
        
        self.crtButton = b;
    }
}

- (void)touchEnd{
    for(UIButton *btn in self.characterKeys){
        if ([btn subviews].count > 1) {
            [[[btn subviews] objectAtIndex:1] removeFromSuperview];
        }
    }
    
    for(UIButton *btn in self.functionKeys){
        if ([btn subviews].count > 1) {
            [[[btn subviews] objectAtIndex:1] removeFromSuperview];
        }
    }
}

- (GJKeyFunction)touchEnd:(UIButton *)b{
    //移除imageview
    if ([b subviews].count > 1) {
        [[[b subviews] objectAtIndex:1] removeFromSuperview];
    }
    return GJKeyFunctionInsert;
}

- (GJKeyFunction)touchFunctionEnd:(UIButton *)b{
    if([b.titleLabel.text isEqualToString:@"⬆︎"]){
        _shifted = !_shifted;
        if(_symbolPad && _shifted){
            [self refrashPad:GJKeyboardCharStateSymbol];
        }else if (_symbolPad && !_shifted){
            [self refrashPad:GJKeyboardCharStateNum];
        }else if (!_symbolPad && _shifted){
            [self refrashPad:GJKeyboardCharStateUpper];
        }else if (!_symbolPad && !_shifted){
            [self refrashPad:GJKeyboardCharStateNormal];
        }
    }else if ([b.titleLabel.text isEqualToString:@"⬅︎"]){
        return GJKeyFunctionDelete;
    }else if ([b.titleLabel.text isEqualToString:@"#+123"]){
        _symbolPad = YES;
        [b setTitle:@"ABC" forState:UIControlStateNormal];
        [self.characterKeys enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
            btn.hidden = !btn.hidden;
        }];
    }else if ([b.titleLabel.text isEqualToString:@"ABC"]){
        _symbolPad = NO;
        [b setTitle:@"#+123" forState:UIControlStateNormal];
        [self.characterKeys enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
            btn.hidden = !btn.hidden;
        }];
    }else if ([b.titleLabel.text isEqualToString:@"空 格"]){
        return GJKeyFunctionInsert;
    }else if ([b.titleLabel.text isEqualToString:@"完 成"]){
        return GJKeyFunctionReturn;
    }
    return GJKeyFunctionNormal;
}

#pragma mark -

- (void)addPopupToButton:(UIButton *)b {
    UIImageView *keyPop = nil;
    UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 52, 60)];
    
    if (b == [self.characterKeys objectAtIndex:0]) {
        keyPop = [[UIImageView alloc] initWithImage:[self createKeytopImageWithKind:GJKeyboardViewImageKindRight]];
        keyPop.frame = CGRectMake(-10, -70, keyPop.frame.size.width, keyPop.frame.size.height);
    }
    else if (b == [self.characterKeys objectAtIndex:9]) {
        keyPop = [[UIImageView alloc] initWithImage:[self createKeytopImageWithKind:GJKeyboardViewImageKindLeft]];
        keyPop.frame = CGRectMake(-32, -70, keyPop.frame.size.width, keyPop.frame.size.height);
    }
    else {
        keyPop = [[UIImageView alloc] initWithImage:[self createKeytopImageWithKind:GJKeyboardViewImageKindInner]];
        keyPop.frame = CGRectMake(-(keyPop.frame.size.width / 2 - b.frame.size.width / 2), -70, keyPop.frame.size.width, keyPop.frame.size.height);
    }
    
    [text setFont:[UIFont systemFontOfSize:44]];
    
    [text setTextAlignment:NSTextAlignmentCenter];
    [text setBackgroundColor:[UIColor clearColor]];
    [text setAdjustsFontSizeToFitWidth:YES];
    [text setText:b.titleLabel.text];
    
    keyPop.layer.shadowColor = [UIColor colorWithWhite:0.1 alpha:1.0].CGColor;
    keyPop.layer.shadowOffset = CGSizeMake(0, 2.0);
    keyPop.layer.shadowOpacity = 0.30;
    keyPop.layer.shadowRadius = 3.0;
    keyPop.clipsToBounds = NO;
    
    [keyPop addSubview:text];
    [b addSubview:keyPop];
}


#define __UPPER_WIDTH   (52.0 * [[UIScreen mainScreen] scale])
#define __LOWER_WIDTH   (24.0 * [[UIScreen mainScreen] scale])

#define __PAN_UPPER_RADIUS  (10.0 * [[UIScreen mainScreen] scale])
#define __PAN_LOWER_RADIUS  (5.0 * [[UIScreen mainScreen] scale])

#define __PAN_UPPDER_WIDTH   (__UPPER_WIDTH-__PAN_UPPER_RADIUS*2)
#define __PAN_UPPER_HEIGHT    (52.0 * [[UIScreen mainScreen] scale])

#define __PAN_LOWER_WIDTH     (__LOWER_WIDTH-__PAN_LOWER_RADIUS*2)
#define __PAN_LOWER_HEIGHT    (47.0 * [[UIScreen mainScreen] scale])

#define __PAN_UL_WIDTH        ((__UPPER_WIDTH-__LOWER_WIDTH)/2)

#define __PAN_MIDDLE_HEIGHT    (2.0 * [[UIScreen mainScreen] scale])

#define __PAN_CURVE_SIZE      (10.0 * [[UIScreen mainScreen] scale])

#define __PADDING_X     (15 * [[UIScreen mainScreen] scale])
#define __PADDING_Y     (10 * [[UIScreen mainScreen] scale])
#define __WIDTH   (__UPPER_WIDTH + __PADDING_X*2)
#define __HEIGHT   (__PAN_UPPER_HEIGHT + __PAN_MIDDLE_HEIGHT + __PAN_LOWER_HEIGHT + __PADDING_Y*2)


#define __OFFSET_X    -25 * [[UIScreen mainScreen] scale])
#define __OFFSET_Y    59 * [[UIScreen mainScreen] scale])


- (UIImage *)createKeytopImageWithKind:(GJKeyboardViewImageKind)kind
{
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPoint p = CGPointMake(__PADDING_X, __PADDING_Y);
    CGPoint p1 = CGPointZero;
    CGPoint p2 = CGPointZero;
    
    p.x += __PAN_UPPER_RADIUS;
    CGPathMoveToPoint(path, NULL, p.x, p.y);
    
    p.x += __PAN_UPPDER_WIDTH;
    CGPathAddLineToPoint(path, NULL, p.x, p.y);
    
    p.y += __PAN_UPPER_RADIUS;
    CGPathAddArc(path, NULL,
                 p.x, p.y,
                 __PAN_UPPER_RADIUS,
                 3.0*M_PI/2.0,
                 4.0*M_PI/2.0,
                 false);
    
    p.x += __PAN_UPPER_RADIUS;
    p.y += __PAN_UPPER_HEIGHT - __PAN_UPPER_RADIUS - __PAN_CURVE_SIZE;
    CGPathAddLineToPoint(path, NULL, p.x, p.y);
    
    p1 = CGPointMake(p.x, p.y + __PAN_CURVE_SIZE);
    switch (kind) {
        case GJKeyboardViewImageKindLeft:
            p.x -= __PAN_UL_WIDTH*2;
            break;
            
        case GJKeyboardViewImageKindInner:
            p.x -= __PAN_UL_WIDTH;
            break;
            
        case GJKeyboardViewImageKindRight:
            break;
            
        case GJKeyboardViewImageKindMax:
            break;
    }
    
    p.y += __PAN_MIDDLE_HEIGHT + __PAN_CURVE_SIZE*2;
    p2 = CGPointMake(p.x, p.y - __PAN_CURVE_SIZE);
    CGPathAddCurveToPoint(path, NULL,
                          p1.x, p1.y,
                          p2.x, p2.y,
                          p.x, p.y);
    
    p.y += __PAN_LOWER_HEIGHT - __PAN_CURVE_SIZE - __PAN_LOWER_RADIUS;
    CGPathAddLineToPoint(path, NULL, p.x, p.y);
    
    p.x -= __PAN_LOWER_RADIUS;
    CGPathAddArc(path, NULL,
                 p.x, p.y,
                 __PAN_LOWER_RADIUS,
                 4.0*M_PI/2.0,
                 1.0*M_PI/2.0,
                 false);
    
    p.x -= __PAN_LOWER_WIDTH;
    p.y += __PAN_LOWER_RADIUS;
    CGPathAddLineToPoint(path, NULL, p.x, p.y);
    
    p.y -= __PAN_LOWER_RADIUS;
    CGPathAddArc(path, NULL,
                 p.x, p.y,
                 __PAN_LOWER_RADIUS,
                 1.0*M_PI/2.0,
                 2.0*M_PI/2.0,
                 false);
    
    p.x -= __PAN_LOWER_RADIUS;
    p.y -= __PAN_LOWER_HEIGHT - __PAN_LOWER_RADIUS - __PAN_CURVE_SIZE;
    CGPathAddLineToPoint(path, NULL, p.x, p.y);
    
    p1 = CGPointMake(p.x, p.y - __PAN_CURVE_SIZE);
    
    switch (kind) {
        case GJKeyboardViewImageKindLeft:
            break;
            
        case GJKeyboardViewImageKindInner:
            p.x -= __PAN_UL_WIDTH;
            break;
            
        case GJKeyboardViewImageKindRight:
            p.x -= __PAN_UL_WIDTH*2;
            break;
            
        case GJKeyboardViewImageKindMax:
            break;
    }
    
    p.y -= __PAN_MIDDLE_HEIGHT + __PAN_CURVE_SIZE*2;
    p2 = CGPointMake(p.x, p.y + __PAN_CURVE_SIZE);
    CGPathAddCurveToPoint(path, NULL,
                          p1.x, p1.y,
                          p2.x, p2.y,
                          p.x, p.y);
    
    p.y -= __PAN_UPPER_HEIGHT - __PAN_UPPER_RADIUS - __PAN_CURVE_SIZE;
    CGPathAddLineToPoint(path, NULL, p.x, p.y);
    
    p.x += __PAN_UPPER_RADIUS;
    CGPathAddArc(path, NULL,
                 p.x, p.y,
                 __PAN_UPPER_RADIUS,
                 2.0*M_PI/2.0,
                 3.0*M_PI/2.0,
                 false);
    //----
    CGContextRef context;
    UIGraphicsBeginImageContext(CGSizeMake(__WIDTH,
                                           __HEIGHT));
    context = UIGraphicsGetCurrentContext();
    
    switch (kind) {
        case GJKeyboardViewImageKindLeft:
            CGContextTranslateCTM(context, 6.0, __HEIGHT);
            break;
            
        case GJKeyboardViewImageKindInner:
            CGContextTranslateCTM(context, 0.0, __HEIGHT);
            break;
            
        case GJKeyboardViewImageKindRight:
            CGContextTranslateCTM(context, -6.0, __HEIGHT);
            break;
            
        case GJKeyboardViewImageKindMax:
            break;
    }
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextAddPath(context, path);
    CGContextClip(context);
    
    //----
    
    CGRect frame = CGPathGetBoundingBox(path);
    CGContextSetFillColorWithColor(context, [[UIColor colorWithRed:0.973 green:0.976 blue:0.976 alpha:1.000] CGColor]);
    CGContextFillRect(context, frame);
    
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    
    UIImage * image = [UIImage imageWithCGImage:imageRef scale:[[UIScreen mainScreen] scale] orientation:UIImageOrientationDown];
    CGImageRelease(imageRef);
    
    UIGraphicsEndImageContext();
    
    
    CFRelease(path);
    
    return image;
}


@end
