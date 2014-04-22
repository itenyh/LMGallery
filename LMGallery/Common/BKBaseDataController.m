//
//  BKBaseDataController.m
//  BKWeiyun
//  基础数据操作类，操作基础的plist读写以及文件夹建立等操作
//  Created by Big_Krist on 13-1-8.
//  Copyright (c) 2013年 beikr developer 1. All rights reserved.
//

#import "BKBaseDataController.h"
//#import "BKUIUtil.h"
//#import "BKDirDBOperator.h"
//#import "BKLocationDBOperator.h"
//#import "BKFileDBOperator.h"
#import "BKBaseFunctions.h"
//#import "BKDataController.h"
//#import "BKAppDelegate.h"
//#import "FMDatabase.h"
//#import "FMDatabaseQueue.h"
//#import "BKShareKitManager.h"


static NSArray *areaArrayInBundle = nil;

@interface BKBaseDataController ()

+ (NSMutableDictionary*)getMultiInfoOfTheNowUserInfo;   //以可变Dictionary的形式获取当前登录用户的信息
+ (NSString*)getLocationNameWith:(NSString*)locationCode andSourceArray:(NSArray*)sourceArray;
@end

@implementation BKBaseDataController

+ (id)getConfigInfo:(NSString *)key {
	NSDictionary *configInfo = [BKBaseDataController getTheNowUserDicInfo];
	if ([configInfo objectForKey:key]) return [configInfo objectForKey:key];
	else return nil;
}
+ (void)checkTheNowUserPlist
{
    //检查目前使用当中的用户的Plist信息
    NSArray *dicArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString  *baseDicPath = [dicArray objectAtIndex:0];
    NSString *targetPath = [baseDicPath stringByAppendingPathComponent:NowUserPlistName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:targetPath])
        return;
    
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    [tempDic writeToFile:targetPath atomically:YES];
}


+ (NSString*)getTheNowUserPlistPath
{
    //获取NowUserPlist的具体路径
    NSArray *dicArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *baseDicPath = [dicArray objectAtIndex:0];
    return  [baseDicPath stringByAppendingPathComponent:NowUserPlistName];
}

+ (void)removeAllKeysInDic
{
    NSMutableDictionary *configInfo = [NSMutableDictionary dictionaryWithDictionary:[BKBaseDataController getTheNowUserDicInfo]];
    if(configInfo == nil)
        return;
    
    [configInfo removeAllObjects];
    [configInfo writeToFile:[BKBaseDataController getTheNowUserPlistPath] atomically:YES];
}

+ (NSDictionary*)getTheNowUserDicInfo
{
    //获取现在使用中的用户的信息
    NSString *nowUserPath = [BKBaseDataController getTheNowUserPlistPath];
    return [NSDictionary dictionaryWithContentsOfFile:nowUserPath];
}

+ (id)getTheNowUserValueByKey:(NSString *)key
{
    //获取目前登录用户的指定信息
    if(key == nil)
        return nil;
    
    NSDictionary *dicInfo = [BKBaseDataController getTheNowUserDicInfo];

//    NSLog(@"dic Info %@",dicInfo);
    return [dicInfo objectForKey:key];
}

+ (NSMutableDictionary*)getMultiInfoOfTheNowUserInfo
{
    //以可变Dictionary的形式获取当前登录用户的信息
    NSString *nowUserPath = [BKBaseDataController getTheNowUserPlistPath];
    NSMutableDictionary *retDic = [NSMutableDictionary dictionaryWithContentsOfFile:nowUserPath];
    if(retDic == nil) retDic = [NSMutableDictionary dictionary];
    return retDic;
}

