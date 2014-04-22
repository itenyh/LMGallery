//
//  BKNetKit.m
//  iRally
//
//  Created by 蔡凌 on 13-9-4.
//  Copyright (c) 2013年 蔡凌. All rights reserved.
//

#import "BKNetKit.h"
#import "Reachability.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "BKBaseFunctions.h"
#import "BKBaseDataController.h"
#import "SBJson.h"

#define EXP [NSArray arrayWithObjects:@"user/reg",@"oauth/access_token", nil]

static long totalsize=0;
static int loopDepth = 0;

@implementation BKNetKit

+ (BKNetType)getNowNetSituation
{
    //获取当前网络状态
    BKNetType retValue;
    Reachability *t = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([t currentReachabilityStatus]) {
        case NotReachable:
            retValue = BKNet_NONE;    //没有网络
            break;
            
        case ReachableViaWWAN:
            retValue = BKNet_WWAN;    //WWAN网络
            break;
            
        case ReachableViaWiFi:
            retValue = BKNet_WIFI;    //WIFI网络
            break;
            
        default:
            retValue = BKNet_NONE;
            break;
    }
    return retValue;
}

+ (id)invokeTheApi:(NSString *)apiName withParam:(NSDictionary *)param
{
    //    NSLog(@"调用API接口 -> apiName: %@", apiName);
    
//    ASIFormDataRequest *requstHttp  = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    ASIFormDataRequest *requstHttp  = [[ASIFormDataRequest alloc] init];
    [requstHttp setRequestMethod:@"GET"];
	[requstHttp setAllowCompressedResponse:YES];
    
    NSMutableString *url = [NSMutableString stringWithFormat:@"%@%@", BK_PREURL, apiName];
    
    if ([requstHttp.requestMethod isEqualToString:@"GET"]) {
        
        int index = 0;
        NSArray *paramKeys = [param allKeys];
        if (paramKeys != nil) {
            for(NSString *subKey in paramKeys)
            {
                if (index == 0) {
                    [url appendFormat:@"?%@=%@", subKey, [param objectForKey:subKey]];
                }
                
                else {
                    [url appendFormat:@"&%@=%@", subKey, [param objectForKey:subKey]];
                }
            }
        }
        
    }
    
    else {
        
        NSArray *paramKeys = [param allKeys];
        if (paramKeys != nil) {
            for(NSString *subKey in paramKeys)
            {
                [requstHttp setPostValue:[param objectForKey:subKey] forKey:subKey];
            }
        }
        
        NSInteger nowTimeStamp = [[NSDate date] timeIntervalSince1970];
        [requstHttp setPostValue:BK_APP_KEY forKey:@"client_id"];
        [requstHttp setPostValue:[BKBaseFunctions createSignatureWithTimaStamp:nowTimeStamp] forKey:@"signature"];
        [requstHttp setPostValue:[NSString stringWithFormat:@"%d",nowTimeStamp] forKey:@"time_stamp"];
        
    }
   
    NSLog(@"The url requested is : %@", url);
    requstHttp.url = [NSURL URLWithString:url];
    [requstHttp buildRequestHeaders];
    [requstHttp startSynchronous];
    if([requstHttp error])
    {
        return [BKBaseFunctions returnError:902 errStr:@"request_failed" errDesc:@"网络连接异常"];
    }
    
    @try {
		if ([requstHttp isResponseCompressed]) totalsize += [[requstHttp rawResponseData] length];
        else totalsize += [[requstHttp responseData] length];
        //NSLog(@"共请求:%ld byte",totalsize);
        
//        NSLog(@"[%@] ret: %@", apiName, [requstHttp responseString]);
        
		if ([requstHttp responseString] == nil || [[requstHttp responseString] length]==0) return nil;
        id retDic = [BKBaseFunctions jsonValueFromStr:[requstHttp responseString]];
		if (retDic == nil) {
            
            //			NSLog(@"[%@] ret: %@", apiName, [requstHttp responseString]);
			loopDepth = 0;
			return [BKBaseFunctions returnError:901 errStr:@"invalid_json" errDesc:@"JSON解析异常"];
		} else if([retDic isKindOfClass:[NSDictionary class]] && [retDic objectForKey:@"error_code"]) {
            if([[retDic objectForKey:@"error_code"] intValue] == 106)
            {
                //token过期了，要调用刷新token的方法
                if(![BKNetKit refreshLocalToken])
                {
                    NSLog(@"%@",@"刷新本地token失败");
                }
                else {
                    //NSLog(@"%@",@"刷新本地token成功");
					if (loopDepth == 0) {
						loopDepth ++;
						return [BKNetKit invokeTheApi:apiName withParam:param];
					}
                }
            }
            else if([[retDic objectForKey:@"error_code"] intValue] == 100)
            {
                //正确返回
                return retDic;
            }
        } else {
			loopDepth = 0;
		}
        return retDic;
    }
    @catch (NSException *exception) {
        NSLog(@"接口：%@ 数据异常",apiName);
        return [BKBaseFunctions returnError:901 errStr:@"invalid_json" errDesc:@"JSON解析异常"];
    }
    
    return nil;
}

