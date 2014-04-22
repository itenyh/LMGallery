//
//  BKUIUtil.m
//  BKWeiyun
//
//  Created by Big_Krist on 13-1-11.
//  Copyright (c) 2013年 beikr developer 1. All rights reserved.
//

#import "BKUIUtil.h"

@implementation BKUIUtil
+(UIColor *)color:(float)red blue:(float)blue green:(float)green alpha:(float)alpha{
    
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
}

+(UIColor *)color:(NSString *)hex{
    return [BKUIUtil color:hex alpha:1.0];
}

+(UIColor *)color:(NSString *)hex alpha:(float)alpha{
    if ([hex characterAtIndex:0]=='#') {
        hex = [hex substringFromIndex:1];
    }
    NSString *rs = [hex substringWithRange:NSMakeRange(0, 2)];
    long r = strtol([rs UTF8String],NULL, 16);
    NSString *gs = [hex substringWithRange:NSMakeRange(2, 2)];
    long g = strtol([gs UTF8String],NULL, 16);
    NSString *bs = [hex substringWithRange:NSMakeRange(4, 2)];
    long b = strtol([bs UTF8String],NULL, 16);
    return [BKUIUtil color:r blue:b green:g alpha:alpha];
}

+ (UIImage*)createStrechImageWith:(UIImage*)targetImage AndEdgInset:(UIEdgeInsets)targetEdgInset
{
    return [targetImage resizableImageWithCapInsets:targetEdgInset];
}

+ (NSString*)gen_guid
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge  NSString*)uuid_string_ref];     //有疑问，后面查实
    CFRelease(uuid_string_ref);
    return uuid;
}

+(void)baseYAnimation:(UIView *)view toVal:(float)to duration:(float)second{
    [UIView beginAnimations:@"movement" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:second];
    [UIView setAnimationRepeatCount:1];
    CGPoint center = view.center;
    center.y = to;
    view.center = center;
    [UIView commitAnimations];
}

+ (int)getEarliestFileTimeOfArray:(NSArray *)sourceArray
{
    if(sourceArray == nil || sourceArray.count == 0)
        return 0;
    
    int retValue = 0;
    for(NSDictionary *subDic in sourceArray)
    {
        int fileTime = [[subDic objectForKey:@"file_time"] intValue];
        if(retValue == 0) retValue = fileTime;
        
        if(fileTime < retValue)
            retValue = fileTime;
    }
    return retValue;
}

@end
