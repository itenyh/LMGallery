//
//  LMTabBarViewController.m
//  LMGallery
//
//  Created by itenyh on 13-10-30.
//  Copyright (c) 2013年 lmodel. All rights reserved.
//

#define btnTag 43234

#import "LMTabBarViewController.h"

@implementation LMTabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
        self.tabBar.hidden = YES;
        
        float internal = 75;
        
        bottomView= [[UIView alloc] init];
        bottomView.frame = CGRectMake(0, [UIManage getAppHeight] - LMTabBarHeight + 20, [UIManage getAppWidth], LMTabBarHeight);
        bottomView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:bottomView];
        
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view.frame = CGRectMake(0, 0, [UIManage getAppWidth], 0.3);
//        [bottomView addSubview:view];
        
        UIView *tabPanel = [[UIView alloc] init];
        [bottomView addSubview:tabPanel];
        tabPanel.backgroundColor = [UIColor clearColor];
        
        UIImage *homeImg = [UIImage imageNamed:@"home"];
        UIButton *b1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, homeImg.size.width, homeImg.size.height)];
        b1.tag = btnTag + 0;
        [b1 addTarget:self action:@selector(indexSelected:) forControlEvents:UIControlEventTouchUpInside];
//        [b1 setTitle:@"Models" forState:UIControlStateNormal];
        [b1 setBackgroundImage:homeImg forState:UIControlStateNormal];
        [b1 setBackgroundImage:homeImg forState:UIControlStateHighlighted];
        [tabPanel addSubview:b1];
        
        UIImage *searchImg = [UIImage imageNamed:@"save"];
        UIButton *b2 = [[UIButton alloc] initWithFrame:CGRectMake(b1.frame.size.width + b1.frame.origin.x + internal, 0, searchImg.size.width, searchImg.size.height)];
        b2.tag = btnTag + 1;
        [b2 addTarget:self action:@selector(indexSelected:) forControlEvents:UIControlEventTouchUpInside];
        [b2 setBackgroundImage:searchImg forState:UIControlStateNormal];
        [b2 setBackgroundImage:searchImg forState:UIControlStateHighlighted];
        [tabPanel addSubview:b2];
        
        UIImage *settingImg = [UIImage imageNamed:@"settings"];
        UIButton *b3 = [[UIButton alloc] initWithFrame:CGRectMake(b2.frame.size.width + b2.frame.origin.x + internal, 0, settingImg.size.width, settingImg.size.height)];
        b3.tag = btnTag + 2;
        [b3 addTarget:self action:@selector(indexSelected:) forControlEvents:UIControlEventTouchUpInside];
        [b3 setBackgroundImage:settingImg forState:UIControlStateNormal];
        [b3 setBackgroundImage:settingImg forState:UIControlStateHighlighted];
        [tabPanel addSubview:b3];
        
        tabPanel.frame = CGRectMake(0, 0, 2 * internal + 3 * b3.frame.size.width, b3.frame.size.height);
        tabPanel.center = CGPointMake((bottomView.frame.size.width) / 2, (bottomView.frame.size.height) / 2);

        [self indexSelected:b1];
    }
    
    return self;
    
}

- (void)indexSelected:(id)sender
{
    UIButton *btnClick = (UIButton *)sender;
    [self setSelectedIndex:btnClick.tag - btnTag];
    
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    selectedBtn = (UIButton *)[self.view viewWithTag:btnTag + selectedIndex];
    [super setSelectedIndex:selectedIndex];
    [self reDisplayAllbtnsWithSelectedBtn];
}

- (void)reDisplayAllbtnsWithSelectedBtn
{
    
    int allTagCount = 3;
    
    for (int i = 0; i < allTagCount; i++) {
        
        UIButton *btn = (UIButton *)[self.view viewWithTag:btnTag + i];
        
        if (btn == selectedBtn) {
            btn.alpha = 1;
        } else {
            btn.alpha = 0.5;
        }
    }
    
}

- (void)hideBottomBar:(BOOL)isAnimated
{
    if (isAnimated) {
        [UIView animateWithDuration:0.6 animations:^{
            bottomView.alpha = 0;
        }];
    } else {
        bottomView.alpha = 0;
    }
}

- (void)showBottomBar:(BOOL)isAnimated
{
    if (isAnimated) {
        [UIView animateWithDuration:0.1 animations:^{
            bottomView.alpha = 1;
        }];
    } else {
        bottomView.alpha = 1;
    }
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

@end
