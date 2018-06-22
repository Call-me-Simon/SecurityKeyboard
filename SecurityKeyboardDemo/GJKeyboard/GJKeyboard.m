//
//  GJKeyboard.m
//  GJKeyboard
//
//  Created by Yorke on 15/5/9.
//  Copyright (c) 2015年 wutongr. All rights reserved.
//

#import "GJKeyboard.h"
#import "GJKeyboardProtocol.h"
#import "GJKeyboardCharPad.h"
#import "GJKeyboardNumPad.h"
#import "GJKeyBoardCardPad.h"
#import "UIImage+Addtions.h"

//#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
//#warning GJKeyboard support iOS7 and later only
//#endif

@interface GJKeyboard ()

@property (nonatomic, strong) id<GJKeyboardProtocol> keyboard;

@property (nonatomic, strong) UIImage *defNumImage;
@property (nonatomic, strong) UIImage *defCharImage;

@end

@implementation GJKeyboard

#pragma mark -

- (instancetype)init{
    if(self = [super init]){
        self.frame = CGRectMake(0, 0, SCREEN_SIZE.width, KEYBOARD_HEIGHT + STATE_HEIGHT);
        [self setUp];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setUp];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        [self setUp];
    }
    return self;
}

#pragma mark -

- (void)setUp{
    //初始
    if(!_keyboardtype){
        _keyboardtype = GJKeyboardTypeNumKeyPad;
        _keyboard = [[GJKeyboardNumPad alloc]init];
    }
    //清空
    for(UIView *view in self.subviews) [view removeFromSuperview];
    //构造
    
    [self addSubview:self.keyboardBackground];
    [self addSubview:self.stateLabel];
    
    
    [_keyboard initPad];
    
    for(UIView *key in _keyboard.characterKeys){
        [self addSubview:key];
    }
    
    for(UIView *key in _keyboard.functionKeys){
        [self addSubview:key];
    }
}

- (BOOL)enableInputClicksWhenVisible{
    return YES;
}

#pragma mark -

- (void)setKeyboardtype:(GJKeyboardType)keyboardtype{
    if(_keyboardtype != keyboardtype){
        _keyboardtype = keyboardtype;
        switch (_keyboardtype) {
            case GJKeyboardTypeCharKeyPad:
                self.keyboardBackground.image = self.defCharImage;
                _keyboard = [[GJKeyboardCharPad alloc]init];
                break;
            case GJKeyboardTypeNumKeyPad:
                self.keyboardBackground.image = self.defNumImage;
                _keyboard = [[GJKeyboardNumPad alloc]init];
                break;
            case GJKeyboardTypeCardKeyPad:
                self.keyboardBackground.image = self.defNumImage;
                _keyboard = [[GJKeyBoardCardPad alloc]init];
                break;
                
        }
        [self setUp];
    }
}

- (void)setTextView:(id<UITextInput>)textView{
    if([textView isKindOfClass:[UITextView class]]){
        [(UITextView *)textView setInputView:self];
    }else if ([textView isKindOfClass:[UITextField class]]){
        [(UITextField *)textView setInputView:self];
    }
    _textView = textView;
}

#pragma mark - lazyInit

- (UIImageView *)keyboardBackground{
    if(!_keyboardBackground){
        _keyboardBackground = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, KEYBOARD_HEIGHT + STATE_HEIGHT)];
        _keyboardBackground.image = self.defNumImage;
        
        //添加线条
        
    }
    return _keyboardBackground;
}

- (UILabel *)stateLabel {
    if(!_stateLabel){
        _stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, STATE_HEIGHT)];
        _stateLabel.textColor = [UIColor lightGrayColor];
        _stateLabel.font = [UIFont systemFontOfSize:16];
        _stateLabel.textAlignment = NSTextAlignmentCenter;
        _stateLabel.userInteractionEnabled = YES;
        _stateLabel.text = @"国泰君安安全键盘";
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(stateTap)];
        [_stateLabel addGestureRecognizer:tap];
    }
    return _stateLabel;
}

- (void)stateTap{
    if ([self.textView isKindOfClass:[UITextField class]])
    {
        UITextField *textField = (UITextField *)self.textView;
        if([textField canResignFirstResponder]) [textField resignFirstResponder];
        
        if ([[textField delegate] respondsToSelector:@selector(textFieldShouldReturn:)])
            [[textField delegate] textFieldShouldReturn:(UITextField *)self.textView];
        
    }
}


