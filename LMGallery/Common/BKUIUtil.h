//
//  BKUIUtil.h
//  BKWeiyun
//
//  Created by Big_Krist on 13-1-11.
//  Copyright (c) 2013年 beikr developer 1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BKUIUtil : NSObject
+(UIColor *)color:(float)red blue:(float)blue green:(float)green alpha:(float)alpha;
+(UIColor *)color:(NSString *)hex alpha:(float)alpha;
+(UIColor *)color:(NSString *)hex;
+ (UIImage*)createStrechImageWith:(UIImage*)targetImage AndEdgInset:(UIEdgeInsets)targetEdgInset;
+ (NSString*)gen_guid;
+(void)baseYAnimation:(UIView *)view toVal:(float)to duration:(float)second;
+ (int)getEarliestFileTimeOfArray:(NSArray*)sourceArray;
+(void)beginStatistics:(NSString *)viewName;
+(void)endStatistics:(NSString *)viewName;
@end
