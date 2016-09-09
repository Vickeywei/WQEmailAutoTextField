# WQEmailAutoTextField
支持StoryBoard和纯代码的邮箱输入填充效果

use Guide
pod setup 更新本地pod仓库
pod 'WQMailAutoFillTextField', '~> 1.0.0'添加到podfile中
引入头文件#import <WQMailTextField.h>
1.如果使用StoryBoard,将其Class改为WQMailTextField
然后设置邮箱后缀的数据源数组
self.textField.mailArray = [NSMutableArray arrayWithObjects:@"@hzdracom.com",@"@qq.com",@"@163.com",@"@126.com",@"@yahoo.com",@"@139.com",@"@henu.com", nil];
2.如果是纯代码,初始化方法只支持
- (instancetype)initWithFrame:(CGRect)frame          fontSize:(CGFloat)fontSize;//第一个是frame,第二个是字号大小
在设置邮箱后缀的数据源数组.



 
