//
//  LMSavedModelBo.m
//  LMGallery
//
//  Created by Apple on 14-1-20.
//  Copyright (c) 2014年 lmodel. All rights reserved.
//

#import "LMSavedModelBo.h"

@implementation LMSavedModelBo

+ (NSString *)getPrimaryKey
{
    return @"mid";
}

+ (LMSavedModelBo *)createLMSavedModelBoWith:(BOOL)isSaved mid:(NSString *)mid
{
    LMSavedModelBo *lm = [[LMSavedModelBo alloc] init];
    lm.isSaved = isSaved;
    lm.mid = mid;
    
    return lm;
}

+(NSString *)getTableName
{
    return @"LMSavedModel";
}

@end
