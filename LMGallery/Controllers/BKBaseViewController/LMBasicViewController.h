//
//  LMBasicViewController.h
//  LMGallery
//
//  Created by Apple on 13-11-21.
//  Copyright (c) 2013年 lmodel. All rights reserved.
//

#import "BKBaseViewController.h"

@interface LMBasicViewController : BKBaseViewController
{
    UISwipeGestureRecognizer *swipeRightGes;
    UIView *lineView;
}

- (void)pushViewController:(UIViewController *)controller isAnimated:(BOOL)animated;
- (void)startSwipeRight;
- (void)clearLineView;

@end
