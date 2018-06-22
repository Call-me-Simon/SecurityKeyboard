# SecurityKeyboard
自定义安全键盘，常用三种键盘1、数字键盘 2、身份证键盘 3、英文字母键盘。

类型说明：
枚举值：GJKeyboardType

typedef NS_ENUM(NSUInteger, GJKeyboardType) {

    GJKeyboardTypeNumKeyPad = 1,    //数字键盘
    GJKeyboardTypeCharKeyPad,       //英文键盘
    GJKeyboardTypeCardKeyPad        //身份证键盘
};



使用事例：

1、导入头文件
#import "GJKeyboard.h"

2、使用

    GJKeyboard *keyboard = [[GJKeyboard alloc] init];
    [keyboard setTextView:textField]; //这里传入的是创建好的UITextField实例对象
    [keyboard.stateLabel setText:@"安全键盘"];
    keyboard.keyboardtype = GJKeyboardTypeNumKeyPad;
