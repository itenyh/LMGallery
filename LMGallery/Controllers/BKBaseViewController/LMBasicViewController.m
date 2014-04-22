//
//  LMBasicViewController.m
//  LMGallery
//
//  Created by Apple on 13-11-21.
//  Copyright (c) 2013年 lmodel. All rights reserved.
//

#import "LMBasicViewController.h"
#import "LMAppDelegate.h"

static UIImage *_navBarImage;

@interface LMBasicViewController ()

@end

@implementation LMBasicViewController

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
    self.BKNavigationBar.titleLabel.textColor = [UIColor whiteColor];
    self.BKNavigationBar.titleLabel.font = [UIFont fontWithName:@"Optima" size:23];
    
    lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.BKNavigationBar.frame.size.height - 1, [UIManage getAppWidth], 0.5)];
    lineView.backgroundColor = [UIColor whiteColor];
    [self.BKNavigationBar addSubview:lineView];

    self.view.backgroundColor = [UIColor blackColor];
    self.contentView.backgroundColor = [UIColor blackColor];
}

- (void)clearLineView
{
    lineView.hidden = YES;
}

- (void)startSwipeRight
{
    if (swipeRightGes == nil) {
        swipeRightGes = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFromRight:)];
        [swipeRightGes setDirection:(UISwipeGestureRecognizerDirectionRight)];
        [self.contentView addGestureRecognizer:swipeRightGes];
    }
}

- (void)handleSwipeFromRight:(UIGestureRecognizer *)rec
{
    [self clickLeftBtnEvent:self];
}

//- (UIImage *)navigationBarImage
//{
//    if(_navBarImage == nil)
//        _navBarImage = [UIImage imageNamed:@"bg_daohang"];
//    return _navBarImage;
//}

- (float)navBtnBottomOffsetY:(BKNavBtnType)type
{
    if (type == BKNavLeftBackType) {
        if ([BKBaseFunctions getIosVer] >= 7.0) {
            return 12 - 9;
        } else {
            return 9;
        }
        
    }
    
    else {
        return 12;
    }
    
}

- (float)navBtnOffsetX:(BKNavBtnType)type
{
    if (type == BKNavLeftBackType) {
        return -3;
    }
    
    else if(type == BKNavCustomType)
        return 8;
    
    else
        return [super navBtnOffsetX:type];
}

- (UIButton *)createNavBtn:(BKNavBtnType)type
{
    UIButton *btn = [[UIButton alloc] init];
    
    switch (type) {
            
        case BKNavCustomType:
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn setTitleColor:[UIManage color:0 blue:0 green:0 alpha:1] forState:UIControlStateNormal];
            [btn setTitleColor:[UIManage color:0 blue:0 green:0 alpha:0.5] forState:UIControlStateHighlighted];
            break;
            
        case BKNavLeftBackType:
        {
            UIImage *img = [UIImage imageNamed:@"back_button_arrow"];
            btn.frame = CGRectMake(0, 0, img.size.width, img.size.height);
            [btn setImage:img forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }
    
    return btn;
}


- (void)pushViewController:(UIViewController *)controller isAnimated:(BOOL)animated
{
    LMAppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.rootNavi pushViewController:controller animated:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
