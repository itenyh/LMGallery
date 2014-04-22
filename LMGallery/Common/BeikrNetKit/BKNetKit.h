//
//  BKNetKit.h
//  iRally
//
//  Created by 蔡凌 on 13-9-4.
//  Copyright (c) 2013年 蔡凌. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BK_PREURL @"http://lmodel.gotoip4.com/"
//#define BK_PREURL @"http://abel.my.phpcloud.com/model/"
#define IMAGEBASE @"http://stor.ygj360.com/irally/"

typedef enum BKNetType_
{
    BKNet_NONE,
    BKNet_WWAN,
    BKNet_WIFI
} BKNetType;

@interface BKNetKit : NSObject

+ (BKNetType)getNowNetSituation;

+ (id)invokeTheApi:(NSString*)apiName withParam:(NSDictionary*)param;
+ (BOOL)refreshLocalToken;
+ (id)loginWithEmail:(NSString*)theEmail AndPassWord:(NSString*)thePw;
+ (id)verifyTheUserWith:(NSString*)theUid AndToken:(NSString*)theToken;

//一个通用的返回处理
+ (void)commonProcessTheData:(id)retValue RetBlock:(void (^)(id retValue))successBlock andFailBlock:(void (^)(id failDes))failBlock;
@end
