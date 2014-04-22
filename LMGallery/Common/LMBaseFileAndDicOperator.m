//
//  BKBaseFileAndDicOperator.m
//  LMGallery
//
//  Created by Apple on 14-1-10.
//  Copyright (c) 2014年 lmodel. All rights reserved.
//

#define DarkBoxDicName @"com.-lmodel.LMGallery"
#import "LMBaseFileAndDicOperator.h"
#import "EGOCache.h"

@implementation LMBaseFileAndDicOperator

+ (void)clearCache
{
    //获取Cache文件夹根目录
    NSArray *dicArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
    NSString *baseCacheDirPath = [dicArray objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if(!([fileManager fileExistsAtPath:baseCacheDirPath isDirectory:&isDir] && isDir))
    {
        [fileManager createDirectoryAtPath:baseCacheDirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *darkBoxPath = [baseCacheDirPath stringByAppendingPathComponent:DarkBoxDicName];
    if(!([fileManager fileExistsAtPath:darkBoxPath isDirectory:&isDir] && isDir))
    {
        [fileManager createDirectoryAtPath:darkBoxPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    [LMBaseFileAndDicOperator deleteTheFilesInDirectory:NSTemporaryDirectory()];
    [LMBaseFileAndDicOperator  deleteTheFilesInDirectory:darkBoxPath];
    [[[EGOCache alloc] init] clearCache];
    
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
                [self deleteTheFilesInDirectory:[directoryPath stringByAppendingPathComponent:fileName]];
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

@end
