//
//  LMModel+LMCategory.m
//  LMGallery
//
//  Created by Apple on 14-1-3.
//  Copyright (c) 2014年 lmodel. All rights reserved.
//

#import "LMModel+LMCategory.h"

@implementation LMModel_LMCategory

+ (NSString *)getPrimaryKey
{
    return @"tid";
}

+ (LMModel_LMCategory *)createModelWith:(NSDictionary *)dic
{
    return [LMModel_LMCategory createLMCategoryBoWith:[dic objectForKey:@"lmodel_id"] catBo:[dic objectForKey:@"category_id"] tid:[dic objectForKey:@"id"]];
}

+ (LMModel_LMCategory *)createLMCategoryBoWith:(NSString *)mid catBo:(NSString *)cid tid:(NSString *)tid
{
    
    LMModel_LMCategory *result = [[LMModel_LMCategory alloc] init];
    result.mid = mid;
    result.cid = cid;
    result.tid = tid;
    
    return result;
}

+(NSString *)getTableName
{
    return @"LKModel_Category";
}

@end
