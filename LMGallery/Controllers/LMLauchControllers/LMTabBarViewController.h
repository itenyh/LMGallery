//
//  LMTabBarViewController.h
//  LMGallery
//
//  Created by itenyh on 13-10-30.
//  Copyright (c) 2013年 lmodel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMTabBarViewController : UITabBarController
{
    UIView *bottomView;
    UIButton *selectedBtn;
}

- (void)hideBottomBar:(BOOL)isAnimated;
- (void)showBottomBar:(BOOL)isAnimated;

@end
