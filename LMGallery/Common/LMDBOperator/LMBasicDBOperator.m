//
//  LMBasicDBOperator.m
//  LMGallery
//
//  Created by itenyh on 13-11-1.
//  Copyright (c) 2013年 lmodel. All rights reserved.
//

#define LimitGalleryModelNum 9999
#define AvaliableCatId 5

#import "LMBasicDBOperator.h"
#import "LKDBHelper.h"

#import "NSObject+LKModel.h"
#import "NSObject+LKDBHelper.h"
#import "LMSavedModelBo.h"

static LKDBHelper *globalHelper;

@implementation LMBasicDBOperator

+ (void)createAllTables
{
    if (globalHelper == nil) {
        globalHelper = [LKDBHelper getUsingLKDBHelper];
    }
    
    //清空数据库
    [globalHelper dropAllTableExcept:[LMSavedModelBo getTableName]];
    
    //创建表  会根据表的版本号  来判断具体的操作 . create table need to manually call
    [globalHelper createTableWithModelClass:[LMModelBo class]];
    [globalHelper createTableWithModelClass:[LMCategoryBo class]];
    [globalHelper createTableWithModelClass:[LMModel_LMCategory class]];
    [globalHelper createTableWithModelClass:[LMLargePhotoBo class]];
    [globalHelper createTableWithModelClass:[LMSavedModelBo class]];
    
}

#pragma - 应用函数
+ (void)insertBo:(id)bo
{
    [globalHelper insertToDB:bo];
}

+ (void)getAllCatsWithcallback:(void (^)(NSMutableArray *array))block
{
    //异步
    [globalHelper search:[LMCategoryBo class] where:nil orderBy:nil offset:0 count:-1 callback:^(NSMutableArray *array) {
    
        dispatch_async(gMainQueue, ^{
            if(block != nil)
                block(array);
        });

    }];
}

+ (void)getAllModelsWithCatId:(NSString *)catId upMidBoundary:(int)upmid callback:(void (^)(NSMutableArray *array))block
{
    NSString *whereStr = [NSString stringWithFormat:@"[mid] IN (SELECT [mid] FROM [%@] WHERE [cid]='%@' limit %d) AND [mid] < %d", [LMModel_LMCategory getTableName], catId, LimitGalleryModelNum, upmid];
    //异步
    [globalHelper search:[LMModelBo class] where:whereStr orderBy:@"mid desc" offset:0 count:-1 callback:^(NSMutableArray *array) {
        
        for (LMModelBo *bo in array) {
            bo.isAvaliable = [LMBasicDBOperator isAvaliableWith:[bo getStrMid]];
        }
        
        dispatch_async(gMainQueue, ^{
            if(block != nil)
                block(array);
        });
        
    }];
}

+ (void)getAllCatsWithMId:(NSString *)mid callback:(void (^)(NSMutableArray *array))block
{
    NSString *whereStr = [NSString stringWithFormat:@"[cid] IN (SELECT [cid] FROM [%@] WHERE [mid]='%@')", [LMModel_LMCategory getTableName], mid];
    [globalHelper search:[LMCategoryBo class] where:whereStr orderBy:nil offset:0 count:-1 callback:^(NSMutableArray *array) {
        
        dispatch_async(gMainQueue, ^{
            if(block != nil)
                block(array);
        });
        
    }];
}

+ (void)getAllLargePicsWithMId:(NSString *)mid callback:(void (^)(NSMutableArray *array))block
{
    //异步
    [globalHelper search:[LMLargePhotoBo class] where:[NSString stringWithFormat:@"mid = %@", mid] orderBy:nil offset:0 count:-1 callback:^(NSMutableArray *array) {
        
        dispatch_async(gMainQueue, ^{
            if(block != nil)
                block(array);
        });
        
    }];
}

+ (NSMutableArray *)searchAllModelWtihName:(NSString *)name
{
    NSMutableString *whereStr = [NSMutableString stringWithString:@"name LIKE '%"];
    [whereStr appendString:[NSString stringWithFormat:@"%@", name]];
    [whereStr appendString:@"%'"];
    return [globalHelper search:[LMModelBo class] where:whereStr orderBy:nil offset:0 count:-1];
}

+ (LMModelBo *)getLMModelBoWith:(NSString *)mid
{
    NSMutableString *whereStr = [NSMutableString stringWithString:[NSString stringWithFormat:@"mid = %@", mid]];
    NSMutableArray *resultArr = [globalHelper search:[LMModelBo class] where:whereStr orderBy:nil offset:0 count:-1];
        
    if (resultArr != nil && resultArr.count > 0) {
        return [resultArr objectAtIndex:0];
    }
    
    else {
        return nil;
    }
    
}

+ (void)updateSavedState:(BOOL)isSave mid:(NSString *)mid
{
    LMSavedModelBo *bo = [LMSavedModelBo createLMSavedModelBoWith:isSave mid:mid];

    [globalHelper insertToDB:bo];
    
}

+ (void)getAllSavedModelsCallback:(void (^)(NSMutableArray *array))block
{
     NSString *whereStr = [NSString stringWithFormat:@"[mid] IN (SELECT [mid] FROM [%@] WHERE [isSaved]='1')", [LMSavedModelBo getTableName]];
    
    [globalHelper search:[LMModelBo class] where:whereStr orderBy:nil offset:0 count:-1 callback:^(NSMutableArray *array) {
        
        dispatch_async(gMainQueue, ^{
            if(block != nil)
                block(array);
        });
        
    }];
    
}

+ (BOOL)getSavedStateWithMid:(NSString *)mid
{
    NSMutableString *whereStr = [NSMutableString stringWithString:[NSString stringWithFormat:@"mid = %@", mid]];
    NSMutableArray *resultArr = [globalHelper search:[LMSavedModelBo class] where:whereStr orderBy:nil offset:0 count:-1];
    
    if (resultArr != nil && resultArr.count > 0) {
        LMSavedModelBo *bo = [resultArr objectAtIndex:0];
        return bo.isSaved;
    }
    
    else {
        return NO;
    }
}

+ (BOOL)isAvaliableWith:(NSString *)mid
{
    NSString *whereStr = [NSString stringWithFormat:@"mid='%@' AND cid='%d'", mid, AvaliableCatId];
    NSMutableArray *resultArr = [globalHelper search:[LMModel_LMCategory class] where:whereStr orderBy:nil offset:0 count:-1];
    
    if (resultArr != nil && resultArr.count > 0) {
        return YES;
    }
    
    else {
        return NO;
    }
}

@end
