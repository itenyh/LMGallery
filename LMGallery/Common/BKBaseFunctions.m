//
//  BKBaseFunctions.m
//  PregnancyParter
//
//  Created by beikr developer 1 on 12-6-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BKBaseFunctions.h"
#import "SBJson.h"
#import <CommonCrypto/CommonDigest.h>
#import <sys/stat.h>
#include "sys/types.h"
#include "sys/sysctl.h"

//#import "UIUtil.h"
//#import "MobClick.h"
//#import "TalkingData.h"

static float _iosVer;

@implementation BKBaseFunctions

+ (UILabel *)createLable:(NSString *)txt color:(NSString *)color frame:(CGRect)frame {
	UILabel *label = [[UILabel alloc] initWithFrame:frame];
	label.backgroundColor = [UIColor clearColor];
	label.textColor = [UIManage color:color];
	label.text = txt;
	return label;
}

+ (NSString *)umKey{
    return @"4ff29f815270157d2c00000a";
}

+(NSString *)talkingDataAppKey{
    return @"2A88502D6D509FE4EEF32827BAD1111D";
}

+ (NSString *)createMD5:(NSString *)string {
	const char *cStr = [string UTF8String];
	unsigned char md5Result[16];
	CC_MD5(cStr, strlen(cStr), md5Result);
	return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X", md5Result[0], md5Result[1], md5Result[2], md5Result[3], md5Result[4], md5Result[5], md5Result[6], md5Result[7], md5Result[8], md5Result[9], md5Result[10], md5Result[11], md5Result[12], md5Result[13], md5Result[14], md5Result[15]];
}

+ (NSString *)createSignatureWithTimaStamp:(NSInteger)timestamp {
	return [BKBaseFunctions createMD5:[NSString stringWithFormat:@"%@%@%d%@", BK_SECRET_KEY, BK_APP_KEY, timestamp, BK_SECRET_KEY]];
}

+ (NSDictionary *)returnError:(NSInteger)code errStr:(NSString *)errStr errDesc:(NSString *)errDesc {
	return [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d", code], @"error_code", errStr, @"error", errDesc, @"error_description", nil];
}

+ (id)jsonValueFromStr:(NSString *)targetStr
{
    SBJsonParser *jsPar = [[SBJsonParser alloc] init];
    return [jsPar objectWithString:targetStr];
}

+ (NSString*)jsonStrFromObject:(id)targeObject
{
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    NSString *json = [writer stringWithObject:targeObject];
    if (!json)
        NSLog(@"-JSONRepresentation failed. Error is: %@", writer.error);
    return json;
}

+ (long long)getFileSizeWith:(NSString *)filePath
{
    struct stat st;
    if(lstat([filePath cStringUsingEncoding:NSUTF8StringEncoding], &st) == 0){
        return st.st_size;
    }
    return 0;
}

+ (NSString *)sizeToStringSize:(NSInteger)size
{
    NSString *sizeUnit = @"Byte";
    float fSize = (float)size;
    float maxSize = 1000.0f;
    if(fSize > maxSize)
    {
        fSize = fSize / maxSize;
        sizeUnit = @"KB";
        
        if(fSize > maxSize)
        {
            fSize = fSize / maxSize;
            sizeUnit = @"MB";
            
            if(fSize > maxSize)
            {
                fSize = fSize / maxSize;
                sizeUnit = @"GB";
            }
        }
    }
    
    return [NSString stringWithFormat:@"%.2f%@",fSize,sizeUnit];
}
+ (NSString *)newSizeToString:(NSInteger)size
{
    NSString *sizeUnit = @"Byte";
    float fSize = (float)size;
    float maxSize = 1000.0f;
    if(fSize > maxSize)
    {
        fSize = fSize / maxSize;
        sizeUnit = @"KB";
        
        if(fSize > maxSize)
        {
            fSize = fSize / maxSize;
            sizeUnit = @"MB";
            
            if(fSize > maxSize)
            {
                fSize = fSize / maxSize;
                sizeUnit = @"GB";
            }
        }
    }
    
    return [NSString stringWithFormat:@"%.0f%@",fSize,sizeUnit];
}

+ (NSString *)tinyTime:(NSTimeInterval)time {
	NSInteger now = [[NSDate date] timeIntervalSince1970];
	NSInteger diff = now - time;
	if (diff < 0) return @"来自未来";
	else if (diff < 60) {
		return @"刚刚";
	} else if (diff < 3600) {
		return [NSString stringWithFormat:@"%d分钟前", diff/60];
	} else if (diff < 86400) {
		return [NSString stringWithFormat:@"%d小时前", diff/3600];
	} else if (diff < 172800) {
		return [NSString stringWithFormat:@"昨天 %@", [BKBaseFunctions date_parse:[NSDate dateWithTimeIntervalSince1970:time] format:@"HH:mm"]];
	} else {
		return [BKBaseFunctions date_parse:[NSDate dateWithTimeIntervalSince1970:time] format:@"MM月dd日"];
	}
	return @"";
}

+ (NSString *)date_parse:(NSDate *)date format:(NSString *)format{
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:format];
    NSString *currentTime = [timeFormatter stringFromDate:date];
//    [timeFormatter release]; timeFormatter = nil;
    return currentTime;
}

