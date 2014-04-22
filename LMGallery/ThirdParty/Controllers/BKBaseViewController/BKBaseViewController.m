//
//  MTBaseViewController.m
//  MumTools2
//
//  Created by 蔡凌 on 13-3-24.
//  Copyright (c) 2013年 蔡凌. All rights reserved.
//

#import "BKBaseViewController.h"
#import "BKAlterView.h"
#import <QuartzCore/QuartzCore.h>

@implementation BKBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    
    return self;
}

- (id)init
{
    self = [super init];
    if(self){
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if ([BKBaseFunctions getIosVer] >= 7.0) {
//        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    _navigationBar = self.navigationController.navigationBar;
    
    backgroundView = [[UIImageView alloc] init];
    backgroundView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self.view insertSubview:backgroundView atIndex:0];
    backgroundView.backgroundColor = [BKUIUtil color:@"#eeeeee"];
    
    UISwipeGestureRecognizer *swipGes = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleTheSwipGesture:)];
    swipGes.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipGes];
}

- (void)handleTheSwipGesture:(UISwipeGestureRecognizer *)targetGesture
{
    if(targetGesture.direction == UISwipeGestureRecognizerDirectionRight)
    {
        if(_leftBtn == nil)
            return;
        
        if(leftBtnType == BKNavLeftBackType)
        {
            if([self navigationController] != nil)
            {
                [self clickLeftBtnEvent:_leftBtn];
            }
        }
    }
}

- (void)setBackgroundView:(UIImageView *)bkView
{
    [backgroundView removeFromSuperview];
    backgroundView = bkView;
    [self.view insertSubview:backgroundView atIndex:1];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickLeftBtnEvent:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickRightBtnEvent:(id)sender
{

}

- (void)setTheRightNavigationItemEnabledWith:(BOOL)isEnabled{
    [self.navigationItem.rightBarButtonItem setEnabled:isEnabled];
}

- (void)setNavTitle:(NSString *)title
{
    self.title = title;
}

- (void)setScrollDetailViewTitle:(NSString *)title
{
    self.title = title;
}

- (void)setNavLeftBarBtnType:(BKNavBtnType)leftType AndLeftTitle:(NSString *)leftTitle RightBarBtnType:(BKNavBtnType)rightType AndRightTitle:(NSString *)rightTitle
{
    [self setNavTitle:nil LeftBarBtnType:leftType AndLeftTitle:leftTitle RightBarBtnType:rightType AndRightTitle:rightTitle];
}

- (void)setNavTitle:(NSString *)title LeftBarBtnType:(BKNavBtnType)leftType AndLeftTitle:(NSString *)leftTitle RightBarBtnType:(BKNavBtnType)rightType AndRightTitle:(NSString *)rightTitle
{
    self.title = title;
    
    [self setNavLeftBarBtnType:leftType AndLeftTitle:leftTitle];
    [self setNavRightBarBtnType:rightType AndRightTitle:rightTitle];
}

- (void)setNavLeftBarBtnType:(BKNavBtnType)leftType AndLeftTitle:(NSString *)leftTitle
{
    UIImage *upImage;
    UIImage *downImage;
    if(leftTitle != nil && leftType != BKNavBtnNone) {
        
        UIButton *btn = [[UIButton alloc] init];
        
        if (leftType == BKNavLeftBackType) {
            upImage = [UIImage imageNamed:@"btn_fanhui_1"];
            downImage = [UIImage imageNamed:@"btn_fanhui_2"];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 6.5, 0, 0)];
        } else {
            upImage = [UIImage imageNamed:@"btn_daohangrightbar_1"];
            downImage = [UIImage imageNamed:@"btn_daohangrightbar_2"];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 2.1, 0, 0)];
        }
        
        CGRect imageFrame = CGRectMake(0,0,upImage.size.width,upImage.size.height);
        btn.frame = imageFrame;
        
        [btn setBackgroundImage:upImage forState:UIControlStateNormal];
        [btn setBackgroundImage:downImage forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(clickLeftBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:leftTitle forState:UIControlStateNormal];
//        btn.titleLabel.font = [UIFont systemFontOfSize:NavigationButtonFont];
        btn.titleLabel.shadowOffset = CGSizeMake(0, -1);
        btn.titleLabel.shadowColor = [UIColor blackColor];
        [btn setTitleColor:[BKUIUtil color:@"#c8c8c8"] forState:UIControlStateNormal];
        
        UIView *customView = [[UIView alloc] initWithFrame:[self getNaviItemFrame:upImage isleft:YES]];
        btn.frame = customView.frame; // where you can set your insets
        [customView addSubview:btn];
        UIBarButtonItem *bb = [[UIBarButtonItem alloc] initWithCustomView:customView];
        [[self navigationItem] setLeftBarButtonItem:bb];
    }
}

