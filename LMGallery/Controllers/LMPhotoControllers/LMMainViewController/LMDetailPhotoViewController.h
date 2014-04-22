//
//  LMDetailPhotoViewController.h
//  LMGallery
//
//  Created by itenyh on 13-10-30.
//  Copyright (c) 2013年 lmodel. All rights reserved.
//

#import "LMBasicViewController.h"
#import "LMModelInfoView.h"
#import "LMModelBo.h"

@interface LMDetailPhotoViewController : LMBasicViewController
{
    LMModelInfoView *infoView;
}

@property (nonatomic, strong) LMModelBo *curModelBo;

@end
