//
//  LMLauchViewController.m
//  LMGallery
//
//  Created by itenyh on 13-10-14.
//  Copyright (c) 2013年 lmodel. All rights reserved.
//

#import "LMLauchViewController.h"
#import "LMTabBarViewController.h"
#import "CustormNavigationViewController.h"
#import "LMPhotoClassViewController.h"

@implementation LMLauchViewController

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
    
    LMTabBarViewController *tabController = [self createLMTabBarViewController];
    
    [self.navigationController pushViewController:tabController animated:YES];
}

-(LMTabBarViewController *)createLMTabBarViewController
{
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"最新上传" image:nil tag:0];
    [item1 setFinishedSelectedImage:[UIImage imageNamed:@"btn_zuixinshangchuanbiaoqiandown_2"]
        withFinishedUnselectedImage:[UIImage imageNamed:@"btn_zuixinshangchuanbiaoqiandown_1"]];
    item1.image = [UIImage imageNamed:@"btn_zuixinshangchuanbiaoqiandown_2"];
    LMPhotoClassViewController *v1 = [[LMPhotoClassViewController alloc] init];
    CustormNavigationViewController *nav1 = [[CustormNavigationViewController alloc] initWithRootViewController:v1];
    nav1.tabBarItem = item1;
    
    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"最近查找" image:nil tag:1];
    [item2 setFinishedSelectedImage:[UIImage imageNamed:@"btn_zuijinchazhaobiaoqiandown_2"]
        withFinishedUnselectedImage:[UIImage imageNamed:@"btn_zuijinchazhaobiaoqiandown_1"]];
    LMPhotoClassViewController *v2=[[LMPhotoClassViewController alloc]init];
    
    CustormNavigationViewController *nav2 = [[CustormNavigationViewController alloc] initWithRootViewController:v2];
    item2.image = [UIImage imageNamed:@"btn_zuijinchazhaobiaoqiandown_2"];
    nav2.tabBarItem = item2;
    
    UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"分类标签" image:nil tag:2];
    [item3 setFinishedSelectedImage:[UIImage imageNamed:@"btn_fenleibiaoqianbiaoqiandown_2"]
        withFinishedUnselectedImage:[UIImage imageNamed:@"btn_fenleibiaoqianbiaoqiandown_1"]];
    // BKClassViewController *v3 = [[BKClassViewController alloc] init];
    LMPhotoClassViewController * v3 = [[LMPhotoClassViewController alloc]init];
    item3.image = [UIImage imageNamed:@"btn_fenleibiaoqianbiaoqiandown_2"];
    v3.tabBarItem = item3;
    CustormNavigationViewController *nav3 = [[CustormNavigationViewController alloc] initWithRootViewController:v3];
    
    LMTabBarViewController *tabBarController = [[LMTabBarViewController alloc] init];
    
    NSArray * arr= [NSArray arrayWithObjects:nav1, nav2, nav3, nil];
    
    [tabBarController setViewControllers:arr animated:YES];
    
    return tabBarController;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
