//
//  LMModelBo.m
//  LMGallery
//
//  Created by itenyh on 13-11-1.
//  Copyright (c) 2013年 lmodel. All rights reserved.
//

#import "LMModelBo.h"

@implementation LMModelBo

+(LMModelBo *)createModelWith:(NSDictionary *)dic
{
//    if ([dic objectForKey:@"hip"] == [NSNull null]) {
//        NSLog(@"%@",[[dic objectForKey:@"hip"] class]);
//    }

    NSString *avatar = [[dic objectForKey:@"avatar"] objectForKey:@"path"];
    NSInteger ageInt = [dic objectForKey:@"dob"] == [NSNull null]?-1:[[dic objectForKey:@"dob"] integerValue];
    NSInteger dboInt = [dic objectForKey:@"dob"] == [NSNull null]?-1:[[dic objectForKey:@"dob"] integerValue];
    NSInteger heightInt = [dic objectForKey:@"height"] == [NSNull null]?-1:[[dic objectForKey:@"height"] integerValue];
    NSInteger hipInt = [dic objectForKey:@"hip"] == [NSNull null]?-1:[[dic objectForKey:@"hip"] integerValue];
    NSInteger waistInt = [dic objectForKey:@"waist"] == [NSNull null]?-1:[[dic objectForKey:@"waist"] integerValue];
    NSInteger bustInt = [dic objectForKey:@"bust"] == [NSNull null]?-1:[[dic objectForKey:@"bust"] integerValue];
    NSInteger shoe_sizeInt = [dic objectForKey:@"shoe_size"] == [NSNull null]?-1:[[dic objectForKey:@"shoe_size"] integerValue];
    NSInteger dress_sizeInt = [dic objectForKey:@"dress_size"] == [NSNull null]?-1:[[dic objectForKey:@"dress_size"] integerValue];
    
    return [LMModelBo createModelWith:[dic objectForKey:@"name"] mid:[[dic objectForKey:@"id"] integerValue] hairColor:[dic objectForKey:@"hair_color"] eyesColor:[dic objectForKey:@"eye_color"] age:ageInt dbo:dboInt height:heightInt hips:hipInt waist:waistInt bust:bustInt shoesSize:shoe_sizeInt dressSize:dress_sizeInt isMale:[dic objectForKey:@"gender"] headImgUrl:avatar];
}

+(LMModelBo *)createModelWith:(NSString *)name mid:(NSInteger)mid hairColor:(NSString *)hairColor eyesColor:(NSString *)eyesColor age:(NSInteger)age dbo:(NSInteger)dbo height:(NSInteger)height hips:(NSInteger)hips waist:(NSInteger)waist bust:(NSInteger)bust shoesSize:(NSInteger)shoesSize dressSize:(NSInteger)dressSize isMale:(BOOL)is headImgUrl:(NSString *)headImgUrl
{
    LMModelBo *lm = [[LMModelBo alloc] init];
    
    lm.name = name;
    lm.mid = mid;
    lm.hairColor = hairColor;
    lm.eyesColor = eyesColor;
    lm.age = age;
    lm.dbo = dbo;
    lm.height = height;
    lm.hips = hips;
    lm.waist = waist;
    lm.bust = bust;
    lm.shoesSize = shoesSize;
    lm.dressSize = dressSize;
    lm.isMale = is;
    lm.headImgUrl = headImgUrl;
    lm.isAvaliable = NO;  //默认，请注意和数据库查询时一致
    
    return lm;
}

-(NSString *)getStrMid
{
    return [NSString stringWithFormat:@"%d",self.mid];
}

+(NSString *)getPrimaryKey
{
    return @"mid";
}

+(NSString *)getTableName
{
    return @"LKModel";
}

@end
