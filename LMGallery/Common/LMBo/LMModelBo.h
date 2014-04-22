//
//  LMModelBo.h
//  LMGallery
//
//  Created by itenyh on 13-11-1.
//  Copyright (c) 2013年 lmodel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LMBaseBo.h"

@interface LMModelBo : LMBaseBo

@property(strong, nonatomic) NSString *name;
@property(assign, nonatomic) int mid;
@property(strong, nonatomic) NSString *hairColor;
@property(strong, nonatomic) NSString *eyesColor;

@property(nonatomic, assign) NSInteger age;
@property(nonatomic, assign) NSInteger dbo;
@property(nonatomic, assign) NSInteger height;
@property(nonatomic, assign) NSInteger hips;
@property(nonatomic, assign) NSInteger waist;
@property(nonatomic, assign) NSInteger bust;
@property(nonatomic, assign) NSInteger shoesSize;
@property(nonatomic, assign) NSInteger dressSize;
@property(nonatomic, assign) BOOL isMale;
@property(nonatomic, assign) BOOL isAvaliable;

@property(nonatomic, strong) NSString *headImgUrl;

+(LMModelBo *)createModelWith:(NSString *)name mid:(NSInteger)mid hairColor:(NSString *)hairColor eyesColor:(NSString *)eyesColor age:(NSInteger)age dbo:(NSInteger)dbo height:(NSInteger)height hips:(NSInteger)hips waist:(NSInteger)waist bust:(NSInteger)bust shoesSize:(NSInteger)shoesSize dressSize:(NSInteger)dressSize isMale:(BOOL)is headImgUrl:(NSString *)headImgUrl;

+(LMModelBo *)createModelWith:(NSDictionary *)dic;

-(NSString *)getStrMid;

@end
