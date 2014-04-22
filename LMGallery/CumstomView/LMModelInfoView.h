//
//  LMModelInfoView.h
//  LMGallery
//
//  Created by itenyh on 13-11-6.
//  Copyright (c) 2013年 lmodel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LMModelInfoView;
@protocol LMModelInfoViewDelegate <NSObject>

- (void)lMModelInfoViewClickBack:(LMModelInfoView *)lmInfoView;
- (void)lMModelInfoViewClickSaveBtn:(LMModelInfoView *)lmInfoView;
- (void)lMModelInfoViewClickUserBtn:(LMModelInfoView *)lmInfoView;

@end

@interface LMModelInfoView : UIView
{
    UILabel *lable1;
    UILabel *lable2;
    
    UIImageView *bottomView;
    UIView *dataBgView;
    UIButton *nameBtn;
    UIButton *backBtn;
    UIButton *saveBtn;
    UIButton *userBtn;
    
    float rightMargin;
    float leftMargin;
    float contentLeftMargin;
}

@property (nonatomic, strong) id<LMModelInfoViewDelegate> delegate;
@property (nonatomic, strong) UIButton *saveBtn;
@property (nonatomic, assign) BOOL isSaved;
@property (nonatomic, assign) BOOL isShown;

- (id)initWithParameter:(BOOL)isShowed isSaved:(BOOL)isSaved;
- (void)displayWith:(id)what;

@end
