//
//  UIManage.h
//  BKWeiYun2
//
//  Created by itenyh on 13-5-30.
//  Copyright (c) 2013年 beikr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIManage : NSObject
+ (void)initUIManageWithView:(UIView *)view;
+ (BOOL)is568;
+ (NSString *)createXibOrImageName:(NSString *)xibBaseName;
+ (float)getAppWidth;
+ (float)getAppHeight;
+ (NSString*)getEgoLocalImgPathWith:(NSURL *)fileUrl;

//旋转
+ (UIInterfaceOrientation)getNowAppOrientation;

+ (CGSize)createImgSize:(UIImage *)image;

+ (UIImage *)createStrechImageWith:(UIImage *)targetImage AndEdgInset:(UIEdgeInsets)targetEdgInset;

+(UIColor *)color:(float)red blue:(float)blue green:(float)green alpha:(float)alpha;
+(UIColor *)color:(NSString *)hex alpha:(float)alpha;
+(UIColor *)color:(NSString *)hex;

#pragma itenyh--defined functions
+ (float)xFromLeftView:(UIView *)view;
+ (float)yFromTopView:(UIView *)view;
+ (CGSize)text:(NSString *)text sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

@end
