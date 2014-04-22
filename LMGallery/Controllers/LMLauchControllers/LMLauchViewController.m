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
#import "LMSearchViewController.h"
#import "LMSettingViewController.h"
#import "LMSavedViewController.h"
#import "BKUserDefautTool.h"
#import "LMInterface.h"

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
    
    [self clearLineView];
    
    UIImage *launchImage = [UIImage imageNamed:@"iTunesArtwork"];
    UIImageView *launchImageView = [[UIImageView alloc] init];
    launchImageView.image = launchImage;
    launchImageView.frame = CGRectMake(0, 0, launchImage.size.width / 2, launchImage.size.height / 2);
    launchImageView.center = self.contentView.center;
    launchImageView.alpha = 0;
    [self addSubViewInContentView:launchImageView];
    
    [UIView animateWithDuration:1.5 animations:^{
        
        launchImageView.alpha = 1;
        launchImageView.frame = CGRectMake(launchImageView.frame.origin.x, self.contentView.frame.size.height / 2 - launchImageView.frame.size.height, launchImage.size.width / 2, launchImage.size.height / 2);
        
    } completion:^(BOOL finished) {
        
        //邀请码验证模块
        if ([BKUserDefautTool isRequestCheckedNeeded]) {
            
            [self createAndShowAlertViewWith:@""];
            
        }
        
        else {
            
            [self enterMainTab];
            
        }
        
    }];
    
}

- (void)createAndShowAlertViewWith:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"邀请码" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
}

- (void)enterMainTab
{
    LMTabBarViewController *tabController = [self createLMTabBarViewController];
    [self.navigationController pushViewController:tabController animated:YES];
}

-(LMTabBarViewController *)createLMTabBarViewController
{
    UITabBarItem *item1 = [[UITabBarItem alloc] init];
    LMPhotoClassViewController *v1 = [[LMPhotoClassViewController alloc] init];
    v1.tabBarItem = item1;
    
    UITabBarItem *item2 = [[UITabBarItem alloc] init];
    LMSavedViewController *v2=[[LMSavedViewController alloc]init];
    v2.tabBarItem = item2;
    
    UITabBarItem *item3 = [[UITabBarItem alloc] init];
    LMSettingViewController * v3 = [[LMSettingViewController alloc]init];
    v3.tabBarItem = item3;
    
    LMTabBarViewController *tabBarController = [[LMTabBarViewController alloc] init];
    
    NSArray * arr= [NSArray arrayWithObjects:v1, v2, v3, nil];
    
    [tabBarController setViewControllers:arr animated:YES];
    
    return tabBarController;
}

#pragma -AlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UITextField *tf=[alertView textFieldAtIndex:0];
    if (tf.text.length == 0) {
        [self performSelector:@selector(createAndShowAlertViewWith:) withObject:@"请输入邀请码" afterDelay:0.3];
        return;
    }
    
    [self startLoading:@"验证中"];
    
    [LMInterface requestInviteCodeCheckWithCode:tf.text SuccessBlock:^(id retInfo) {
        
        [self stopLoading];
        
        NSNumber *status = [retInfo objectForKey:@"status"];
        if (status == nil || [status longValue] == 1) {

            [self createAndShowAlertViewWith:@"无效的邀请码"];
            
        }
        
        else {
            
            [BKUserDefautTool setLastRefreshForNow];
            [BKUserDefautTool setChecked];
            [self enterMainTab];
            
        }
        
    } withFailBlock:^(id retInfo) {
        
        [self stopLoading];
        
        [self createAndShowAlertViewWith:@"网络异常"];

    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
