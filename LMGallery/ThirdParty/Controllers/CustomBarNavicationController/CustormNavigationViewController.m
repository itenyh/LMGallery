//
//  CustormNavigationViewController.m
//  BKWeiyun
//
//  Created by 蔡凌 on 13-3-4.
//  Copyright (c) 2013年 beikr developer 1. All rights reserved.
//

#import "CustormNavigationViewController.h"

@implementation CustormNavigationViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark ios6横屏

- (BOOL)shouldAutorotate
{
   // NSLog(@"topViewController %@",self.topViewController);
    BOOL rotate = self.topViewController.shouldAutorotate;

    return rotate;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return self.topViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return self.topViewController.preferredInterfaceOrientationForPresentation;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    
}

@end