+(NSDate *)date_from1970:(NSTimeInterval)interl{
    return [NSDate dateWithTimeIntervalSince1970:interl];
}

// 日期是标准格式 yyyy-MM-dd HH:mm:ss ZZZ
+(NSDate *)date_fomat:(NSString *)date formte:(NSString *)format{
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    timeFormatter.dateFormat = format;
    NSDate *adate = [timeFormatter dateFromString:date];
    return adate;
}

+ (BOOL)isToday:(NSDate *)date {
	NSDate *now = [NSDate date];
	NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    timeFormatter.dateFormat = @"yyyy-MM-dd";
	NSString *nowDateStr = [timeFormatter stringFromDate:now];
	NSString *dateStr = [timeFormatter stringFromDate:date];
	return [dateStr compare:nowDateStr] == NSOrderedSame;
}

//+(UILabel *)createLable:(NSString *)txt color:(NSString *)color frame:(CGRect)frame{
//    UILabel *lable = [[UILabel alloc] initWithFrame:frame];
//    lable.backgroundColor = [UIColor clearColor];
//    lable.font = [UIFont boldSystemFontOfSize:16];
//    lable.text = txt;
//    lable.textColor = [UIUtil color:color];
//    return lable;
//}

+ (BOOL)isNetworkError:(id)val{
    return [val isKindOfClass:[NSDictionary class]] && [val objectForKey:@"error_code"] != nil && [[val objectForKey:@"error_code"] intValue] == 902;
}