+ (BOOL)refreshLocalToken
{
    //刷新本地token
    NSString *thisUid = [BKBaseDataController getTheNowUserValueByKey:@"UID"];
    if(thisUid == nil)
        return NO;
    
    ASIFormDataRequest *requestHttp = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@oauth/access_token", BK_PREURL]]];
    [requestHttp setRequestMethod:@"POST"];
	[requestHttp setAllowCompressedResponse:YES];
    NSInteger nowTimeStamp = [[NSDate date] timeIntervalSince1970];
    [requestHttp setPostValue:@"refresh_token" forKey:@"grant_type"];
    [requestHttp setPostValue:BK_APP_KEY forKey:@"client_id"];
    [requestHttp setPostValue:[BKBaseFunctions createSignatureWithTimaStamp:nowTimeStamp] forKey:@"signature"];
    [requestHttp setPostValue:[NSString stringWithFormat:@"%d",nowTimeStamp] forKey:@"time_stamp"];
    [requestHttp setPostValue:thisUid forKey:@"UID"];
    [requestHttp startSynchronous];
    if([requestHttp error])
    {
        NSLog(@"%@",@"刷新本地token网络异常");
        return NO;
    }
    
    @try {
        NSLog(@"鉴权接口返回：%@",requestHttp.responseString);
		if ([requestHttp responseString] == nil || [[requestHttp responseString] length]==0) return NO;
        id tokenDic = [BKBaseFunctions jsonValueFromStr:[requestHttp responseString]];
		if (tokenDic == nil) return NO;
        if([tokenDic isKindOfClass:[NSDictionary class]] && [tokenDic objectForKey:@"error_code"])
        {
            NSLog(@"%@ error_code is ---> %@",@"刷新本地token的接口返回错误",[tokenDic objectForKey:@"error_code"]);
            return  NO;
        }
		
        [BKBaseDataController updateTheNowUserInfoWith:[tokenDic objectForKey:@"access_token"] ofKey:@"access_token"];
		[BKBaseDataController updateTheNowUserInfoWith:[tokenDic objectForKey:@"create_time"] ofKey:@"create_time"];
		[BKBaseDataController updateTheNowUserInfoWith:[tokenDic objectForKey:@"expires_in"] ofKey:@"expires_in"];
		[BKBaseDataController updateTheNowUserInfoWith:[tokenDic objectForKey:@"UID"] ofKey:@"UID"];
        //		[BKBaseDataController updateTheNowUserInfoWith:[tokenDic objectForKey:@"nickname"] ofKey:@"nickname"];
		//更新最新的token到本地配置文件
        return YES;
    }
    @catch (NSException *exception) {
        NSLog(@"%@",@"刷新本地token的JSON解析错误");
        return NO;
    }
    
    return NO;
}


