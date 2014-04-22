//
//  BKBaseViewController.m
//  iRally
//
//  Created by 蔡凌 on 13-9-4.
//  Copyright (c) 2013年 蔡凌. All rights reserved.
//

#import "BKBaseViewController.h"
#import "BKAlertView.h"
#import "MBProgressHUD.h"

#define StatusBarHeight 20

static UIImage *_navigationBarImage;

@implementation BKNavigationBar

- (id)init
{
    if([BKBaseFunctions getIosVer] >= 7.0)
    {
        return [self initWithFrame:CGRectMake(0, 0, 320, 44 + StatusBarHeight)];
    }
    else
    {
        return [self initWithFrame:CGRectMake(0, 0, 320, 44)];
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _navBackImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:_navBackImageView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor whiteColor];

        [self setTitleLabelFont:[UIFont boldSystemFontOfSize:20]];
        [self addSubview:_titleLabel];
    }
    return self;
}
- (void)setTitleLabelFont:(UIFont *)font
{
    _titleLabel.font = font;
    float offset = 0;
    if([BKBaseFunctions getIosVer] >= 7.0)
    {
        offset = 7;
    }
    _titleLabel.frame = CGRectMake(0, (self.frame.size.height - font.lineHeight) / 2 + offset, [UIManage getAppWidth], font.lineHeight);
}

@end

@interface BKBaseViewController ()
{
    MBProgressHUD *loadingview;
}
@end

@implementation BKBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        _BKNavigationBar = [[BKNavigationBar alloc] init];
        
        if(_navigationBarImage==nil)
        {
            _navigationBarImage = [self navigationBarImage];
        }

        _BKNavigationBar.navBackImageView.image = _navigationBarImage;
        
        float width = [UIManage getAppWidth];
        float height = [UIManage getAppHeight] - 44; //只需减去navbar的高度，getappheight本来不包括状态栏高度ß
        if([BKBaseFunctions getIosVer] >= 7.0)
        {
            [self setNeedsStatusBarAppearanceUpdate];
        }

        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, _BKNavigationBar.frame.size.height, width, height)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.view addSubview:_BKNavigationBar];
    
    self.view.backgroundColor = [UIColor grayColor];
    self.contentView.backgroundColor = self.view.backgroundColor;
	
    [self.view addSubview:self.contentView];
	
	self.contentView.clipsToBounds = YES;
	self.view.clipsToBounds = YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (CGFloat)contentWidth
{
    return self.contentView.frame.size.width;
}

- (CGFloat)contentHeight
{
    return self.contentView.frame.size.height;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)navigationBarImage
{
    return Nil;
}

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];

    self.BKNavigationBar.titleLabel.text = title;
}

- (void)addSubViewInContentView:(UIView *)view
{
    [self.contentView addSubview:view];
}

