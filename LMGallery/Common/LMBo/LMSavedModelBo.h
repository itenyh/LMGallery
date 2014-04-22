//
//  LMSavedModelBo.h
//  LMGallery
//
//  Created by Apple on 14-1-20.
//  Copyright (c) 2014年 lmodel. All rights reserved.
//

#import "LMBaseBo.h"

@interface LMSavedModelBo : LMBaseBo

@property (nonatomic, assign) BOOL isSaved;
@property (nonatomic, strong) NSString *mid;

+ (LMSavedModelBo *)createLMSavedModelBoWith:(BOOL)isSaved mid:(NSString *)mid;

@end