+ (BOOL)updateTheNowUserInfoWith:(NSDictionary *)targetDic
{
    //将targetDic中的信息更新到NowUserInfo中
    NSMutableDictionary *dicToUpdate = [BKBaseDataController getMultiInfoOfTheNowUserInfo];
    NSArray *allKeys = [targetDic allKeys];
    for(NSString *subKey in allKeys)
    {
        [dicToUpdate setObject:[targetDic objectForKey:subKey] forKey:subKey];
    }
    NSString *dicPath = [BKBaseDataController getTheNowUserPlistPath];
   BOOL isSuc =[dicToUpdate writeToFile:dicPath atomically:YES];
    return isSuc;
    
}

+ (BOOL)isTheNowUserInTeam {
	NSDictionary *userInfo = [BKBaseDataController getTheNowUserValueByKey:@"user_info"];
	if (userInfo && [userInfo isKindOfClass:[NSDictionary class]]) {
		NSDictionary *teamInfo = [userInfo objectForKey:@"team_info"];
		if (teamInfo && [teamInfo isKindOfClass:[NSDictionary class]] && [[teamInfo objectForKey:@"team_id"] intValue] > 0) return YES;
	}
	return NO;
}

+ (NSDictionary *)getTheNowUserTeamInfo {
	NSDictionary *userInfo = [BKBaseDataController getTheNowUserValueByKey:@"user_info"];
	if (userInfo && [userInfo isKindOfClass:[NSDictionary class]]) {
		NSDictionary *teamInfo = [userInfo objectForKey:@"team_info"];
		if (teamInfo && [teamInfo isKindOfClass:[NSDictionary class]]) return teamInfo;
		else [NSDictionary dictionary];
	}
	return nil;
}

+ (BOOL)userCanPostTeamNote {
	NSDictionary *teamInfo = [BKBaseDataController getTheNowUserTeamInfo];
	if (teamInfo) {
		if ([teamInfo objectForKey:@"powerInfo"] && [[[teamInfo objectForKey:@"powerInfo"] objectForKey:@"note"] boolValue])
			return YES;
	}
	return NO;
}

+ (BOOL)userCanPostTeamPic {
	NSDictionary *teamInfo = [BKBaseDataController getTheNowUserTeamInfo];
	if (teamInfo) {
		if ([teamInfo objectForKey:@"powerInfo"] && [[[teamInfo objectForKey:@"powerInfo"] objectForKey:@"pic"] boolValue])
			return YES;
	}
	return NO;
}

+ (BOOL)userCanPostTeamVideo {
	NSDictionary *teamInfo = [BKBaseDataController getTheNowUserTeamInfo];
	if (teamInfo) {
		if ([teamInfo objectForKey:@"powerInfo"] && [[[teamInfo objectForKey:@"powerInfo"] objectForKey:@"video"] boolValue])
			return YES;
	}
	return NO;
}

+ (BOOL)userCanPostTeamNews {
	NSDictionary *teamInfo = [BKBaseDataController getTheNowUserTeamInfo];
	if (teamInfo) {
		if ([teamInfo objectForKey:@"powerInfo"] && [[[teamInfo objectForKey:@"powerInfo"] objectForKey:@"news"] boolValue])
			return YES;
	}
	return NO;
}

+ (BOOL)userCanManageTeamMember {
	NSDictionary *teamInfo = [BKBaseDataController getTheNowUserTeamInfo];
	if (teamInfo) {
		if ([teamInfo objectForKey:@"powerInfo"] && [[[teamInfo objectForKey:@"powerInfo"] objectForKey:@"member"] boolValue])
			return YES;
	}
	return NO;
}

+ (BOOL)changeTheNowUserInfoWith:(NSDictionary *)targetDic
{
    //将targetDic中的信息替换到NowUserInfo中，放弃NowUserInfo原来的数据
    NSMutableDictionary *dicToUpdate = [BKBaseDataController getMultiInfoOfTheNowUserInfo];
    [dicToUpdate removeAllObjects];
    NSArray  *allKeys = [targetDic allKeys];
    for(NSString *subKey in allKeys)
    {
        [dicToUpdate setObject:[targetDic objectForKey:subKey] forKey:subKey];
    }
    NSString *dicPath = [BKBaseDataController getTheNowUserPlistPath];
    [dicToUpdate writeToFile:dicPath atomically:YES];
    return YES;
}