- (void)setBKNavigationBarHideWithSlide:(BOOL)hide  withAnimated:(BOOL)animated{
	if(hide)
    {
        if([BKBaseFunctions getIosVer] >= 7.0)
        {
            if(animated)
            {
                [UIView animateWithDuration:0.5 animations:^{
                    self.BKNavigationBar.frame = CGRectMake(0, 0 - self.BKNavigationBar.frame.size.height, self.BKNavigationBar.frame.size.width, self.BKNavigationBar.frame.size.height);
                    self.contentView.frame = CGRectMake(0, 0, [UIManage getAppWidth], [UIManage getAppHeight]);
                } completion:^(BOOL finished) {
                    
                }];
            }
            else
            {
                self.BKNavigationBar.frame = CGRectMake(0, 0 - self.BKNavigationBar.frame.size.height, self.BKNavigationBar.frame.size.width, self.BKNavigationBar.frame.size.height);
                self.contentView.frame = CGRectMake(0, 0, [UIManage getAppWidth], [UIManage getAppHeight]);
            }
        }
        else
        {
//            NSLog(@"%d", [UIApplication sharedApplication].statusBarHidden);
//            NSLog(@"%f", [UIManage getAppHeight]);
			if(![UIApplication sharedApplication].statusBarHidden) {
                if(animated)
                {
                    [UIView animateWithDuration:0.5 animations:^{
                        self.BKNavigationBar.frame = CGRectMake(0, 0 - self.BKNavigationBar.frame.size.height, self.BKNavigationBar.frame.size.width, self.BKNavigationBar.frame.size.height);
                        self.contentView.frame = CGRectMake(0, 0, [UIManage getAppWidth], [UIManage getAppHeight] - 20);
                    } completion:^(BOOL finished) {
                        
                    }];
                }
                else
                {
                    self.BKNavigationBar.frame = CGRectMake(0, 0 - self.BKNavigationBar.frame.size.height, self.BKNavigationBar.frame.size.width, self.BKNavigationBar.frame.size.height);
                    self.contentView.frame = CGRectMake(0, 0, [UIManage getAppWidth], [UIManage getAppHeight] - 20);
                }

            } else {
                if(animated)
                {
                    [UIView animateWithDuration:0.5 animations:^{
                        self.BKNavigationBar.frame = CGRectMake(0, 0 - self.BKNavigationBar.frame.size.height - 20, self.BKNavigationBar.frame.size.width, self.BKNavigationBar.frame.size.height);
                        self.contentView.frame = CGRectMake(0, -20, [UIManage getAppWidth], [UIManage getAppHeight]);
                    } completion:^(BOOL finished) {
                        
                    }];
                }
                else
                {
                    self.BKNavigationBar.frame = CGRectMake(0, 0 - self.BKNavigationBar.frame.size.height - 20, self.BKNavigationBar.frame.size.width, self.BKNavigationBar.frame.size.height);
                    self.contentView.frame = CGRectMake(0, -20, [UIManage getAppWidth], [UIManage getAppHeight]);
                }
			}
        }
    }
    else
    {
        self.BKNavigationBar.frame = CGRectMake(0, 0, self.BKNavigationBar.frame.size.width, self.BKNavigationBar.frame.size.height);
        float width = [UIManage getAppWidth];
        float height = [UIManage getAppHeight] - _BKNavigationBar.frame.size.height;
        if([BKBaseFunctions getIosVer] >= 7.0)
        {
            [self setNeedsStatusBarAppearanceUpdate];
        } else {
			height -= 20;
		}
		//        else
		//        {
		//            if(![UIApplication sharedApplication].statusBarHidden)
		//                height -= StatusBarHeight;
		//        }
        self.contentView.frame = CGRectMake(0, _BKNavigationBar.frame.size.height, width, height);
    }
}

- (void)setBKNavigationBarHide:(BOOL)hide
{
    if(hide)
    {
        self.BKNavigationBar.hidden = YES;
        if([BKBaseFunctions getIosVer] >= 7.0)
        {
             self.contentView.frame = CGRectMake(0, 0, [UIManage getAppWidth], [UIManage getAppHeight]);
        }
        else
        {
            if(![UIApplication sharedApplication].statusBarHidden)
                self.contentView.frame = CGRectMake(0, 0, [UIManage getAppWidth], [UIManage getAppHeight] - 20);
            else
                self.contentView.frame = CGRectMake(0, 0, [UIManage getAppWidth], [UIManage getAppHeight]);
        }
    }
    else
    {
        self.BKNavigationBar.hidden = NO;
        float width = [UIManage getAppWidth];
        float height = [UIManage getAppHeight] - _BKNavigationBar.frame.size.height;
        if([BKBaseFunctions getIosVer] >= 7.0)
        {
            [self setNeedsStatusBarAppearanceUpdate];
        }
//        else
//        {
//            if(![UIApplication sharedApplication].statusBarHidden)
//                height -= StatusBarHeight;
//        }
        self.contentView.frame = CGRectMake(0, _BKNavigationBar.frame.size.height, width, height);
    }
}

- (void)clickLeftBtnEvent:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickRightBtnEvent:(id)sender
{
    
}

- (float)navBtnOffsetX:(BKNavBtnType)type
{
    return 5;
}

- (float)navBtnBottomOffsetY:(BKNavBtnType)type
{
    return 0;
}

- (void)setNavTitle:(NSString *)title
{
    self.title = title;
}

- (void)setNavLeftBarBtnType:(BKNavBtnType)leftType AndLeftTitle:(NSString *)leftTitle RightBarBtnType:(BKNavBtnType)rightType AndRightTitle:(NSString *)rightTitle
{
    [self setNavTitle:nil LeftBarBtnType:leftType AndLeftTitle:leftTitle RightBarBtnType:rightType AndRightTitle:rightTitle];
}

- (void)setNavTitle:(NSString *)title LeftBarBtnType:(BKNavBtnType)leftType AndLeftTitle:(NSString *)leftTitle RightBarBtnType:(BKNavBtnType)rightType AndRightTitle:(NSString *)rightTitle
{
    [self setTitle:title];
    
    [self setNavLeftBarBtnType:leftType AndLeftTitle:leftTitle];
    [self setNavRightBarBtnType:rightType AndRightTitle:rightTitle];
    
}

