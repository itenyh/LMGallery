//
//  LMPhotoClassViewController.m
//  LMGallery
//
//  Created by itenyh on 13-10-30.
//  Copyright (c) 2013年 lmodel. All rights reserved.
//
#import "LMAppDelegate.h"

#import "LMPhotoClassViewController.h"
#import "LMGalleriesViewController.h"
#import "LMSearchViewController.h"
#import "LMPhotoClassCell.h"
#import "LMColofulClassCell.h"
#import "LMInterface.h"
#import "BKUserDefautTool.h"

#import "LMModelBo.h"
#import "LMCategoryBo.h"
#import "LMModel+LMCategory.h"
#import "LMLargePhotoBo.h"

#import "LMBasicDBOperator.h"

@implementation LMPhotoClassTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if(self)
    {
        _modelTypes = [NSMutableArray array];
        self.refreshControl = [[UIRefreshControl alloc] init];
        
    }
    
    return self;
}

#pragma mark -
#pragma mark table data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _modelTypes.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [LMColofulClassCell getCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *lMPhotoClassCellId = @"lMPhotoClassCell";
    
    LMColofulClassCell *cell = [tableView dequeueReusableCellWithIdentifier:lMPhotoClassCellId];
    if (cell == nil) {
        cell = [[LMColofulClassCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lMPhotoClassCellId];
    }
    
    [cell displayWith:[_modelTypes objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LMGalleriesViewController *gallery = [[LMGalleriesViewController alloc] init];
    gallery.curCatBo = [_modelTypes objectAtIndex:indexPath.row];
    
    LMAppDelegate *appDel = [UIApplication sharedApplication].delegate;
    [appDel.rootNavi pushViewController:gallery animated:YES];
}

@end

@implementation LMPhotoClassViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        tableViewController = [[LMPhotoClassTableViewController alloc] initWithStyle:UITableViewStylePlain];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestNewestDatas) name:LMBigUpdateNoti object:nil];
    
    [self setNavTitle:@"LModels" LeftBarBtnType:BKNavBtnNone AndLeftTitle:@"" RightBarBtnType:BKNavBtnNone AndRightTitle:@""];
    [self setRightBtnImage:[UIImage imageNamed:@"btn_sousuo"]];
    
    tableViewController.view.frame = CGRectMake(0, 0, [UIManage getAppWidth], [UIManage getAppHeight] - LMNavHeight - LMTabBarHeight);
    tableViewController.view.backgroundColor = [UIColor blackColor];
    tableViewController.tableView.backgroundColor = [UIColor blackColor];
    tableViewController.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableViewController.refreshControl addTarget:self action:@selector(refreshControlEvent:) forControlEvents:UIControlEventValueChanged];
    [self addSubViewInContentView:tableViewController.tableView];

    [self requestNewestDatas];
    
}

- (void)refreshControlEvent:(UIRefreshControl *)sender
{
    [tableViewController.refreshControl endRefreshing];
    
    [self startLoading:@"正在获取数据..."];
    
    [LMInterface requestAllDatasWithSuccessBlock:^(id retInfo) {
        
        [self stopLoading];
        
        [LMBasicDBOperator getAllCatsWithcallback:^(NSMutableArray *array) {
            
            tableViewController.modelTypes = array;
            [tableViewController.tableView reloadData];
            
        }];
        
    } withFailBlock:^(id retInfo) {
        
        [self stopLoading];
        
    }];
    
}

- (void)clickRightBtnEvent:(id)sender
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[LMSearchViewController alloc] init]];
    nav.navigationBar.hidden = YES;
    [self presentModalViewController:nav animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Request to update to newset data
- (void)requestNewestDatas
{
    [self startLoading:@"正在获取数据..."];
    [LMInterface requestAllDatasWithSuccessBlock:^(id retInfo) {
        
        
        [LMBasicDBOperator getAllCatsWithcallback:^(NSMutableArray *array) {
            
            tableViewController.modelTypes = array;
            [tableViewController.tableView reloadData];
            
            [self stopLoading];
            
        }];
        
    } withFailBlock:^(id retInfo) {
        
        [self stopLoading];
        
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
