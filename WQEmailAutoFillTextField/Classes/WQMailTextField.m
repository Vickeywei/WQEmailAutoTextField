//
//  WQMailTextField.m
//  WQMailTextField
//
//  Created by 魏琦 on 16/9/9.
//  Copyright © 2016年 com.drcacom.com. All rights reserved.
//

#import "WQMailTextField.h"
#import <Masonry.h>
//强引用/弱引用
#define WQWeakSelf(type) __weak typeof(type) weak##type = type
#define WQStrongSelf(type) __strong typeof(type) strong##type = weak##type
typedef NS_ENUM(NSUInteger,WQMailTextFieldLayout) {
    WQMailTextFieldLayoutAuto,
    WQMailTextFieldLayoutManual
};

@interface WQMailTextField ()<UITextFieldDelegate>
@property (nonatomic, strong)UILabel* mailLabel;
@property (nonatomic, strong)NSString* email;

@end

@implementation WQMailTextField
- (void)awakeFromNib {
    [self configInitializeLayoutType:WQMailTextFieldLayoutAuto];
    
    
}
- (instancetype)initWithFrame:(CGRect)frame fontSize:(CGFloat)fontSize {
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:fontSize];
        self.frame = frame;
        [self configInitializeLayoutType:WQMailTextFieldLayoutManual];
        
        
    }
    return self;
}
/**
 *  初始化
 */
- (void)configInitializeLayoutType:(WQMailTextFieldLayout)layoutType {
    self.delegate = self;
    _email = [[NSMutableString alloc] initWithCapacity:0];
    _mailLabel = [[UILabel alloc] init];
    _mailLabel.textColor = [UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:1];
    _mailLabel.font = self.font;
    if (layoutType == WQMailTextFieldLayoutAuto) {
        [self addSubview:_mailLabel];
        WQWeakSelf(self);
        [_mailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            WQStrongSelf(self);
            make.left.mas_equalTo(strongself.mas_left).offset(6);
            make.right.equalTo(self);
            make.top.equalTo(self);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-1);
        }];
    }
    else {
        _mailLabel.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-2);
        [self addSubview:_mailLabel];
        
    }
}

/**
 *  匹配邮箱过程
 *
 *  @param range  range
 *  @param string 用户输入string
 */
- (void)configMailMatchingRange:(NSRange)range replacementString:(NSString *)string
{
    //获取完整的输入文本
    NSString *completeStr = [self.text stringByReplacingCharactersInRange:range withString:string];
    //以@符号分割文本
    NSArray *temailArray = [completeStr componentsSeparatedByString:@"@"];
    //获取邮箱前缀
    NSString *emailString = [temailArray firstObject];
    
    //邮箱匹配 没有输入@符号时 用@匹配
    NSString *matchString = @"@";
    if(temailArray.count > 1){
        //如果已经输入@符号 截取@符号以后的字符串作为匹配字符串
        matchString = [completeStr substringFromIndex:emailString.length];
    }
    //匹配邮箱 得到所有跟当前输入匹配的邮箱后缀
    NSMutableArray *suffixArray = [self checkEmailStr:matchString];
    
    //边界控制 如果没有跟当前输入匹配的后缀置为@""
    NSString *fixStr = suffixArray.count > 0 ? [suffixArray firstObject] : @"";
    //将lblEmail部分字段隐藏
    NSInteger cutLenth = suffixArray.count > 0 ? completeStr.length : emailString.length;
    
    //最终的邮箱地址
    self.email = fixStr.length > 0 ? [NSString stringWithFormat:@"%@%@",emailString,fixStr] : completeStr;
    
    //设置lblEmail 的attribute
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",emailString,fixStr]];
    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor clearColor] range:NSMakeRange(0,cutLenth)];
    self.mailLabel.attributedText = attributeString;
    
    //清空文本框内容时 隐藏lblEmail
    if(completeStr.length == 0){
        self.mailLabel.text = @"";
        self.email = @"";
    }
}

/**
 *  结束输入操作
 */
- (void)didEndEditing
{
    self.text = self.email;
    self.mailLabel.text = @"";
}

/**
 *  替换邮箱匹配类型
 *
 *  @param string 匹配的字段
 *
 *  @return 匹配成功的Array
 */
- (NSMutableArray *)checkEmailStr:(NSString *)string{
    NSMutableArray *filterArray = [NSMutableArray arrayWithCapacity:0];
    for (NSString *str in self.mailArray) {
        if([str hasPrefix:string]){
            [filterArray addObject:str];
        }
    }
    return filterArray;
}

- (void)setMailColor:(UIColor *)mailColor {
    _mailColor = mailColor;
    _mailLabel.textColor = mailColor;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self didEndEditing];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    [self configMailMatchingRange:range replacementString:string];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    self.text = _mailLabel.text;
    
    return [textField resignFirstResponder];
    
}
@end
