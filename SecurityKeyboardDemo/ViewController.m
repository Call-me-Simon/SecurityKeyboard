//
//  ViewController.m
//  SecurityKeyboardDemo
//
//  Created by Simon on 2018/6/11.
//  Copyright © 2018年 sunshixiang. All rights reserved.
//

#import "ViewController.h"
#import "GJKeyboard.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UITextField *textField = [[UITextField alloc] init];
    textField.center = self.view.center;
    textField.backgroundColor = [UIColor cyanColor];
    textField.bounds = CGRectMake(0, 0, 100, 50);
    [self.view addSubview:textField];
    
    GJKeyboard *keyboard = [[GJKeyboard alloc] init];
    [keyboard setTextView:textField];
    [keyboard.stateLabel setText:@"安全键盘"];
    keyboard.keyboardtype = GJKeyboardTypeNumKeyPad;
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
