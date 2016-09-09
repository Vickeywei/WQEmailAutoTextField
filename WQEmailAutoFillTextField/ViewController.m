//
//  ViewController.m
//  WQEmailAutoFillTextField
//
//  Created by 魏琦 on 16/9/9.
//  Copyright © 2016年 com.drcacom.com. All rights reserved.
//

#import "ViewController.h"
#import "WQMailTextField.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet WQMailTextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      self.textField.mailArray = [NSMutableArray arrayWithObjects:@"@hzdracom.com",@"@qq.com",@"@163.com",@"@126.com",@"@yahoo.com",@"@139.com",@"@henu.com", nil];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
