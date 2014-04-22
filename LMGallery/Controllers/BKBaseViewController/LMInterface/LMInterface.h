//
//  LMInterface.h
//  LMGallery
//
//  Created by Apple on 13-12-29.
//  Copyright (c) 2013年 lmodel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMInterface : NSObject

+ (void)interfaceTestWithSuccessBlock:(void (^)(id retInfo))successBlock
                        withFailBlock:(void (^)(id retInfo))failBlock;

+ (void)requestAllDatasWithSuccessBlock:(void (^)(id retInfo))successBlock
                          withFailBlock:(void (^)(id retInfo))failBlock;

+ (void)requestInviteCodeCheckWithCode:(NSString *)code SuccessBlock:(void (^)(id retInfo))successBlock
                         withFailBlock:(void (^)(id retInfo))failBlock;
@end
