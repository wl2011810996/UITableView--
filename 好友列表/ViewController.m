//
//  ViewController.m
//  好友列表
//
//  Created by 荣耀iMac on 16/9/20.
//  Copyright © 2016年 wleleven. All rights reserved.
//

#import "ViewController.h"
#import "MyHeader.h"

@interface ViewController ()<MyHeaderDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSArray *dataList;

@property (nonatomic,strong)UITableView *tableView;

// 所有标题行的字典
@property (strong, nonatomic) NSMutableDictionary *sectionDict;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1. 初始化数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"friends" ofType:@"plist"];
    self.dataList = [NSArray arrayWithContentsOfFile:path];
    
 
    // 3. 设置表格行高
  
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor brownColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;

    [self.view addSubview:_tableView];
    [_tableView registerClass:[MyHeader class] forHeaderFooterViewReuseIdentifier:@"MyHeader"];
    
    // 2. 设置标题行高
    [_tableView setSectionHeaderHeight:kHeaderHeight];
        [_tableView setRowHeight:50];
    
    self.sectionDict = [NSMutableDictionary dictionaryWithCapacity:self.dataList.count];
    [self.tableView reloadData];
}



#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataList.count;
}

//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    // 1. 从数组中取出indexPath.row对应的字典
//    NSDictionary *dict = self.dataList[section];
//    
//    // 2. 从字典中取出对应的好友数组
//    NSArray *array = dict[@"friends"];
//    
//    return array.count;
//    
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    MyHeader *header = self.sectionDict[@(section)];
    BOOL isOpen = header.isOpen;
    
    if (isOpen) {
        NSDictionary *dict = self.dataList[section];
        NSArray *array = dict[@"friends"];
        return array.count;
    }else{
        return 0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"MyCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    // 1. 从数组中取出indexPath.row对应的字典
    NSDictionary *dict = self.dataList[indexPath.section];
    
    // 2. 从字典中取出对应的好友数组
    NSArray *array = dict[@"friends"];
    
    // 3. 填充表格内容
    [cell.textLabel setText:array[indexPath.row]];
//    cell.textLabel.text = @"adfasdf";
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *headerID = @"MyHeader";
    
    MyHeader *header = self.sectionDict[@(section)];
    
    if (header == nil) {
        header = [[MyHeader alloc] initWithReuseIdentifier:headerID];
        [header setDelegate:self];
        
        [self.sectionDict setObject:header forKey:@(section)];
    }
    
    NSDictionary *dict = self.dataList[section];
    
    NSString *groupName = dict[@"group"];
    [header.button setTitle:groupName forState:0];
    
    [header setSection:section];
    
    return header;
}

-(void)myHeaderDidSelectedHeader:(MyHeader *)header
{
    MyHeader *myHeader = self.sectionDict[@(header.section)];
    BOOL isOpen= myHeader.isOpen;
    [myHeader setIsOpen:!isOpen];
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:header.section] withRowAnimation:UITableViewRowAnimationFade];
}

@end
