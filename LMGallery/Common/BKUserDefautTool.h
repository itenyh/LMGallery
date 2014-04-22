//
//  BKUserDefautTool.h
//  BeikrOA
//
//  Created by itenyh on 13-12-8.
//  Copyright (c) 2013年 Beikr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BKUserDefautTool : NSObject

+ (void)initDefautDicIfNecessary;
+ (void)setLastRefreshForNow;

+ (NSString *)getLastRefresh;
+(BOOL)isRefreshNeeded;

+ (void)setChecked;
+ (BOOL)isRequestCheckedNeeded;

+(BOOL)isToShownPanel;
+(void)setToShowPanel:(BOOL)showing;

@end
