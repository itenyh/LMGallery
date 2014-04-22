//
//  BKUserDefautTool.m
//  BeikrOA
//
//  Created by itenyh on 13-12-8.
//  Copyright (c) 2013年 Beikr. All rights reserved.
//

#define defaultUserId @"duser"
#define updateTimeLimit 60 * 60

#import "BKUserDefautTool.h"
#import "BKBaseDataController.h"

@implementation BKUserDefautTool

+ (void)initDefautDicIfNecessary
{
    NSString *uid = defaultUserId;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userDic = [ud objectForKey:uid];
    
    if (userDic == nil) {
        userDic = [[NSMutableDictionary alloc] init];
        [ud setObject:userDic forKey:uid];
    }
}

+ (void)setWithDictionary:(NSDictionary *)dic
{
//    NSString *uid = [BKBaseDataController getTheNowUserValueByKey:@"UID"];
    NSString *uid = defaultUserId;
    NSMutableDictionary *userDic = [BKUserDefautTool getDicForUserWith:uid];
    NSMutableDictionary *replaceDic = [NSMutableDictionary dictionaryWithDictionary:userDic];
    
    for (NSString* key in [dic allKeys]) {
        [replaceDic setObject:[dic objectForKey:key] forKey:key];
    }
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:replaceDic forKey:uid];
    [ud synchronize];
}

+ (NSString *)getValueWith:(NSString *)key
{
    NSString *uid = defaultUserId;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userDic = [ud objectForKey:uid];
    
    return [userDic objectForKey:key];
}

+ (NSMutableDictionary *)getDicForUserWith:(NSString *)uid
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userDic = [ud objectForKey:uid];
    
    return userDic;
}

+ (void)clearCurUser
{
    NSString * UID_sort = defaultUserId;
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    [ud removeObjectForKey:UID_sort];
    [ud synchronize];
}

#pragma - application functions
//刷新相关
+ (void)setLastRefreshForNow
{
    NSDate *nowDate = [NSDate date];
    NSDictionary *dic = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%f",[nowDate timeIntervalSince1970]] forKey:@"lastRefresh"];
    [BKUserDefautTool setWithDictionary:dic];
}

+ (NSString *)getLastRefresh
{
    return [BKUserDefautTool getValueWith:@"lastRefresh"];
}

+(BOOL)isRefreshNeeded
{
    NSString *lastRefresh = [self getLastRefresh];
    if (lastRefresh == nil) {
        return YES;
    }
    
    NSDate *minDateToRefresh = [NSDate dateWithTimeInterval:updateTimeLimit sinceDate:[BKBaseFunctions date_from1970:[lastRefresh longLongValue]]];
    
    return [minDateToRefresh timeIntervalSinceNow] <= 0;
}

//邀请码相关
+ (void)setChecked
{
    NSDictionary *dic = [NSDictionary dictionaryWithObject:@"1" forKey:@"isChecked"];
    [BKUserDefautTool setWithDictionary:dic];
}

+ (BOOL)isRequestCheckedNeeded
{
    NSString *checked = [BKUserDefautTool getValueWith:@"isChecked"];
    return checked == nil;
}

//数据显示板相关
+(BOOL)isToShownPanel
{
    NSString *isToShow = [BKUserDefautTool getValueWith:@"isToShowPanel"];
    return isToShow != nil && [isToShow isEqualToString:@"1"];
}

+(void)setToShowPanel:(BOOL)showing
{
    NSString *boolValue = showing?@"1":@"0";
    NSDictionary *dic = [NSDictionary dictionaryWithObject:boolValue forKey:@"isToShowPanel"];
    [BKUserDefautTool setWithDictionary:dic];
}


@end
