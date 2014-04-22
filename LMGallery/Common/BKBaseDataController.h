//
//  BKBaseDataController.h
//  BKWeiyun
//  基础数据操作类，操作基础的plist读写以及文件夹建立等操作
//  Created by Big_Krist on 13-1-8.
//  Copyright (c) 2013年 beikr developer 1. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "BKBaseDBOperator.h"
//#import "BKInternetInterfaceInvoke.h"
//#import "FMDatabase.h"
//#import "FMDatabaseQueue.h"

#define NowUserPlistName @"NowUserConfig.plist"
#define RemoteNotiProcessQueue @"RemoteNotiProcessQueue.plist"
#define BKFinishSyncIndivadualInfoNoti @"BKFinishSyncIndivadualInfoNoti"

#define GetTotalSyncInfoCountNoti @"GetTotalSysncInfoCountNoti"
#define BKNoticeUserShuldLoginNoti @"BKNoticeUserShuldLoginNoti"
#define BKWillReportSomeContentNoti @"BKWillReportSomeContentNoti"
#define BKUserDidnotHaveEnoughServerSpaceNoti @"BKUserDidnotHaveEnoughServerSpaceNoti"
#define BKFinishUploadAMissionToOSSNoti @"BKFinishAMissionToOSSNoti"
#define BKFailUploadAMissionToOSSNoti @"BKFailUploadAMissionToOSSNoti"
#define BKPauseOrDeleteAUploadMisstionToOSSNoti @"BKPauseOrDeleteAUploadMissionToOSSNoti"



@interface BKBaseDataController : NSObject

+ (NSString*)getTheNowUserPlistPath;    //获取NowUserPlist的具体路径
+ (void)checkTheNowUserPlist;      //检查目前使用当中的用户的Plist信息
+ (NSDictionary*)getTheNowUserDicInfo;  //获取目前登录的用户的信息
+ (void)removeAllKeysInDic;//移除所有信息
+ (BOOL)removeTheInSideNowUserInfoKey:(NSString *)key;
+ (id)getTheNowUserValueByKey:(NSString*)key;    //获取目前登录用户的指定信息
+ (BOOL)updateTheNowUserInfoWith:(NSDictionary*)targetDic;  //将targetDic中的信息更新到NowUserInfo中
+ (BOOL)changeTheNowUserInfoWith:(NSDictionary*)targetDic;  //将targetDic中的信息替换到NowUserInfo中，放弃NowUserInfo原来的数据
+ (BOOL)updateTheNowUserInfoWith:(id)theValue ofKey:(NSString*)theKey;   //将NowUserInfo进行相应的key,value改变
+ (BOOL)updateTheInSideNowUserInfoWith:(id)theValue ofKey:(NSString *)theKey; //将NowUserInfo的子字典"user_info"进行相应的key,value改变
+ (BOOL)updateTheInSideNowUserInfoWithDic:(NSDictionary *)dic;

+ (BOOL)isHoneyExist;
+ (NSString *)getTheHoneyValueWithKey:(NSString *)key;

//+ (void)prepareForTheUserData;
+ (NSString*)getAreaNameWithAreaCode:(NSString*)targetAreaCode;
//+ (void)updateToTheNewestData;
+ (id)getConfigInfo:(NSString *)key;
+ (NSString *)getTheInSideNowUserInfoWithKey:(NSString *)theKey; //得到NowUserInfo的子字典"user_info"相应的key的value
+ (NSString*)getTheAppCacheDataPath;
//+ (fm)createTheAppUserDbQueue;


+ (BOOL)isUserHasLogin;     //判断用户是否登录（此方法在改版后会贯穿全局操作）
+ (BOOL)checkUserLoginStateOnSomeClickEvent;

//+ (void)updateSinaWeiboInfoWith:(NSDictionary*)dicInfo;
//+ (NSString*)getSinaWeiboInfoWith:(NSString*)targetKey;

+ (BOOL)isTheNowUserInTeam;
+ (NSDictionary *)getTheNowUserTeamInfo;
+ (BOOL)userCanPostTeamNote;
+ (BOOL)userCanPostTeamPic;
+ (BOOL)userCanPostTeamVideo;
+ (BOOL)userCanPostTeamNews;
+ (BOOL)userCanManageTeamMember;


#pragma mark -
#pragma mark 合并一些基础函数到这个包
+ (NSString*)getTheBaseCachePath;
+ (void)deleteTheFilesInDirectory:(NSString *)directoryPath;
+ (NSString*)checkUploadTmpDirsWith:(NSString *)targetUserId andDirName:(NSString *)tempDirName;
+ (NSString*)getTheRemoteNotiProcessQueuePath;


@end