+ (id)loginWithEmail:(NSString*)theEmail AndPassWord:(NSString*)thePw
{
    //登录方法
    NSString *theLoginUrl = [NSString stringWithFormat:@"%@%@", BK_PREURL, @"oauth/access_token"];
    ASIFormDataRequest *requestHttp = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:theLoginUrl]];
    [requestHttp setRequestMethod:@"POST"];
	[requestHttp setAllowCompressedResponse:YES];
    NSInteger nowTimeStamp = [[NSDate date] timeIntervalSince1970];
    [requestHttp setPostValue:@"password" forKey:@"grant_type"];
    [requestHttp setPostValue:BK_APP_KEY forKey:@"client_id"];
    [requestHttp setPostValue:[BKBaseFunctions createSignatureWithTimaStamp:nowTimeStamp] forKey:@"signature"];
    [requestHttp setPostValue:[NSString stringWithFormat:@"%d",nowTimeStamp] forKey:@"time_stamp"];
    [requestHttp setPostValue:theEmail forKey:@"email"];
    [requestHttp setPostValue:thePw forKey:@"password"];
    [requestHttp startSynchronous];
    
    if([requestHttp error])
    {
        return [BKBaseFunctions returnError:902 errStr:@"request_failed" errDesc:@"网络连接异常"];
    }
    
    @try {
		if ([requestHttp responseString] == nil || [[requestHttp responseString] length]==0) return nil;
        //        NSLog(@"test %@",[requestHttp responseString]);
        id retDic = [BKBaseFunctions jsonValueFromStr:[requestHttp responseString]];
		if (retDic == nil) {
			//NSLog(@"login ret: %@", [requestHttp responseString]);
			return [BKBaseFunctions returnError:901 errStr:@"invalid_json" errDesc:@"JSON解析异常"];
		}
        return retDic;
    }
    @catch (NSException *exception) {
        return [BKBaseFunctions returnError:901 errStr:@"invalid_json" errDesc:@"JSON解析异常"];
    }
    
    return nil;
}

+ (id)verifyTheUserWith:(NSString *)theUid AndToken:(NSString *)theToken
{
    //利用token来鉴权
    NSString *theVerifyUrl =  [NSString stringWithFormat:@"%@%@", BK_PREURL, @"oauth/verify"];
    ASIFormDataRequest *requestHttp  = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:theVerifyUrl]];
    [requestHttp setRequestMethod:@"POST"];
	[requestHttp setAllowCompressedResponse:YES];
    NSInteger nowTimeStamp = [[NSDate date] timeIntervalSince1970];
    [requestHttp setPostValue:BK_APP_KEY forKey:@"client_id"];
    [requestHttp setPostValue:[BKBaseFunctions createSignatureWithTimaStamp:nowTimeStamp] forKey:@"signature"];
    [requestHttp setPostValue:[NSString stringWithFormat:@"%d",nowTimeStamp] forKey:@"time_stamp"];
    [requestHttp setPostValue:theUid forKey:@"UID"];
    [requestHttp setPostValue:theToken forKey:@"token"];
    [requestHttp startSynchronous];
    if([requestHttp error])
    {
        return [BKBaseFunctions returnError:902 errStr:@"request_failed" errDesc:@"网络连接异常"];
    }
    @try {
        //NSLog(@"theUid is %@, theToken is %@",theUid,theToken);
        //NSLog(@"responsStr is %@",requestHttp.responseString);
		if ([requestHttp responseString] == nil || [[requestHttp responseString] length]==0) return nil;
        id retDic = [BKBaseFunctions jsonValueFromStr:[requestHttp responseString]];
        if (retDic == nil) {
			//NSLog(@"verify ret: %@", [requestHttp responseString]);
			return [BKBaseFunctions returnError:901 errStr:@"invalid_json" errDesc:@"JSON解析异常"];
		}
		return retDic;
    }
    @catch (NSException *exception) {
        return [BKBaseFunctions returnError:901 errStr:@"invalid_json" errDesc:@"JSON解析异常"];
    }
    return nil;
}

+ (void)commonProcessTheData:(id)retValue RetBlock:(void (^)(id))successBlock andFailBlock:(void (^)(id))failBlock
{
    if(retValue == nil)
    {
        dispatch_async(gMainQueueT, ^{
            NSDictionary *errorDic = [NSDictionary dictionaryWithObjectsAndKeys:@"0000",@"error_code",@"返回异常",@"error_description", nil];
            failBlock(errorDic);
            
        });
    }
    else
    {
        int error_code = [[retValue objectForKey:@"error_code"] intValue];
        if(error_code == 100 || error_code == 0)
        {
            dispatch_async(gMainQueueT, ^{
                if([retValue objectForKey:@"data"] != nil)
                    successBlock([retValue objectForKey:@"data"]);
                else
                    successBlock(retValue);
            });
        }
        else
        {
            dispatch_async(gMainQueueT, ^{
                failBlock(retValue);
            });
        }
    }
}
@end
