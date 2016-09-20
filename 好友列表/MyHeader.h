//
//  MyHeader.h
//  好友列表
//
//  Created by 荣耀iMac on 16/9/20.
//  Copyright © 2016年 wleleven. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyHeader;
#define kHeaderHeight 44

#pragma mark - 定义协议
@protocol MyHeaderDelegate <NSObject>

- (void)myHeaderDidSelectedHeader:(MyHeader *)header;

@end

@interface MyHeader : UITableViewHeaderFooterView


// 定义代理
@property (weak, nonatomic) id <MyHeaderDelegate> delegate;

// 标题栏按钮
@property (weak, nonatomic) UIButton *button;
// 标题栏分组
@property (assign, nonatomic) NSInteger section;
// 是否展开折叠标记
@property (assign, nonatomic) BOOL isOpen;

@end
