//
//  LMModel+LMCategory.h
//  LMGallery
//
//  Created by Apple on 14-1-3.
//  Copyright (c) 2014年 lmodel. All rights reserved.
//

#import "LMBaseBo.h"
#import "LMCategoryBo.h"
#import "LMModelBo.h"

@interface LMModel_LMCategory : LMBaseBo

@property (nonatomic, strong) NSString *mid;
@property (nonatomic, strong) NSString *cid;
@property (nonatomic, strong) NSString *tid;

+ (LMModel_LMCategory *)createLMCategoryBoWith:(NSString *)mid catBo:(NSString *)cid tid:(NSString *)tid;
+ (LMModel_LMCategory *)createModelWith:(NSDictionary *)dic;

@end