+ (BOOL)updateTheNowUserInfoWith:(id)theValue ofKey:(NSString *)theKey
{
    //将NowUserInfo进行相应的key,value改变
    NSMutableDictionary *dicToUpdate = [BKBaseDataController getMultiInfoOfTheNowUserInfo];
    [dicToUpdate setObject:theValue forKey:theKey];
    NSString *dicPath = [BKBaseDataController getTheNowUserPlistPath];
    [dicToUpdate writeToFile:dicPath atomically:YES];
    return YES;
}

+ (BOOL)updateTheInSideNowUserInfoWith:(id)theValue ofKey:(NSString *)theKey
{
    //将NowUserInfo进行相应的key,value改变
    NSMutableDictionary *dicToUpdate = [BKBaseDataController getMultiInfoOfTheNowUserInfo];
    NSMutableDictionary *userInfo = (NSMutableDictionary *)[dicToUpdate objectForKey:@"user_info"];
    [userInfo setObject:theValue forKey:theKey];
    [dicToUpdate setObject:userInfo forKey:@"user_info"];
    NSString *dicPath = [BKBaseDataController getTheNowUserPlistPath];
    [dicToUpdate writeToFile:dicPath atomically:YES];
    return YES;
}

+ (BOOL)updateTheInSideNowUserInfoWithDic:(NSDictionary *)dic
{
    NSArray  *allKeys = [dic allKeys];
    for(NSString *subKey in allKeys)
    {
        [self updateTheInSideNowUserInfoWith:[dic objectForKey:subKey] ofKey:subKey];
    }
    return YES;
}

//+ (void)updateSinaWeiboInfoWith:(NSDictionary *)dicInfo
//{
//    NSString *baseDocumentStr = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSString *plistPath = [baseDocumentStr stringByAppendingPathComponent:BKSinaWeiboPlistInfo];
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    if(![fileManager fileExistsAtPath:plistPath])
//    {
//        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] init];
//        [tempDic writeToFile:plistPath atomically:YES];
//    }
//    
//    NSMutableDictionary *targetDic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
//    NSArray *allKey = [dicInfo allKeys];
//    for(NSString *subKey in allKey)
//    {
//        [targetDic setObject:[dicInfo objectForKey:subKey] forKey:subKey];
//    }
//    [targetDic writeToFile:plistPath atomically:YES];
//}

//+ (NSString*)getSinaWeiboInfoWith:(NSString *)targetKey
//{
//    NSString *baseDocumentStr = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSString *plistPath = [baseDocumentStr stringByAppendingPathComponent:BKSinaWeiboPlistInfo];
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    if(![fileManager fileExistsAtPath:plistPath])
//        return nil;
//    
//    NSDictionary *targetDic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
//    return [targetDic objectForKey:targetKey];
//}

+ (BOOL)removeTheInSideNowUserInfoKey:(NSString *)key {
    NSMutableDictionary *dicToUpdate = [BKBaseDataController getMultiInfoOfTheNowUserInfo];
    NSMutableDictionary *userInfo = (NSMutableDictionary *)[dicToUpdate objectForKey:@"user_info"];
    [userInfo removeObjectForKey:key];
    [self updateTheNowUserInfoWith:userInfo ofKey:@"user_info"];
    
    return YES;
}

+ (NSString *)getTheInSideNowUserInfoWithKey:(NSString *)theKey
{
    //将NowUserInfo进行相应的key,value改变
    NSMutableDictionary *dicToUpdate = [BKBaseDataController getMultiInfoOfTheNowUserInfo];
    NSMutableDictionary *userInfo = (NSMutableDictionary *)[dicToUpdate objectForKey:@"user_info"];
    return [userInfo objectForKey:theKey];
}

