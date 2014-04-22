//
//  LMCategoryBo.m
//  LMGallery
//
//  Created by Apple on 14-1-3.
//  Copyright (c) 2014年 lmodel. All rights reserved.
//

#import "LMCategoryBo.h"

@implementation LMCategoryBo

+ (NSString *)getPrimaryKey
{
    return @"cid";
}

+ (LMCategoryBo *)createLMCategoryBoWith:(NSDictionary *)dic
{
   return [LMCategoryBo createLMCategoryBoWith:[dic objectForKey:@"id"] name:[dic objectForKey:@"name"] enName:[dic objectForKey:@"english_name"] color:[dic objectForKey:@"color"]];
}

+ (LMCategoryBo *)createLMCategoryBoWith:(NSString *)cid name:(NSString *)name enName:(NSString *)enName color:(NSString *)color
{
    LMCategoryBo *lm = [[LMCategoryBo alloc] init];
    lm.cid = cid;
    lm.name = name;
    lm.enName = enName;
    lm.color = color;
    
    return lm;
}

+(NSString *)getTableName
{
    return @"LKCategory";
}

@end
