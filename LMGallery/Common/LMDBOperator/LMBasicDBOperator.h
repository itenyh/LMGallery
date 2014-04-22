//
//  LMBasicDBOperator.h
//  LMGallery
//
//  Created by itenyh on 13-11-1.
//  Copyright (c) 2013年 lmodel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LMModelBo.h"
#import "LMCategoryBo.h"
#import "LMModel+LMCategory.h"
#import "LMLargePhotoBo.h"

@interface LMBasicDBOperator : NSObject

+ (void)createAllTables;

+ (void)insertBo:(id)bo;

+ (void)getAllCatsWithcallback:(void (^)(NSMutableArray *array))block;
+ (void)getAllModelsWithCatId:(NSString *)catId upMidBoundary:(int)upmid callback:(void (^)(NSMutableArray *array))block;
+ (void)getAllCatsWithMId:(NSString *)mid callback:(void (^)(NSMutableArray *array))block;
+ (void)getAllLargePicsWithMId:(NSString *)mid callback:(void (^)(NSMutableArray *array))block;
+ (NSMutableArray *)searchAllModelWtihName:(NSString *)name;
+ (LMModelBo *)getLMModelBoWith:(NSString *)mid;
+ (void)updateSavedState:(BOOL)isSave mid:(NSString *)mid;
+ (void)getAllSavedModelsCallback:(void (^)(NSMutableArray *array))block;
+ (BOOL)getSavedStateWithMid:(NSString *)mid;

@end
