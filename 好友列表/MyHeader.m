//
//  MyHeader.m
//  好友列表
//
//  Created by 荣耀iMac on 16/9/20.
//  Copyright © 2016年 wleleven. All rights reserved.
//

#import "MyHeader.h"

@implementation MyHeader

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kHeaderHeight)];
        [self setTintColor:[UIColor orangeColor]];
        self.backgroundColor = [UIColor redColor];
        
       UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor redColor];
        [button setFrame:self.bounds];
        
        // 设置按钮的图片
        UIImage *image = [UIImage imageNamed:@"disclosure.png"];
        [button setImage:image forState:UIControlStateNormal];
        
        // 设置按钮内容的显示位置
        [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        
        // 给按钮添加监听事件
        [button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
        
        self.button = button;
    }
    
    return self;
}

- (void)clickButton
{
    // 通知代理执行协议方法
    [self.delegate myHeaderDidSelectedHeader:self];
}

-(void)setIsOpen:(BOOL)isOpen
{
    _isOpen = isOpen;
    
    CGFloat angle = isOpen ? M_PI_2 : 0;
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.button.imageView setTransform:CGAffineTransformMakeRotation(angle)];
    }];
}


@end