- (void)setNavRightBarBtnType:(BKNavBtnType)rightType AndRightTitle:(NSString *)rightTitle
{
    if(rightTitle != nil && rightType != BKNavBtnNone){
        UIImage *upImage = [UIImage imageNamed:@"btn_daohangrightbar_1"];
        UIImage *downImage = [UIImage imageNamed:@"btn_daohangrightbar_2"];
        CGRect imageFrame = CGRectMake(0,0,upImage.size.width,upImage.size.height);
        UIButton *btn = [[UIButton alloc] initWithFrame:imageFrame];
        [btn setBackgroundImage:upImage forState:UIControlStateNormal];
        [btn setBackgroundImage:downImage forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(clickRightBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:rightTitle forState:UIControlStateNormal];
//        btn.titleLabel.font = [UIFont systemFontOfSize:NavigationButtonFont];
        btn.titleLabel.shadowOffset = CGSizeMake(0, -1);
        btn.titleLabel.shadowColor = [UIColor blackColor];
        [btn setTitleColor:[BKUIUtil color:@"#c8c8c8"] forState:UIControlStateNormal];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 2.1, 0, 0)];
    
        UIView *customView = [[UIView alloc] initWithFrame:[self getNaviItemFrame:upImage isleft:NO]];
        btn.frame = customView.frame; // where you can set your insets
        [customView addSubview:btn];
        
        UIBarButtonItem *bb = [[UIBarButtonItem alloc] initWithCustomView:customView];
        [[self navigationItem] setRightBarButtonItem:bb];
        
    }else if(rightTitle==nil&&rightType==BKNavBtnMore){
        UIImage *upImage = [UIImage imageNamed:@"btn_daohangrightbar_1"];
        UIImage *downImage = [UIImage imageNamed:@"btn_daohangrightbar_2"];
        CGRect imageFrame = CGRectMake(0,0,upImage.size.width,upImage.size.height);
        UIButton *btn = [[UIButton alloc] initWithFrame:imageFrame];
        [btn setBackgroundImage:upImage forState:UIControlStateNormal];
        [btn setBackgroundImage:downImage forState:UIControlStateHighlighted];
        [btn setImage:[UIImage imageNamed:@"btn_gengduodian"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickRightBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:rightTitle forState:UIControlStateNormal];
//        btn.titleLabel.font = [UIFont systemFontOfSize:NavigationButtonFont];
        btn.titleLabel.shadowOffset = CGSizeMake(0, -1);
        btn.titleLabel.shadowColor = [UIColor blackColor];
        [btn setTitleColor:[BKUIUtil color:@"#c8c8c8"] forState:UIControlStateNormal];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 2.1, 0, 0)];
        
        UIView *customView = [[UIView alloc] initWithFrame:[self getNaviItemFrame:upImage isleft:NO]];
        btn.frame = customView.frame; // where you can set your insets
        [customView addSubview:btn];
        
        UIBarButtonItem *bb = [[UIBarButtonItem alloc] initWithCustomView:customView];
        [[self navigationItem] setRightBarButtonItem:bb];

    }
}


- (void)setLeftBtnImage:(UIImage *)image
{
    if(_leftBtn == nil)
    {
        _leftBtn = [self createNavBtn];
    }
    
    [_leftBtn setBackgroundImage:image forState:UIControlStateNormal];
}

- (void)setRightBtnImage:(UIImage *)image
{
    if(_rightBtn == nil)
    {
        _rightBtn = [self createNavBtn];
    }
    
    [_rightBtn setBackgroundImage:image forState:UIControlStateNormal];
}

