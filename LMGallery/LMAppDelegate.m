//
//  LMAppDelegate.m
//  LMGallery
//
//  Created by itenyh on 13-10-14.
//  Copyright (c) 2013年 lmodel. All rights reserved.
//

#import "LMAppDelegate.h"
#import "LMLauchViewController.h"
#import "CustormNavigationViewController.h"
#import "BKUserDefautTool.h"
#import "LMTabBarViewController.h"

@implementation LMAppDelegate
@synthesize rootNavi;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    LMLauchViewController *launcherViewController = [[LMLauchViewController alloc] init];
    CustormNavigationViewController *rootNav = [[CustormNavigationViewController alloc] init];
    [rootNav setViewControllers:[NSArray arrayWithObject:launcherViewController]];
    rootNav.navigationBarHidden = YES;
    
    self.rootNavi = rootNav;
    self.window.rootViewController = self.rootNavi;
    [self.window makeKeyAndVisible];
    
    [BKUserDefautTool initDefautDicIfNecessary];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    if ([BKUserDefautTool isRefreshNeeded] && ![BKUserDefautTool isRequestCheckedNeeded]) {
        
        NSLog(@"refresh happed!");
        
        [BKUserDefautTool setLastRefreshForNow];
        
        if ([self.rootNavi childViewControllers].count > 1) {
            
            LMTabBarViewController *tabCon = [[self.rootNavi childViewControllers] objectAtIndex:1];
            [self.rootNavi popToViewController:tabCon animated:NO];
            [tabCon setSelectedIndex:0];
            [[NSNotificationCenter defaultCenter] postNotificationName:LMBigUpdateNoti object:nil];
        }
        
        
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
