//
//  LMModelInfoView.m
//  LMGallery
//
//  Created by itenyh on 13-11-6.
//  Copyright (c) 2013年 lmodel. All rights reserved.
//

#import "LMModelInfoView.h"
#import "LMBasicDBOperator.h"
#import "LMCategoryBo.h"

@implementation LMModelInfoView
@synthesize saveBtn, isShown;

- (id)initWithParameter:(BOOL)isShowed isSaved:(BOOL)isSaved
{
    self = [super init];
    
    if (self) {
        
        self.isShown = isShowed;
        
        if (isSaved) {
            saveBtn.tag = 1;
            saveBtn.alpha = 0.5;
        }
        
        if (isShowed) {
            
            [self showDataPanel];
            
        }
        
    }
    
    return self;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImage *bgImg = [UIImage imageNamed:@"album_bottombg"];
        float heightOfView = bgImg.size.height + 15;
        rightMargin = 30;
        leftMargin = 32;
        contentLeftMargin = 15;
        float labelAlpha = 0.8;
        
        self.frame = CGRectMake(0, [UIManage getAppHeight] - heightOfView + LMStatusBarHeight , [UIManage getAppWidth], heightOfView);
        self.backgroundColor = [UIColor clearColor];
        
        UIImage *dataBgimg = [UIImage imageNamed:@"bg_beizhuxiangxiye"];
        dataBgView = [[UIView alloc] init];
        dataBgView.backgroundColor = [UIColor colorWithPatternImage:dataBgimg];
        dataBgView.frame = CGRectMake(0, 0, dataBgimg.size.width, 0);
        dataBgView.tag = 0;
        dataBgView.alpha = 0;
        [self addSubview:dataBgView];
        
        bottomView = [[UIImageView alloc] init];
        bottomView.frame = CGRectMake(0, 0, self.frame.size.width, heightOfView);
        bottomView.image = bgImg;
        [self addSubview:bottomView];
        
        UIImage *userImg = [UIImage imageNamed:@"btn_userdetail"];
        userBtn = [[UIButton alloc] init];
        userBtn.adjustsImageWhenHighlighted = NO;
        userBtn.frame = CGRectMake(leftMargin + 75, (heightOfView - userImg.size.width) / 2, userImg.size.width, userImg.size.height);
        [userBtn addTarget:self action:@selector(userBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [userBtn setBackgroundImage:userImg forState:UIControlStateNormal];
        [self addSubview:userBtn];

        UIImage *saveImg = [UIImage imageNamed:@"btn_saveuser"];
        saveBtn = [[UIButton alloc] init];
        saveBtn.adjustsImageWhenHighlighted = NO;
        saveBtn.frame = CGRectMake([UIManage xFromLeftView:userBtn] + 75, (heightOfView - saveImg.size.height * 0.8) / 2, saveImg.size.width * 0.8, saveImg.size.height * 0.8);
        [saveBtn setBackgroundImage:saveImg forState:UIControlStateNormal];
        saveBtn.tag = 0;
        [saveBtn addTarget:self action:@selector(saveBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:saveBtn];
        
        backBtn = [[UIButton alloc] init];
        UIImage *upImage = [UIImage imageNamed:@"back_button_arrow"];
        backBtn.frame = CGRectMake(leftMargin, (heightOfView - upImage.size.height) / 2, upImage.size.width, upImage.size.height);
        [backBtn setBackgroundImage:upImage forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backBtn];
        
        //------------------------ 数据分割线 ---------------------------
        
        nameBtn = [[UIButton alloc] init];
        nameBtn.backgroundColor = [UIColor clearColor];
        nameBtn.frame = CGRectMake(contentLeftMargin, 5, 0, 0);
        nameBtn.alpha = labelAlpha;
        [nameBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [nameBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [dataBgView addSubview:nameBtn];
     
        lable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, nameBtn.frame.origin.y + 1.5, 0, 0)];
        lable1.backgroundColor = [UIColor clearColor];
        lable1.textColor = [UIColor whiteColor];
        lable1.alpha = labelAlpha;
        lable1.textAlignment = NSTextAlignmentRight;
        lable1.font = [UIFont boldSystemFontOfSize:14];
        [dataBgView addSubview:lable1];
        
        lable2 = [[UILabel alloc] initWithFrame:CGRectMake(contentLeftMargin, 0, 0, 0)];
        lable2.backgroundColor = [UIColor clearColor];
        lable2.textColor = [UIColor whiteColor];
        lable2.textAlignment = NSTextAlignmentRight;
        lable2.font = [UIFont boldSystemFontOfSize:15];
        lable2.alpha = labelAlpha;
        [dataBgView addSubview:lable2];
        
    }

    return self;
}

- (void)displayWith:(LMModelBo *)bo
{
    [nameBtn setTitle:bo.name forState:UIControlStateNormal];
    CGSize sizeOfname = [UIManage text:nameBtn.titleLabel.text sizeWithFont:nameBtn.titleLabel.font constrainedToSize:CGSizeMake(INT16_MAX, nameBtn.titleLabel.font.lineHeight)];
    nameBtn.frame = CGRectMake(contentLeftMargin + 1, nameBtn.frame.origin.y, sizeOfname.width, sizeOfname.height);
    
    [self createCatStrByMid:[bo getStrMid]];
    
    lable2.text = [NSString stringWithFormat:@"%d %d/%d/%d %d 眼睛 %@ 头发 %@", (int)bo.height, (int)bo.bust, (int)bo.waist, (int)bo.hips, (int)bo.shoesSize, bo.eyesColor, bo.hairColor];
    CGSize sizeOfData = [UIManage text:lable2.text sizeWithFont:lable2.font constrainedToSize:CGSizeMake(INT16_MAX, lable2.font.lineHeight)];
    lable2.frame = CGRectMake(contentLeftMargin, [UIManage yFromTopView:nameBtn], sizeOfData.width, sizeOfData.height);
}

- (void)userBtnEvent:(id)sender
{
    self.isShown = [self changeDataPanelState];
    
    if ([_delegate respondsToSelector:@selector(lMModelInfoViewClickUserBtn:)]) {
        [_delegate lMModelInfoViewClickUserBtn:self];
    }
    
}

- (void)showDataPanel
{
    UIImage *dataBgimg = [UIImage imageNamed:@"bg_beizhuxiangxiye"];
    userBtn.alpha = 0.5;
    dataBgView.frame = CGRectMake(0, -dataBgimg.size.height, dataBgimg.size.width, dataBgimg.size.height);
    dataBgView.alpha = 1;
    dataBgView.tag = 1;
  
}

- (BOOL)changeDataPanelState
{
    UIImage *dataBgimg = [UIImage imageNamed:@"bg_beizhuxiangxiye"];
    
    if (dataBgView.tag == 0) {
        
        userBtn.alpha = 0.5;
        
        [UIView animateWithDuration:0.3 animations:^{
            dataBgView.frame = CGRectMake(0, -dataBgimg.size.height, dataBgimg.size.width, dataBgimg.size.height);
            dataBgView.alpha = 1;
        }
         
                         completion:^(BOOL finished) {
                             dataBgView.tag = 1;
                             
                         }];
        
        return YES;
        
    }
    
    else {
        
        userBtn.alpha = 1;
        
        [UIView animateWithDuration:0.3 animations:^{
            dataBgView.frame = CGRectMake(0, 0, dataBgimg.size.width, 0);
            dataBgView.alpha = 0;
        }
         
                         completion:^(BOOL finished) {
                             dataBgView.tag = 0;
                             
                        }];
        
        return NO;
        
    }
}

- (void)saveBtnEvent:(id)sender
{
    
    if (saveBtn.tag == 0) {
        saveBtn.alpha = 0.5;
        saveBtn.tag = 1;
    }
    
    else {
        saveBtn.alpha = 1;
        saveBtn.tag = 0;
    }
    
    if ([_delegate respondsToSelector:@selector(lMModelInfoViewClickSaveBtn:)]) {
        [_delegate lMModelInfoViewClickSaveBtn:self];
    }
    
}

- (void)createCatStrByMid:(NSString *)mid
{
    NSMutableString *result = [NSMutableString string];
    
    [LMBasicDBOperator getAllCatsWithMId:mid callback:^(NSMutableArray *array) {
        
        BOOL firstIndex = YES;
        for (LMCategoryBo *bo in array) {
            if (firstIndex) {
                [result appendString:@"- "];
                [result appendString:bo.name];
                firstIndex = NO;
            }
            
            else {
                [result appendString:@" "];
                [result appendString:bo.name];
            }
            
        }
        
        lable1.text = result;
        CGSize sizeOfCat = [UIManage text:lable1.text sizeWithFont:lable1.font constrainedToSize:CGSizeMake(INT16_MAX, lable1.font.lineHeight)];
        lable1.frame = CGRectMake([UIManage xFromLeftView:nameBtn] + 5, lable1.frame.origin.y, sizeOfCat.width, sizeOfCat.height);
        
    }];
    
    
}

- (void)clickBack
{
    if ([_delegate respondsToSelector:@selector(lMModelInfoViewClickBack:)]) {
        [_delegate lMModelInfoViewClickBack:self];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


@end
