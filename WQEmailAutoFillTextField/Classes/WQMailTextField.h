//
//  WQMailTextField.h
//  WQMailTextField
//
//  Created by 魏琦 on 16/9/9.
//  Copyright © 2016年 com.drcacom.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WQMailTextField : UITextField
- (instancetype)init __attribute__((unavailable("init方法不可用，请用initWithFrame:fontSzie:")));
+ (instancetype)new  __attribute__((unavailable("init方法不可用，请用initWithFrame:fontSzie:")));
- (instancetype)initWithFrame:(CGRect)frame fontSize:(CGFloat)fontSize;
//邮箱匹配类型
@property (nonatomic, strong) NSArray<NSString*>* mailArray;
//匹配邮箱后缀的字体颜色
@property (nonatomic, strong) UIColor* mailColor;

@end