- (UIImage *)getNavBtnImageWithBtnType:(BKNavBtnType)btnType
{
    UIImage *btnImage;
    
    if (btnType == BKNavLeftBackType) {
        btnImage = [[UIImage imageNamed:@"btn_fanhui_1"] resizableImageWithCapInsets:UIEdgeInsetsMake(2, 12, 2, 12)];
    }
    else if(btnType == BKNavBtnMore){
        btnImage = [[UIImage imageNamed:@"btn_gengduodian"] resizableImageWithCapInsets:UIEdgeInsetsMake(2, 12, 2, 12)];

    }
    else {
        btnImage = [[UIImage imageNamed:@"btn_daohangrightbar_1"] resizableImageWithCapInsets:UIEdgeInsetsMake(2, 12, 2, 12)];
    }
    return btnImage;
}

- (CGRect)getNaviItemFrame:(UIImage *)backImg isleft:(BOOL)left
{
    CGRect result;
    
    if ([BKBaseFunctions getIosVer] < 7.0)
        result = CGRectMake(0, 0, backImg.size.width, backImg.size.height);
    else {
        if (left) {
            result = CGRectMake(-8, 1.5, backImg.size.width, backImg.size.height);
        } else {
            result = CGRectMake(8, 1.5, backImg.size.width, backImg.size.height);
        }
        
    }
    
    return result;
}

- (UIButton *)createNavBtn
{
    UIButton *button = [[UIButton alloc] init];
    [button setTitleColor:[UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [button setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    button.titleLabel.shadowOffset = CGSizeMake(0,-1);
    
    button.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    return button;
}

- (void)disableRightButton
{
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
}

- (void)recoverRightButton
{
    [self.navigationItem.rightBarButtonItem setEnabled:YES];
}

- (void)showErrorMessage:(NSString *)msg
{
    [self showErrorMessage:msg offsetY:0];
}
- (void)showInfoMessage:(NSString *)msg
{
    //    [BKAlterView showInfoMsg:msg inview:self.view];
    [self showInfoMessage:msg offsetY:0];
}

- (void)showErrorMessage:(NSString *)msg offsetY:(float)offsetY
{
    [BKAlterView showErrorMsg:msg inview:self.view offsetY:offsetY];
}

- (void)showInfoMessage:(NSString *)msg offsetY:(float)offsetY
{
    [BKAlterView showInfoMsg:msg inview:self.view offsetY:offsetY];
}

-(void)startLoading:(NSString *)msg{
    loadingview = [[MBProgressHUD alloc] initWithView:self.view];
    loadingview.labelText = msg;
    loadingview.animationType = MBProgressHUDAnimationFade;
    loadingview.mode = MBProgressHUDModeIndeterminate;
    loadingview.removeFromSuperViewOnHide = YES;
    [self.view addSubview:loadingview];
    [loadingview show:YES];
}

-(void)stopLoading{
    [loadingview hide:YES];
    if(loadingview){
        [loadingview removeFromSuperViewOnHide];
    }
}

- (void)startLoading:(NSString *)msg offsetY:(float)offsetY
{
    loadingview = [[MBProgressHUD alloc] initWithView:self.view];
    loadingview.labelText = msg;
    loadingview.yOffset = offsetY;
    loadingview.animationType = MBProgressHUDAnimationFade;
    loadingview.mode = MBProgressHUDModeIndeterminate;
    loadingview.removeFromSuperViewOnHide = YES;
    [self.view addSubview:loadingview];
    [loadingview show:YES];
}

- (void)startLoadingWithRightYAndTitle:(NSString *)title
{
    if ([UIManage is568])
    {
        [self startLoading:title offsetY:-70];
    }
    else
    {
        [self startLoading:title offsetY:-70];
    }
}

- (void)showInfoMessageWithRightY:(NSString *)msg
{
    if ([UIManage is568])
    {
        [self showInfoMessage:msg offsetY:-35];
    }
    else
    {
        [self showInfoMessage:msg offsetY:-35];
    }
}

- (void)showErrorMessageWithRightY:(NSString *)msg
{
    if ([UIManage is568])
    {
        [self showErrorMessage:msg offsetY:-35];
    }
    else
    {
        [self showErrorMessage:msg offsetY:-35];
    }
}

- (void)showSuccessMessageDelayPopViewWithTilte:(NSString *)title
{
    [self showInfoMessageWithRightY:title];
    [self performSelector:@selector(delayPopView) withObject:nil afterDelay:0.8];
}

- (void)showFailMessageDelayPopView:(NSString *)title
{
    [self showErrorMessageWithRightY:title];
    [self performSelector:@selector(delayPopView) withObject:nil afterDelay:0.8];
}

- (void)delayPopView
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark ios6横屏

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}


@end
