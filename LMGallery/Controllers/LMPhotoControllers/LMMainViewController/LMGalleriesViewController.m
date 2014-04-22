//
//  LMGalleryViewController.m
//  LMGallery
//
//  Created by itenyh on 13-10-14.
//  Copyright (c) 2013年 lmodel. All rights reserved.
//

#import "LMGalleriesViewController.h"
#import "LMDetailPhotoViewController.h"
#import "LMGalleryCell.h"
#import "MMGridViewDefaultCell.h"

#import "LMBasicDBOperator.h"
#import "LMModelBo.h"

#define ColCount 3
#define RowCount 3

@implementation LMGalleriesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self setNavTitle:_curCatBo.name LeftBarBtnType:BKNavLeftBackType AndLeftTitle:@"" RightBarBtnType:BKNavBtnNone AndRightTitle:@""];
    [self startSwipeRight];
    
    tableCon = [[LMGalleryTableViewController alloc] initWithStyle:UITableViewStylePlain];
    tableCon.view.frame = CGRectMake(0, 0, [UIManage getAppWidth], [UIManage getAppHeight] - LMNavHeight);
    [self addChildViewController:tableCon];
    [self addSubViewInContentView:tableCon.tableView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [LMBasicDBOperator getAllModelsWithCatId:_curCatBo.cid upMidBoundary:INT32_MAX callback:^(NSMutableArray *array) {
        
        tableCon.datas = array;
        [tableCon.tableView reloadData];
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
