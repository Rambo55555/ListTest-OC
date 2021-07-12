//
//  NewView.m
//  ListTest-OC
//
//  Created by rambo on 2021/7/9.
//

#import "NewViewController.h"
//#import <QuartzCore/QuartzCore.h>

@interface NewViewController ()
@property (nonatomic, strong) UITextView* textView;
@property (nonatomic, strong) UIButton* button;
@end

@implementation NewViewController

- (void)viewDidLoad {
    [self constructUI];
}

- (void)constructUI
{
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(20, 109, 100, 23)]; // 数字的顺序是 x， y ，宽度，高度
    label.text = @"粘贴视频链接";// 文本内容
    label.font = [UIFont systemFontOfSize:16 weight:10]; // 字体大小
    label.textColor = [UIColor blackColor]; // 文本颜色
    
    // textView
    UITextView* textView = [[UITextView alloc] initWithFrame:CGRectMake(20, 147, [[UIScreen mainScreen] bounds].size.width - 2 * 20, 100)];
    textView.text = self.str;
    textView.font = [UIFont systemFontOfSize:14];
    //textField.borderStyle = UITextBorderStyleRoundedRect;
    textView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    //[textView setBackgroundColor:[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0]];
    //    textView.layer.borderColor = [UIColor grayColor].CGColor;
    //    textView.layer.borderWidth =1.0;
    textView.layer.cornerRadius = 5.0;
    self.textView = textView;
    // button
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(20, 262, [[UIScreen mainScreen] bounds].size.width - 2 * 20, 40)];
    button.layer.cornerRadius = 20.0;
    button.backgroundColor = [UIColor colorWithRed:34/255.0 green:213/255.0 blue:156/255.0 alpha:1.0];
    [button setTitle:@"开始识别" forState:0];
    //button.titleLabel = @"开始识别";
    self.button = button;
    // 添加点击事件
    [self.button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    // 解决动画卡顿，原因：因为从iOS7开始， UIViewController的根view的背景颜色默认为透明色(即clearColor)，所谓“卡顿”其实就是由于透明色重叠后，造成视觉上的错觉，所以这并不是真正的“卡顿”，
    self.view.backgroundColor = [UIColor whiteColor];
    // 设置子视图
    [self.view addSubview:label];
    [self.view addSubview:textView];
    [self.view addSubview:button];
}

- (void)returnSendValue:(sendValueByBlock)block {
    self.sendValueBlock = block;
}

- (void)clickButton
{
    [self.navigationController popViewControllerAnimated: YES];
    NSString* str = self.textView.text;
    if (str.length > 0)
    {
        // 先判断实现代理类有没有这个方法
        if ([self.delegate respondsToSelector:@selector(sendValue:)])
        {
            [self.delegate sendValue:str];
            self.sendValueBlock(str);
        }
    }
}

@end