- (void)setNavLeftBarBtnType:(BKNavBtnType)leftType AndLeftTitle:(NSString *)leftTitle
{
    leftBtnType = leftType;
    
    if(leftTitle != nil && leftType != BKNavBtnNone)
    {
        //        [_leftBtn removeFromSuperview];
        if(_leftBtn == nil)
        {
            _leftBtn = [self createNavBtn:leftBtnType];
            [_leftBtn addTarget:self action:@selector(clickLeftBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
            //            _leftBtn.frame = CGRectOffset(_leftBtn.frame, 5, 7);
            [_BKNavigationBar addSubview:_leftBtn];
            
        }
        
        
        [_leftBtn setTitle:leftTitle forState:UIControlStateNormal];
        
        [_leftBtn sizeToFit];
        
        float width = 0;
        float offsetX = [self navBtnOffsetX:leftBtnType];
        float offsetY = self.BKNavigationBar.frame.size.height - _leftBtn.frame.size.height - [self navBtnBottomOffsetY:leftBtnType];
        
        if(BKNavBtnRoundType == leftBtnType)
        {
            CGSize size = [leftTitle sizeWithFont:_leftBtn.titleLabel.font];
            width = size.width + 18;
//            offsetX ;
        }
        else if(BKNavCustomType == leftBtnType)// || leftBtnType == BKNavLeftBackType)
        {
            _leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            _leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, [self navBtnOffsetX:leftBtnType], 0, 0);
            offsetX = 0;
        }
        
        if(width < 44)
            width = 44;
        
        _leftBtn.frame = CGRectMake(offsetX, offsetY, width, _leftBtn.frame.size.height);
    }
}

- (void)setNavRightBarBtnType:(BKNavBtnType)rightType AndRightTitle:(NSString *)rightTitle
{
    rightBtnType = rightType;
    
    if(rightTitle != nil && rightType != BKNavBtnNone)
    {
        if(_rightBtn == nil)
        {
            _rightBtn = [self createNavBtn:rightBtnType];
            [_rightBtn addTarget:self action:@selector(clickRightBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
            [_BKNavigationBar addSubview:_rightBtn];
        }
        
        CGSize size;
        if (rightTitle != nil && rightTitle.length > 0) {
            size = [rightTitle sizeWithFont:_rightBtn.titleLabel.font];
            [_rightBtn setTitle:rightTitle forState:UIControlStateNormal];
        } else {
            size = _rightBtn.currentBackgroundImage.size;
        }
        [_rightBtn sizeToFit];
        
        float offsetX = 0;
        float offsetY = self.BKNavigationBar.frame.size.height - _rightBtn.frame.size.height - [self navBtnBottomOffsetY:rightBtnType];
        if(rightBtnType == BKNavCustomType || rightBtnType == BKNavLeftBackType)
        {
            _rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            _rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, [self navBtnOffsetX:rightBtnType]);
            
            offsetX = [self navBtnOffsetX:rightBtnType];
        }
        else if(rightBtnType == BKNavBtnRoundType)
        {
            offsetX = [self navBtnOffsetX:rightBtnType];
        }
        
        _rightBtn.backgroundColor = [UIColor redColor];
        _rightBtn.frame = CGRectMake(_BKNavigationBar.frame.size.width - _rightBtn.frame.size.width - offsetX, offsetY,_rightBtn.frame.size.width, _rightBtn.frame.size.height);

    }
}

- (void)setLeftBtnImage:(UIImage *)image
{
    if(_leftBtn == nil)
    {
        _leftBtn = [self createNavBtn:BKNavCustomType];
        [_BKNavigationBar addSubview:_leftBtn];
        [_leftBtn addTarget:self action:@selector(clickLeftBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    [_leftBtn setBackgroundImage:image forState:UIControlStateNormal];
    [self setNavLeftBarBtnType:BKNavCustomType AndLeftTitle:@""];
}

- (void)setRightBtnImage:(UIImage *)image
{
    if(_rightBtn == nil)
    {
        _rightBtn = [self createNavBtn:BKNavCustomType];
        [_BKNavigationBar addSubview:_rightBtn];
        [_rightBtn addTarget:self action:@selector(clickRightBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    [_rightBtn setBackgroundImage:image forState:UIControlStateNormal];
    
    float offSetX = 20;
    float offSetY = (_BKNavigationBar.frame.size.height - image.size.height) / 1.6;
    
    _rightBtn.frame = CGRectMake([UIManage getAppWidth] - image.size.width - offSetX, offSetY, image.size.width, image.size.height);
    
//    [self setNavRightBarBtnType:BKNavCustomType AndRightTitle:@""];
}

- (void)setLeftBtnTopImg:(UIImage *)image
{
    if(_leftBtn == nil)
    {
        _leftBtn = [self createNavBtn:BKNavCustomType];
        [_BKNavigationBar addSubview:_leftBtn];
        [_leftBtn addTarget:self action:@selector(clickLeftBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [_leftBtn setImage:image forState:UIControlStateNormal];
    [self setNavLeftBarBtnType:BKNavCustomType AndLeftTitle:@""];
}

- (void)setRightBtnTopImg:(UIImage *)image
{
    if(_rightBtn == nil)
    {
        _rightBtn = [self createNavBtn:BKNavCustomType];
        [_BKNavigationBar addSubview:_rightBtn];
        [_rightBtn addTarget:self action:@selector(clickRightBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [_rightBtn setImage:image forState:UIControlStateNormal];
    [self setNavRightBarBtnType:BKNavCustomType AndRightTitle:@""];
}


- (UIImage *)getNavBtnImageWithBtnType:(BKNavBtnType)btnType
{
    UIImage *btnImage = [[UIImage imageNamed:@"button1"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 13, 0, 13)];
    //    switch (btnType) {
    //        case BKNavBtnNone:
    //            return nil;
    //            break;
    //        case BKNavBtnRoundType:
    //
    //            //            btnHightlightedImage = [UIImage imageNamed:@"top_button_press"];
    //            break;
    //        case BKNavLeftBackType:
    //            btnImage = [UIImage imageNamed:@"button1"];
    //            //            btnHightlightedImage = [UIImage imageNamed:@"Topbar_back_button_press"];
    //
    //            break;
    //        default:
    //            break;
    //    }
    
    return btnImage;
}

- (UIButton *)createNavBtn:(BKNavBtnType)type
{
    UIButton *button = [[UIButton alloc] init];
    
    button.backgroundColor = [UIColor whiteColor];
    
    [button setTitleColor:[UIColor colorWithRed:114.0f/255.0f green:106.0f/255.0f blue:94.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [button setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [button setTitleShadowColor:[UIColor colorWithRed:114.0f/255.0f green:106.0f/255.0f blue:94.0f/255.0f alpha:1.0f] forState:UIControlStateHighlighted];
    //    button.titleLabel.shadowColor = [UIColor whiteColor];
    button.titleLabel.shadowOffset = CGSizeMake(0,1);
    button.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    return button;
}

- (void)showErrorMessage:(NSString *)msg
{
    [self showErrorMessage:msg offsetY:0];
}
- (void)showInfoMessage:(NSString *)msg
{
    [self showInfoMessage:msg offsetY:0];
}

- (void)showErrorMessage:(NSString *)msg offsetY:(float)offsetY
{
    [BKAlertView showErrorMsg:msg inview:self.view offsetY:offsetY];
}

- (void)showInfoMessage:(NSString *)msg offsetY:(float)offsetY
{
    [BKAlertView showInfoMsg:msg inview:self.view offsetY:offsetY];
}

-(void)startLoading:(NSString *)msg{
    loadingview = [[MBProgressHUD alloc] initWithView:self.view];
    loadingview.labelText = msg;
    loadingview.animationType = MBProgressHUDAnimationFade;
    loadingview.mode = MBProgressHUDModeIndeterminate;
    loadingview.removeFromSuperViewOnHide = YES;
    loadingview.color = [UIManage color:@"484d55" alpha:0.9];
    [self.view addSubview:loadingview];
    [loadingview show:YES];
}

-(void)stopLoading{
    [loadingview hide:YES];
    if(loadingview){
        [loadingview removeFromSuperViewOnHide];
        loadingview = nil;
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
    loadingview.color = [UIManage color:@"484d55" alpha:0.9];
//    loadingview.opaque = YES;
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
        [self startLoading:title offsetY:-110];
    }
}

- (void)showInfoMessageWithRightY:(NSString *)msg
{
    if (![UIManage is568])
    {
        [self showInfoMessage:msg offsetY:-70];
    }
    else
    {
        [self showInfoMessage:msg offsetY:-90];
    }
}

- (void)showErrorMessageWithRightY:(NSString *)msg
{
    if (![UIManage is568])
    {
        [self showErrorMessage:msg offsetY:-70];
    }
    else
    {
        [self showErrorMessage:msg offsetY:-90];
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

@end
