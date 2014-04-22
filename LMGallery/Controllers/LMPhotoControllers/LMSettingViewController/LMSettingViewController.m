//
//  LMSettingViewController.m
//  LMGallery
//
//  Created by Apple on 14-1-8.
//  Copyright (c) 2014年 lmodel. All rights reserved.
//

#import "LMSettingViewController.h"
#import "LMSettingCell.h"
#import "RNBlurModalView.h"
#import "LMBaseFileAndDicOperator.h"

@interface LMSettingViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@end

@implementation LMSettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self setNavTitle:@"设置" LeftBarBtnType:BKNavBtnNone AndLeftTitle:@"" RightBarBtnType:BKNavBtnNone AndRightTitle:@""];
    
    UITableView *localtableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIManage getAppWidth], [UIManage getAppHeight] - LMNavHeight - LMTabBarHeight) style:UITableViewStylePlain];
    localtableView.backgroundColor = [UIColor clearColor];
    localtableView.dataSource = self;
    localtableView.delegate = self;
    localtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubViewInContentView:localtableView];
    
}

#pragma - tableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [LMSettingCell getCellHeight];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *searchResultCellId = @"searchResultCell";
    
    LMSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:searchResultCellId];
    if (cell == nil) {
        cell = [[LMSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:searchResultCellId];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"清除缓存";
    }
    
    else if (indexPath.row == 1) {
        cell.textLabel.text = @"联系方式";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"确认清除缓存?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        [alertView show];
        
    }
    
    else if (indexPath.row == 1) {
        

        RNBlurModalView *modal = [[RNBlurModalView alloc] initWithViewController:self title:nil message:@"北京市朝阳区东三环中路39号建外SOHO11号楼1504\r\r1504 Building11,Jianwai SOHO,39 East 3rd-Ring Road, Chao Yang District,Beijing,China\r\rT: +86-10-58690064\rF: +86-10-58690424\rQQ: 800097939\rwww.lmodels.net\r"];
        
        [modal show];
    }
    
    // 取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
    }
    
    else {
        [self startLoading:@"正在清除"];
        [LMBaseFileAndDicOperator clearCache];
        [self stopLoading];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
