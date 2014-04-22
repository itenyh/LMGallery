//
//  LMCategoryBo.h
//  LMGallery
//
//  Created by Apple on 14-1-3.
//  Copyright (c) 2014年 lmodel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LMBaseBo.h"

@interface LMCategoryBo : LMBaseBo

@property(strong, nonatomic) NSString *cid;
@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *enName;
@property(strong, nonatomic) NSString *color;

+ (LMCategoryBo *)createLMCategoryBoWith:(NSString *)cid name:(NSString *)name enName:(NSString *)enName color:(NSString *)color;
+ (LMCategoryBo *)createLMCategoryBoWith:(NSDictionary *)dic;

@end
