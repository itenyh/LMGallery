//
//  LMSavedViewController.m
//  LMGallery
//
//  Created by Apple on 14-1-9.
//  Copyright (c) 2014年 lmodel. All rights reserved.
//

#import "LMSavedViewController.h"
#import "LMBasicDBOperator.h"

@interface LMSavedViewController ()

@end

@implementation LMSavedViewController

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
    
    [self setNavTitle:@"我的收藏" LeftBarBtnType:BKNavBtnNone AndLeftTitle:@"" RightBarBtnType:BKNavBtnNone AndRightTitle:@""];
    [self setRightBtnImage:[UIImage imageNamed:@"btn_edit"]];
    
    listViewController = [[LMModelListViewController alloc] initWithStyle:UITableViewStylePlain];
    listViewController.view.frame = CGRectMake(0, 0, [UIManage getAppWidth], [UIManage getAppHeight] - LMNavHeight - LMTabBarHeight);
    [self addChildViewController:listViewController];
    [self addSubViewInContentView:listViewController.view];
 
}

- (void)viewWillAppear:(BOOL)animated
{
    [LMBasicDBOperator getAllSavedModelsCallback:^(NSMutableArray *array) {
       
        listViewController.searchResultArr = array;
        [listViewController.tableView reloadData];
        
    }];
}

- (void)clickRightBtnEvent:(id)sender
{
    if (listViewController.tableView.isEditing) {
        [listViewController setEditing:NO animated:YES];
    }
    
    else {
        [listViewController setEditing:YES animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