+ (BOOL)isHoneyExist
{
    return [self getTheInSideNowUserInfoWithKey:@"honey_info"] != nil;
}

+ (NSString *)getTheHoneyValueWithKey:(NSString *)key
{
    if ([self isHoneyExist]) {
        NSMutableDictionary *dicToUpdate = [BKBaseDataController getMultiInfoOfTheNowUserInfo];
        NSMutableDictionary *userInfo = (NSMutableDictionary *)[dicToUpdate objectForKey:@"user_info"];
        NSDictionary *dic = [userInfo objectForKey:@"honey_info"];
        return [dic objectForKey:key];
    }
    
    return nil;
}
//+ (void)prepareForTheUserData
//{
//    [BKBaseDBOperator checkDbForNowLoginUser];
//    int theFileLasestUpdataTime = [BKBaseDBOperator getTheLatestTimeOfFileTable];
//	int theDirLasestUpdataTime = [BKBaseDBOperator getTheLatestDirTime];
//	int theLocationLasestUpdataTime = [BKBaseDBOperator getTheLatestLocationTime];
//	[BKInternetInterfaceInvoke syncDataWithLatestTimeStamp:theFileLasestUpdataTime earliestTimeStamp:0 dirTimeStamp:theDirLasestUpdataTime locationTimeStamp:theLocationLasestUpdataTime withSuccessBlock:^(id retId) {
////        NSLog(@"sync retCount is %@", retId);
//        int totalCount = [[retId objectForKey:@"total_count"] intValue];
//        NSDictionary *totalCountDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",totalCount],@"totalCount", nil];
//        [[NSNotificationCenter defaultCenter] postNotificationName:GetTotalSyncInfoCountNoti object:nil userInfo:totalCountDic];
//        dispatch_async(gQueueT, ^{
//            int dirTimeStamp = [[retId objectForKey:@"dir_time"] intValue];
//            [BKBaseDBOperator updateTheTUpdateTimeWith:@"t_dir" andUpdateTime:dirTimeStamp];
//            int locationTimeStamp = [[retId objectForKey:@"location_time"] intValue];
//            [BKBaseDBOperator updateTheTUpdateTimeWith:@"t_location" andUpdateTime:locationTimeStamp];
//            int fileTimeStamp = [[retId objectForKey:@"file_time"] intValue];
//            [BKBaseDBOperator updateTheTUpdateTimeWith:@"t_file" andUpdateTime:fileTimeStamp];
//            
//            NSArray *dirList = [retId objectForKey:@"dir_list"];
//            [BKDirDBOperator updateDirList:dirList];
//            NSArray *locationList = [retId objectForKey:@"location_list"];
//            [BKLocationDBOperator updateLocationList:locationList];
//            NSArray *fileArray = [retId objectForKey:@"file_list"];
//            [BKFileDBOperator updateFileList:fileArray];
//        });
//    } andFailBlock:^(NSDictionary *errorDic) {
//        NSLog(@"sync error is %@",errorDic);
//        dispatch_async(gMainQueue, ^{
//            [[NSNotificationCenter defaultCenter] postNotificationName:BKFinishSyncAllInfosNoti object:nil];
//        });
//    }];
//}


+ (NSString*)getAreaNameWithAreaCode:(NSString *)targetAreaCode {
	//通过地区code来获取地区名称
	if(areaArrayInBundle == nil) {
        NSString *thePath = [[NSBundle mainBundle] pathForResource:@"areas.bk" ofType:nil];
        NSError *error;
        NSString *json = [NSString stringWithContentsOfFile:thePath encoding:NSUTF8StringEncoding error:&error];
		NSArray *chinaArea = [BKBaseFunctions jsonValueFromStr:json];
		thePath = [[NSBundle mainBundle] pathForResource:@"country.bk" ofType:nil];
        json = [NSString stringWithContentsOfFile:thePath encoding:NSUTF8StringEncoding error:&error];
		NSArray *country = [BKBaseFunctions jsonValueFromStr:json];
        areaArrayInBundle = [NSArray arrayWithObjects:chinaArea, country, nil];
    }
    return [BKBaseDataController getLocationNameWith:targetAreaCode andSourceArray:areaArrayInBundle];
}

