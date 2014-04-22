//
//  BKBaseViewController.h
//  iRally
//
//  Created by 蔡凌 on 13-9-4.
//  Copyright (c) 2013年 蔡凌. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    BKNavBtnNone,
    BKNavBtnRoundType,
    BKNavLeftBackType,
    BKNavCustomType
    
} BKNavBtnType;

@interface BKNavigationBar : UIView
{
    
}
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *navBackImageView;
- (void)setTitleLabelFont:(UIFont *)font;

@end

@interface BKBaseViewController : UIViewController
{
//    BKNavigationBar *_BKNavigationBar;
    BKNavBtnType leftBtnType;
    BKNavBtnType rightBtnType;
}

@property (strong, nonatomic) BKNavigationBar *BKNavigationBar;
@property (strong, nonatomic) UIView *contentView;
@property (nonatomic, assign) CGFloat contentHeight;
@property (nonatomic, assign) CGFloat contentWidth;
@property (strong, nonatomic) UIButton *leftBtn;
@property (strong, nonatomic) UIButton *rightBtn;

//添加subview特定方法，用来兼容ios7和之前的版本
- (void)addSubViewInContentView:(UIView *)view;

//navigation定制
- (UIImage *)navigationBarImage;
- (float)navBtnOffsetX:(BKNavBtnType)type;
- (float)navBtnBottomOffsetY:(BKNavBtnType)type;
- (void)setBKNavigationBarHideWithSlide:(BOOL)hide withAnimated:(BOOL)animated;
- (void)setBKNavigationBarHide:(BOOL)hide;
//navigation相关方法
- (void)setNavTitle:(NSString *)title;
- (void)setNavLeftBarBtnType:(BKNavBtnType)leftType
                AndLeftTitle:(NSString*)leftTitle
             RightBarBtnType:(BKNavBtnType)rightType
               AndRightTitle:(NSString*)rightTitle;

- (void)setNavTitle:(NSString *)title
     LeftBarBtnType:(BKNavBtnType)leftType
       AndLeftTitle:(NSString*)leftTitle
    RightBarBtnType:(BKNavBtnType)rightType
      AndRightTitle:(NSString*)rightTitle;

- (void)setNavLeftBarBtnType:(BKNavBtnType)leftType
                AndLeftTitle:(NSString*)leftTitle;

- (void)setNavRightBarBtnType:(BKNavBtnType)rightType
                AndRightTitle:(NSString*)rightTitle;

- (void)setLeftBtnImage:(UIImage *)image;
- (void)setRightBtnImage:(UIImage *)image;
//- (void)setRightBtnWidth:(float)targetWidth;
- (void)setLeftBtnTopImg:(UIImage*)image;
- (void)setRightBtnTopImg:(UIImage*)image;

- (UIButton *)createNavBtn:(BKNavBtnType)type;

- (void)clickLeftBtnEvent:(id)sender;
- (void)clickRightBtnEvent:(id)sender;

-(void)showErrorMessage:(NSString *)msg;
-(void)showInfoMessage:(NSString *)msg;
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

@end
