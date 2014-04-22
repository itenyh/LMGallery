//
//  LMLargePhotoBo.h
//  LMGallery
//
//  Created by Apple on 14-1-7.
//  Copyright (c) 2014年 lmodel. All rights reserved.
//

#import "LMBaseBo.h"

@interface LMLargePhotoBo : LMBaseBo

@property (nonatomic, strong) NSString *pUrl;
@property (nonatomic, strong) NSString *mid;
@property (nonatomic, strong) NSString *tid;

+ (LMLargePhotoBo *)createLMLargePhotoBoWith:(NSString *)pUrl mid:(NSString *)mid tid:(NSString *)tid; 
+ (LMLargePhotoBo *)createModelWith:(NSDictionary *)dic;

@end