+ (NSString*)getLocationNameWith:(NSString *)locationCode andSourceArray:(NSArray *)sourceArray {
	for (NSArray *areas in sourceArray) {
		for(NSDictionary *subDic in areas) {
			if([[subDic objectForKey:@"code"] isEqualToString:locationCode]) {
				return [subDic objectForKey:@"name"];
			} else {
				NSArray *subArray = [subDic objectForKey:@"children"];
				if(subArray != nil && subArray.count != 0) {
					NSString *subRet = [BKBaseDataController getLocationNameWith:locationCode andSourceArray:[NSArray arrayWithObject:subArray]];
					if(![subRet isEqualToString:locationCode]) return subRet;
				}
			}
		}
	}
    return locationCode;
}

//+ (void)updateToTheNewestData
//{
//    int theFileLasestUpdataTime = [BKBaseDBOperator getTheLatestTimeOfFileTable];
//    int theFileEarlestUpdateTime = [BKBaseDBOperator getTheEarliestTimeOfFileTable];
//    int theDirLasestUpdataTime = [BKBaseDBOperator getTheLatestDirTime];
//    int theLocationLasestUpdataTime = [BKBaseDBOperator getTheLatestLocationTime];
//    
//    id retInfo = [BKSynInvokeApi invokeTheApi:SyncDataFromBKServer
//                                    withParam:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",theFileLasestUpdataTime],@"latest_time",[NSString stringWithFormat:@"%d",theFileEarlestUpdateTime],@"earliest_time",[NSString stringWithFormat:@"%d",theDirLasestUpdataTime],@"dir_time",[NSString stringWithFormat:@"%d",theLocationLasestUpdataTime],@"location_time", nil]];
//    
//    if([retInfo isKindOfClass:[NSDictionary class]] && [retInfo objectForKey:@"error_code"] == nil)
//    {
//        NSArray *dirList = [retInfo objectForKey:@"dir_list"];
//        [BKDirDBOperator updateDirList:dirList];
//        NSArray *locationList = [retInfo objectForKey:@"location_list"];
//        [BKLocationDBOperator updateLocationList:locationList];
//        NSArray *fileArray = [retInfo objectForKey:@"file_list"];
//        [BKFileDBOperator updateFileList:fileArray];
//    }
//}


+ (NSString*)getTheAppCacheDataPath
{
    //NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *theCacheDirectoryPath = [paths objectAtIndex:0];
    NSString *retValue = [theCacheDirectoryPath stringByAppendingPathComponent:@"TheAppData"];
    BOOL isDir;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:retValue isDirectory:&isDir] && isDir)
        return retValue;
    
    NSError *error;
    BOOL createRet = [fileManager createDirectoryAtPath:retValue withIntermediateDirectories:YES attributes:nil error:&error];
    if(!createRet)
        return nil;
    
    return retValue;
}

//+ (void)createTheAppUserDbQueue
//{
//    NSDictionary *nowUser = [BKBaseDataController getTheNowUserDicInfo];
//    if(nowUser == nil) return;
//    NSString *UID = [nowUser objectForKey:@"UID"];
//    if(UID == nil) return;
//    NSString *theDbName = [NSString stringWithFormat:@"%@.db",UID];
//    BKAppDelegate *appDel = (BKAppDelegate*)[UIApplication sharedApplication].delegate;
//    appDel.dbQueue = [[FMDatabaseQueue alloc] initWithPath:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:theDbName]];
//    [BKDataController initDatabase];
//
//}


