//
//  LMLargePhotoBo.m
//  LMGallery
//
//  Created by Apple on 14-1-7.
//  Copyright (c) 2014年 lmodel. All rights reserved.
//

#import "LMLargePhotoBo.h"

@implementation LMLargePhotoBo

+ (NSString *)getPrimaryKey
{
    return @"rowid";
}

+(LMLargePhotoBo *)createModelWith:(NSDictionary *)dic
{
    return [LMLargePhotoBo createLMLargePhotoBoWith:[dic objectForKey:@"path"] mid:[dic objectForKey:@"lmodel_id"] tid:[dic objectForKey:@"id"]];
}

+ (LMLargePhotoBo *)createLMLargePhotoBoWith:(NSString *)pUrl mid:(NSString *)mid tid:(NSString *)tid
{
    LMLargePhotoBo *lm = [[LMLargePhotoBo alloc] init];
    lm.pUrl = pUrl;
    lm.mid = mid;
    lm.tid = tid;
    
    return lm;
}

+(NSString *)getTableName
{
    return @"LMLargePhoto";
}

@end