#pragma mark - touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    CGPoint location = [[touches anyObject] locationInView:self];
    
    for (UIButton *b in _keyboard.characterKeys) {
        if(CGRectContainsPoint(b.frame, location) && b.hidden == NO)
        {
            [_keyboard touchBegin:b type:GJKeyboardButtonTypeCharacterKey];
            [[UIDevice currentDevice] playInputClick];
        }
    }
    
    for(UIButton *b in _keyboard.functionKeys){
        if(CGRectContainsPoint(b.frame, location))
        {
            [_keyboard touchBegin:b type:GJKeyboardButtonTypeFunctionKey];
            [[UIDevice currentDevice] playInputClick];
        }
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    CGPoint location = [[touches anyObject] locationInView:self];
    
    for (UIButton *b in _keyboard.characterKeys) {
        if(CGRectContainsPoint(b.frame, location) && b.hidden == NO)
        {
            [_keyboard touchMove:b type:GJKeyboardButtonTypeCharacterKey];
        }
    }
    
    for (UIButton *b in _keyboard.functionKeys) {
        if(CGRectContainsPoint(b.frame, location))
        {
            [_keyboard touchMove:b type:GJKeyboardButtonTypeFunctionKey];
        }
    }
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [_keyboard touchEnd];
    
    CGPoint location = [[touches anyObject] locationInView:self];
    
    for (UIButton *b in _keyboard.characterKeys) {
        if(CGRectContainsPoint(b.frame, location) && b.hidden == NO)
        {
            switch ([_keyboard touchEnd:b]) {
                case GJKeyFunctionInsert:
                {
                    NSString *character = [NSString stringWithString:b.titleLabel.text];
                    [self.textView insertText:character];
                    
                    if ([self.textView isKindOfClass:[UITextView class]])
                        [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self.textView];
                    else if ([self.textView isKindOfClass:[UITextField class]])
                        [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:self.textView];
                }
                    break;
                case GJKeyFunctionDelete:
                case GJKeyFunctionReturn:
                case GJKeyFunctionNormal:
                case GJKeyFunctionUpdate:
                    break;
            }
        }
    }
    
    //功能键
    for(UIButton *b in _keyboard.functionKeys){
        if(CGRectContainsPoint(b.frame, location))
        {
            switch ([_keyboard touchFunctionEnd:b]) {
                case GJKeyFunctionDelete:
                {
                    [self.textView deleteBackward];
                    
                    if ([self.textView isKindOfClass:[UITextView class]])
                        [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self.textView];
                    else if ([self.textView isKindOfClass:[UITextField class]])
                        [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:self.textView];
                }
                    break;
                case GJKeyFunctionInsert:
                {
                    [self.textView insertText:@" "];
                    
                    if ([self.textView isKindOfClass:[UITextView class]])
                        [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self.textView];
                    else if ([self.textView isKindOfClass:[UITextField class]])
                        [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:self.textView];
                }
                    break;
                case GJKeyFunctionReturn:
                {
                    if ([self.textView isKindOfClass:[UITextView class]])
                    {
                        [self.textView insertText:@"\n"];
                        [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self.textView];
                    }
                    else if ([self.textView isKindOfClass:[UITextField class]])
                    {
                        UITextField *textField = (UITextField *)self.textView;
                        if([textField canResignFirstResponder]) [textField resignFirstResponder];
                        
                        if ([[textField delegate] respondsToSelector:@selector(textFieldShouldReturn:)])
                            [[textField delegate] textFieldShouldReturn:(UITextField *)self.textView];
                        
                    }
                }
                    break;
                case GJKeyFunctionUpdate:
                {
                    [self setUp];
                }
                    break;
                case GJKeyFunctionNormal:
                    break;
                    
            }
            
        }
    }
}

- (UIImage *)defNumImage{
    if(!_defNumImage){
        _defNumImage = [UIImage imageWithHexString:@"6a6a6a"];
    }
    
    return _defNumImage;
}

- (UIImage *)defCharImage{
    if(!_defCharImage){
        _defCharImage = [UIImage imageWithHexString:@"6a6a6a"];
    }
    
    return _defCharImage;
}

@end