+ (BOOL)isUserHasLogin
{
    //判断用户是否登录，改版后此方法将贯穿全局
    NSString *nowUserId = [BKBaseDataController getTheNowUserValueByKey:@"UID"];
    if(nowUserId == nil) return NO;
    return YES;
}

+ (BOOL)checkUserLoginStateOnSomeClickEvent
{
    if(![BKBaseDataController isUserHasLogin])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:BKNoticeUserShuldLoginNoti object:nil];
        return NO;
    }
    return YES;
}


#pragma mark -
#pragma mark 合并原来处在其他文件的基础函数到这个包
+ (NSString*)getTheBaseCachePath
{
    NSArray *tempDirArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [tempDirArray objectAtIndex:0];
}

+ (NSString *)getTheRemoteNotiProcessQueuePath
{
    NSString *baseCachePath = [BKBaseDataController getTheBaseCachePath];
    NSString *retPath = [baseCachePath stringByAppendingPathComponent:RemoteNotiProcessQueue];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:retPath]) return retPath;
    NSMutableDictionary *dicInfo = [[NSMutableDictionary alloc] init];
    [dicInfo writeToFile:retPath atomically:YES];
    return retPath;
}

+ (void)deleteTheFilesInDirectory:(NSString *)directoryPath
{
    //删除在临时文件夹里面的文件
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if([fileManager fileExistsAtPath:directoryPath isDirectory:&isDir])
    {
        //当文件存在才进行迭代处理，不存在就不处理
        if(isDir)
        {
            NSArray *tempFileArray = [fileManager contentsOfDirectoryAtPath:directoryPath error:nil];
            if(tempFileArray == nil) return;
            if(tempFileArray.count == 0 && ![directoryPath isEqualToString:NSTemporaryDirectory()])
            {
                [fileManager removeItemAtPath:directoryPath error:nil];
                //NSLog(@"删除文件夹 --> %@",directoryPath);
                return;
            }
            NSEnumerator *fileEnum = [tempFileArray objectEnumerator];
            NSString *fileName;
            while ((fileName = [fileEnum nextObject]) != nil) {
                [BKBaseDataController deleteTheFilesInDirectory:[directoryPath stringByAppendingPathComponent:fileName]];
            }
            if(![directoryPath isEqualToString:NSTemporaryDirectory()])
            {
                //NSLog(@"删除文件夹 --> %@",directoryPath);
                [fileManager removeItemAtPath:directoryPath error:nil];
            }
        }
        else
        {
            //当是一个文件则删除
            [fileManager removeItemAtPath:directoryPath error:nil];
            //NSLog(@"删除->%@",directoryPath);
        }
    }
}

+ (NSString*)checkUploadTmpDirsWith:(NSString *)targetUserId andDirName:(NSString *)tempDirName
{
    //检查上传的临时文件夹
    BOOL isDir;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *baseCacheDirPath = [BKBaseDataController getTheBaseCachePath];
    NSString *uidPathUnderCache = [baseCacheDirPath stringByAppendingPathComponent:targetUserId];
    if(!([fileManager fileExistsAtPath:uidPathUnderCache isDirectory:&isDir] && isDir))
    {
        [fileManager createDirectoryAtPath:uidPathUnderCache withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *tmpUploadDirPath = [uidPathUnderCache stringByAppendingPathComponent:@"TmpUpload"];
    if(!([fileManager fileExistsAtPath:tmpUploadDirPath isDirectory:&isDir] && isDir))
    {
        [fileManager createDirectoryAtPath:tmpUploadDirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *lastTargetDirPath = [tmpUploadDirPath stringByAppendingPathComponent:tempDirName];
    if(!([fileManager fileExistsAtPath:lastTargetDirPath isDirectory:&isDir] && isDir))
    {
        [fileManager createDirectoryAtPath:lastTargetDirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return lastTargetDirPath;
}



@end