+ (BOOL)isNewVersion:(NSString *)curVersion NewVersion:(NSString *)newVersion
{
    NSString *tmpCurVersion = [curVersion substringFromIndex:2];
    NSString *tmpNewVersion = [newVersion substringFromIndex:2];
    
    tmpCurVersion = [tmpCurVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
    tmpNewVersion = [tmpNewVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
    
    return [tmpNewVersion intValue] > [tmpCurVersion intValue];
}

+ (void)beginStatistics:(Class)controllerClass
{
    NSString *viewName = NSStringFromClass(controllerClass);
    NSLog(@"beginView:%@",viewName);
//    [MobClick beginLogPageView:viewName];
//    [TalkingData trackPageBegin:viewName];
}
+(void)endStatistics:(Class)controllerClass
{
    NSString *viewName = NSStringFromClass(controllerClass);
    NSLog(@"endView:%@",viewName);
//    [MobClick endLogPageView:viewName];
//    [TalkingData trackPageEnd:viewName];
}

+ (NSString *)getCHMonthWithMonth:(NSInteger)month
{
    NSString *chMonth = nil;
    switch (month) {
        case 1:
            chMonth = @"一月";
            break;
        case 2:
            chMonth = @"二月";
            break;
        case 3:
            chMonth = @"三月";
            break;
        case 4:
            chMonth = @"四月";
            break;
        case 5:
            chMonth = @"五月";
            break;
        case 6:
            chMonth = @"六月";
            break;
        case 7:
            chMonth = @"七月";
            break;
        case 8:
            chMonth = @"八月";
            break;
        case 9:
            chMonth = @"九月";
            break;
        case 10:
            chMonth = @"十月";
            break;
        case 11:
            chMonth = @"十一月";
            break;
        case 12:
            chMonth = @"十二月";
            break;
        default:
            chMonth = @"?月";
            NSLog(@"你确定有这个月？你来地球的目的是什么？");
            break;
    }
    
    return chMonth;
}

+ (NSString *)getCHWeekDayWithWeekDay:(NSInteger)weekDay
{
    NSString *weekDayCH = nil;
    switch (weekDay) {
        case 1:
            weekDayCH = @"星期天";
            break;
        case 2:
            weekDayCH = @"星期一";
            break;
        case 3:
            weekDayCH = @"星期二";
            break;
        case 4:
            weekDayCH = @"星期三";
            break;
        case 5:
            weekDayCH = @"星期四";
            break;
        case 6:
            weekDayCH = @"星期五";
            break;
        case 7:
            weekDayCH = @"星期六";
            break;
        default:
            weekDayCH = @"星期？";
            break;
    }
    
    return weekDayCH;
}

+ (float)getIosVer
{
    if(_iosVer != 0)
    {
        return _iosVer;
    }
    _iosVer = [[[UIDevice currentDevice] systemVersion] floatValue];
    return _iosVer;
}

+ (CGSize)getCGSizeWithFontSize:(UIFont *)font text:(NSString *)text
{
    CGSize r = [text sizeWithFont:font];
    return r;
}

+ (NSString*)machine
{
	size_t size;
	sysctlbyname("hw.machine", NULL, &size, NULL, 0);
	char* name = (char*)malloc(size);
	sysctlbyname("hw.machine", name, &size, NULL, 0);
    NSString *machine = [NSString stringWithUTF8String:name];
	free(name);

    if ([machine isEqualToString:@"iPhone1,1"])    machine= @"iPhone 2G";
    if ([machine isEqualToString:@"iPhone1,2"])    machine= @"iPhone 3G";
    if ([machine isEqualToString:@"iPhone2,1"])    machine= @"iPhone 3GS";
    if ([machine isEqualToString:@"iPhone3,1"])    machine= @"iPhone 4";
    if ([machine isEqualToString:@"iPhone3,2"])    machine= @"iPhone 4";
    if ([machine isEqualToString:@"iPhone3,3"])    machine= @"iPhone 4";
    if ([machine isEqualToString:@"iPhone4,1"])    machine= @"iPhone 4S";
    if ([machine isEqualToString:@"iPhone5,1"])    machine= @"iPhone 5";
    if ([machine isEqualToString:@"iPhone5,2"])    machine= @"iPhone 5";
    
    if ([machine isEqualToString:@"iPod1,1"])      machine= @"iPod Touch 1";
    if ([machine isEqualToString:@"iPod2,1"])      machine= @"iPod Touch 2";
    if ([machine isEqualToString:@"iPod3,1"])      machine= @"iPod Touch 3";
    if ([machine isEqualToString:@"iPod4,1"])      machine= @"iPod Touch 4";
    if ([machine isEqualToString:@"iPod5,1"])      machine= @"iPod Touch 5";
    
    if ([machine isEqualToString:@"iPad1,1"])      machine= @"iPad";
    if ([machine isEqualToString:@"iPad1,2"])      machine= @"iPad 3G";
    if ([machine isEqualToString:@"iPad2,1"])      machine= @"iPad 2 (WiFi)";
    if ([machine isEqualToString:@"iPad2,2"])      machine= @"iPad 2";
    if ([machine isEqualToString:@"iPad2,3"])      machine= @"iPad 2 (CDMA)";
    if ([machine isEqualToString:@"iPad2,4"])      machine= @"iPad 2";
    if ([machine isEqualToString:@"iPad2,5"])      machine= @"iPad Mini (WiFi)";
    if ([machine isEqualToString:@"iPad2,6"])      machine= @"iPad Mini";
    if ([machine isEqualToString:@"iPad2,7"])      machine= @"iPad Mini (GSM+CDMA)";
    if ([machine isEqualToString:@"iPad3,1"])      machine= @"iPad 3 (WiFi)";
    if ([machine isEqualToString:@"iPad3,2"])      machine= @"iPad 3 (GSM+CDMA)";
    if ([machine isEqualToString:@"iPad3,3"])      machine= @"iPad 3";
    if ([machine isEqualToString:@"iPad3,4"])      machine= @"iPad 4 (WiFi)";
    if ([machine isEqualToString:@"iPad3,5"])      machine= @"iPad 4";
    if ([machine isEqualToString:@"iPad3,6"])      machine= @"iPad 4 (GSM+CDMA)";
    
    if ([machine isEqualToString:@"i386"])         machine= @"Simulator";
    if ([machine isEqualToString:@"x86_64"])       machine= @"Simulator";
    
	return machine;
}

@end

@implementation NSString(Extara)
-(NSString *)trim{
    if (self==nil) {
        return nil;
    }
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)stringToTheFirstPath
{
    NSRange rangeOfPath = [self rangeOfString:@"/"];
    
    if (rangeOfPath.length == 0) {
        return nil;
    }
    return [self substringToIndex:rangeOfPath.location];
}

- (NSString *)stringByDeletingFirstPathComponent
{
    NSRange rangeOfPath = [self rangeOfString:@"/"];
    
    if (rangeOfPath.length == 0) {
        return self;
    }
    return [self substringFromIndex:rangeOfPath.location + 1];
}
@end
