//
//  BKBaseFunctions.h
//  PregnancyParter
//  基础功能库
//  Created by beikr developer 1 on 12-6-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BK_APP_KEY @"5609830284"
#define BK_SECRET_KEY @"1d37290c70655efd445cb43d8a2d36ba"

#define BK_PREURLFORStor @"http://stor.ygj360.com/"

#define APPID @"5174a4ad"
#define ENGINE_URL @"http://dev.voicecloud.cn:1028/index.htm"

@interface BKBaseFunctions : NSObject
+ (NSString *)umKey;
+(NSString *)talkingDataAppKey;

+ (NSString *)createMD5:(NSString *)string;
+ (NSString *)createSignatureWithTimaStamp:(NSInteger)timestamp;
+ (NSDictionary *)returnError:(NSInteger)code errStr:(NSString *)errStr errDesc:(NSString *)errDesc;

+ (id)jsonValueFromStr:(NSString*)targetStr;
+ (NSString*)jsonStrFromObject:(id)targeObject;
+ (long long)getFileSizeWith:(NSString*)filePath;

+ (NSString *)sizeToStringSize:(NSInteger)size;
+ (NSString *)newSizeToString:(NSInteger)size;

+ (NSString *)tinyTime:(NSTimeInterval)time;
+ (NSString *)date_parse:(NSDate *)date format:(NSString *)format;

+(NSDate *)date_from1970:(NSTimeInterval)interl;
+(UILabel *)createLable:(NSString *)txt color:(NSString *)color frame:(CGRect)frame;
+(NSDate *)date_fomat:(NSString *)date formte:(NSString *)format;
+ (BOOL)isToday:(NSDate *)date;

+ (BOOL)isNewVersion:(NSString *)curVersion NewVersion:(NSString *)newVersion;

+ (BOOL)isNetworkError:(id)val;

+ (void)beginStatistics:(Class)controllerClass;
+ (void)endStatistics:(Class)controllerClass;

+ (NSString *)getCHMonthWithMonth:(NSInteger)month;
+ (NSString *)getCHWeekDayWithWeekDay:(NSInteger)weekDay;

+ (float)getIosVer;

+ (CGSize)getCGSizeWithFontSize:(UIFont *)font text:(NSString *)text;
+ (NSString*)machine;
@end

@interface NSString(Extara)
- (NSString *)trim;
- (NSString *)stringToTheFirstPath;
- (NSString *)stringByDeletingFirstPathComponent;
@end