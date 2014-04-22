//
//  MTBaseViewController.h
//  MumTools2
//
//  Created by 蔡凌 on 13-3-24.
//  Copyright (c) 2013年 蔡凌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIManage.h"
#import "BKBaseFunctions.h"
#import "LMAppDelegate.h"
#import "BKUIUtil.h"
#import "MBProgressHUD.h"

#define MT_NAV_HEIGHT 0.0f
#define MT_TAB_HEIGHT 49.0f
#define NAV_BAR_HEIGHT 44.5f

typedef enum 
{
    BKNavBtnNone,
    BKNavBtnRoundType,
    BKNavLeftBackType,
    BKNavBtnMore
    
} BKNavBtnType;
typedef enum
{
    BKCONTROLLERVIDEOTYPE=0,
    BKCONTROLLERIMGTYPE=1,
    BKCONTROLLERFILETYPE=2,
    
} BKCONTROLLERTYPE;
@interface BKBaseViewController : UIViewController
{
    UIView *_navigationBar;
    
    UIImageView *backgroundView;
    BKNavBtnType leftBtnType;
    BKNavBtnType rightBtnType;
    MBProgressHUD *loadingview;

}

@property (strong, nonatomic) UIView *contentView;
@property (assign, nonatomic) BOOL showIconLogo;
@property (strong, nonatomic) UIButton *leftBtn;
@property (strong, nonatomic) UIButton *rightBtn;

- (void)hideTheNaviBar;
- (void)showTheNaviBar;
- (void)hideTheNaviBarAnimated:(BOOL)animated;
- (void)setNavigationBarImage:(UIImage *)navImage;
- (void)setNavigationBarTitleView:(UIView *)view;

- (void)setScrollDetailViewTitle:(NSString *)title;
- (void)setNavTitle:(NSString *)title;
- (void)setNavTitle:(NSString *)title
             LeftBarBtnType:(BKNavBtnType)leftType
                AndLeftTitle:(NSString*)leftTitle
             RightBarBtnType:(BKNavBtnType)rightType
               AndRightTitle:(NSString*)rightTitle;
- (void)setNavLeftBarBtnType:(BKNavBtnType)leftType AndLeftTitle:(NSString *)leftTitle RightBarBtnType:(BKNavBtnType)rightType AndRightTitle:(NSString *)rightTitle;

- (void)clickLeftBtnEvent:(id)sender;
- (void)clickRightBtnEvent:(id)sender;
- (void)setTheRightNavigationItemEnabledWith:(BOOL)isEnabled;       

-(void)showErrorMessage:(NSString *)msg offsetY:(float)offsetY;
-(void)showInfoMessage:(NSString *)msg offsetY:(float)offsetY;
-(void)startLoading:(NSString *)msg;
-(void)stopLoading;
- (void)startLoading:(NSString *)msg offsetY:(float)offsetY;

- (void)startLoadingWithRightYAndTitle:(NSString *)title;
- (void)showInfoMessageWithRightY:(NSString *)msg;
- (void)showErrorMessageWithRightY:(NSString *)msg;
- (void)showSuccessMessageDelayPopViewWithTilte:(NSString *)title;
- (void)showFailMessageDelayPopView:(NSString *)title;

- (void)notifySuccess;
- (void)notifyFail;
- (void)notifySuccessWithTitle:(NSString *)title;
- (void)notifyFailWithTitle:(NSString *)title;
+(void)hidden:(UITabBarController *)tabbarcontroller isHidden:(BOOL)hidden;

- (void)disableRightButton;
- (void)recoverRightButton;

- (void)refreshLocData;

@end
