//
//  LMInterface.m
//  LMGallery
//
//  Created by Apple on 13-12-29.
//  Copyright (c) 2013年 lmodel. All rights reserved.
//

#import "LMBasicDBOperator.h"
#import "LMModelBo.h"
#import "LMCategoryBo.h"
#import "LMModel+LMCategory.h"
#import "LMLargePhotoBo.h"

#import "LMInterface.h"
#import "BKNetKit.h"

@implementation LMInterface

+ (void)interfaceTestWithSuccessBlock:(void (^)(id retInfo))successBlock
                                      withFailBlock:(void (^)(id retInfo))failBlock
{
    
    dispatch_async(gQueueT, ^{
        id invokeRet = [BKNetKit invokeTheApi:@"versions/json" withParam:[NSDictionary dictionaryWithObjectsAndKeys:@"all", @"id", nil]];
        //NSLog(@"invokeRet from LocationInterface is %@",invokeRet);
        if(invokeRet == nil)
        {
            dispatch_async(gMainQueue, ^{
                failBlock([NSDictionary dictionaryWithObjectsAndKeys:@"0000",@"error_code", nil]);
            });
        }
        else if([invokeRet isKindOfClass:[NSDictionary class]] && [invokeRet objectForKey:@"error_code"] != nil)
        {
            dispatch_async(gMainQueue, ^{
                failBlock([NSDictionary dictionaryWithObjectsAndKeys:[invokeRet objectForKey:@"error_code"],@"error_code", nil]);
            });
        }
        else
        {
            dispatch_async(gMainQueue, ^{
                successBlock(invokeRet);
            });
        }
    });
}

+ (void)requestInviteCodeCheckWithCode:(NSString *)code SuccessBlock:(void (^)(id retInfo))successBlock
                                 withFailBlock:(void (^)(id retInfo))failBlock
{
    dispatch_async(gQueueT, ^{
        id invokeRet = [BKNetKit invokeTheApi:@"/lmodels/invitation_check" withParam:[NSDictionary dictionaryWithObjectsAndKeys:code, @"code", nil]];
        //NSLog(@"invokeRet from LocationInterface is %@",invokeRet);
        if(invokeRet == nil)
        {
            dispatch_async(gMainQueue, ^{
                failBlock([NSDictionary dictionaryWithObjectsAndKeys:@"0000",@"error_code", nil]);
            });
        }
        else if([invokeRet isKindOfClass:[NSDictionary class]] && [invokeRet objectForKey:@"error_code"] != nil)
        {
            dispatch_async(gMainQueue, ^{
                failBlock([NSDictionary dictionaryWithObjectsAndKeys:[invokeRet objectForKey:@"error_code"],@"error_code", nil]);
            });
        }
        else
        {
            dispatch_async(gMainQueue, ^{
                successBlock(invokeRet);
            });
        }
    });
}

+ (void)requestAllDatasWithSuccessBlock:(void (^)(id retInfo))successBlock
                        withFailBlock:(void (^)(id retInfo))failBlock
{
    [LMBasicDBOperator createAllTables];
    
    dispatch_async(gQueueT, ^{
        
        NSArray* catDics = [BKNetKit invokeTheApi:@"categories.json" withParam:nil];
        for (NSDictionary *dic in catDics) {
            
            LMCategoryBo *bo = [LMCategoryBo createLMCategoryBoWith:dic];
            [LMBasicDBOperator insertBo:bo];
            
        }
        NSLog(@"finish categories/json");
        
        NSArray* modelsDics = [BKNetKit invokeTheApi:@"lmodels.json?with_avatar" withParam:nil];
        NSLog(@"finish request lmodels/json count :%lu ", (unsigned long)modelsDics.count);
        for (NSDictionary *dic in modelsDics) {
            
            LMModelBo *bo = [LMModelBo createModelWith:dic];
            NSDictionary *avartaDic = [dic objectForKey:@"avatar"];
            bo.headImgUrl = [NSString stringWithFormat:@"%@photos/%@.jpg", BK_PREURL, [avartaDic objectForKey:@"id"]];
            [LMBasicDBOperator insertBo:bo];
            
        }
        NSLog(@"finish lmodels/json insert : %lu", (unsigned long)modelsDics.count);
        
        NSArray* model2catDics = [BKNetKit invokeTheApi:@"categories_lmodels.json" withParam:nil];
        for (NSDictionary *dic in model2catDics) {
            
            LMModel_LMCategory *bo = [LMModel_LMCategory createModelWith:dic];
            [LMBasicDBOperator insertBo:bo];
            
        }
        NSLog(@"finish categories_lmodels/json count %lu",  (unsigned long)model2catDics.count);

        NSArray* largePhotosDics = [BKNetKit invokeTheApi:@"photos.json?without_avatar" withParam:nil];
        NSLog(@"finish request photos/json");
        for (NSDictionary *dic in largePhotosDics) {
            
            LMLargePhotoBo *bo = [LMLargePhotoBo createModelWith:dic];
            bo.pUrl = [NSString stringWithFormat:@"%@photos/%@.jpg", BK_PREURL,[dic objectForKey:@"id"]];
            [LMBasicDBOperator insertBo:bo];
            
        }
        NSLog(@"finish photos/json count %lu", (unsigned long)largePhotosDics.count);

       
        dispatch_async(gMainQueue, ^{
            successBlock(nil);
        });
        
        
    });
    
}

@end
