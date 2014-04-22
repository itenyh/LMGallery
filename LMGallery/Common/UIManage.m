//
//  UIManage.m
//  BKWeiYun2
//
//  Created by itenyh on 13-5-30.
//  Copyright (c) 2013年 beikr. All rights reserved.
//

#import "UIManage.h"
#import "Reachability.h"

static BOOL is568;
static float appWidth = 0;
static float appHeight = 0;
//static BOOL isConstraint_;
static BOOL is568;

@implementation UIManage

+ (float)getAppWidth
{
    if(appWidth != 0) return appWidth;
    CGRect appFrame = [[UIScreen mainScreen] applicationFrame];
    appWidth = appFrame.size.width;
    return appWidth;
}

+ (float)getAppHeight
{
    if(appHeight != 0) return appHeight;
    CGRect appFrame = [[UIScreen mainScreen] applicationFrame];
    appHeight = appFrame.size.height;
    return appHeight;
}

+ (void)initUIManageWithView:(UIView *)view
{
    CGFloat height = 0;
    height = [[UIScreen mainScreen] bounds].size.height;
    is568 = height >= 568;
}

+ (BOOL)is568
{
    return is568;
}
+ (NSString *)createXibOrImageName:(NSString *)baseName
{
    if(is568)
    {
        return [baseName stringByAppendingString:@"-568h"];
    }
    else
    {
        return baseName;
    }
}

+ (NSString*)getEgoLocalImgPathWith:(NSURL *)fileUrl
{
    NSString *cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *EGOCacheDirectory = [[cachesDirectory stringByAppendingPathComponent:[[NSProcessInfo processInfo] processName]] stringByAppendingPathComponent:@"EGOCache"];
    NSString *key = [NSString stringWithFormat:@"EGOImageLoader-%u", [[fileUrl description] hash]];
    NSString *filePath = [EGOCacheDirectory stringByAppendingPathComponent:key];
    return filePath;
}

+ (UIInterfaceOrientation)getNowAppOrientation
{
    UIDevice *currentDevice = [UIDevice currentDevice];
    UIDeviceOrientation deviceOritation = currentDevice.orientation;
    switch (deviceOritation) {
        case UIDeviceOrientationUnknown:
            return UIInterfaceOrientationPortrait;
            break;
        case UIDeviceOrientationPortrait:
            return UIInterfaceOrientationPortrait;
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            return UIInterfaceOrientationPortrait;
            break;
        case UIDeviceOrientationLandscapeLeft:
            return UIInterfaceOrientationLandscapeRight;
            break;
        case UIDeviceOrientationLandscapeRight:
            return UIInterfaceOrientationLandscapeLeft;
            break;
        default:
            break;
    }
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if(orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        return UIInterfaceOrientationPortrait;
    }
    else
    {
        return orientation;
    }
}

+ (CGSize)createImgSize:(UIImage *)image
{
    float screenWidth = [UIManage getAppWidth];
    float imageWidth = image.size.width;
    float scaledImgHeight = screenWidth * image.size.height / imageWidth;
    
    if (scaledImgHeight > [UIManage getAppHeight]) {
        scaledImgHeight = [UIManage getAppHeight];
        screenWidth = scaledImgHeight * image.size.width / image.size.height;
    }
    
    return CGSizeMake(screenWidth, scaledImgHeight);
}

#pragma - coming from BKUIUtil
+ (UIImage*)createStrechImageWith:(UIImage*)targetImage AndEdgInset:(UIEdgeInsets)targetEdgInset
{
    return [targetImage resizableImageWithCapInsets:targetEdgInset];
}

+(UIColor *)color:(float)red blue:(float)blue green:(float)green alpha:(float)alpha{
    
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
}

+(UIColor *)color:(NSString *)hex{
    return [UIManage color:hex alpha:1.0];
}

+(UIColor *)color:(NSString *)hex alpha:(float)alpha{
    if ([hex characterAtIndex:0]=='#') {
        hex = [hex substringFromIndex:1];
    }
    NSString *rs = [hex substringWithRange:NSMakeRange(0, 2)];
    long r = strtol([rs UTF8String],NULL, 16);
    NSString *gs = [hex substringWithRange:NSMakeRange(2, 2)];
    long g = strtol([gs UTF8String],NULL, 16);
    NSString *bs = [hex substringWithRange:NSMakeRange(4, 2)];
    long b = strtol([bs UTF8String],NULL, 16);
    return [UIManage color:r blue:b green:g alpha:alpha];
}

//- (UIImage *)createCropperredImg:(UIImage *)fullImage
//{
//    float fullW = fullImage.size.width;
//    float fullH = fullImage.size.height;
//    float drawW;
//    float drawH;
//    
//    if (fullW > fullH) {
//        drawH = EditUploadImgHeight * 2;
//        drawW = fullW / (fullH / drawH);
//    } else {
//        drawW = EditUploadImgWidth * 2;
//        drawH = fullH / (fullW / drawW);
//    }
//    
//    UIGraphicsBeginImageContext(CGSizeMake(drawW, drawH));
//    [fullImage drawInRect:CGRectMake(0, 0, drawW, drawH)];
//    UIImage *tempThumbImage = UIGraphicsGetImageFromCurrentImageContext();
//    NLImageCropperView *_imageCropper = [[NLImageCropperView alloc] initWithFrame:CGRectMake(0, 0, [UIManage getAppWidth], [UIManage getAppHeight])];
//    [_imageCropper setImage:tempThumbImage];
//    [_imageCropper setCropRegionRect:CGRectMake(0, 0, 67 * 2, 58 * 2)];
//    UIImage *thumbImage = [_imageCropper getCroppedImage];
//    UIGraphicsEndImageContext();
//   
//}

#pragma itenyh--defined functions
+ (float)xFromLeftView:(UIView *)view
{
    return view.frame.size.width + view.frame.origin.x;
}

+ (float)yFromTopView:(UIView *)view
{
    return view.frame.size.height + view.frame.origin.y;
}

+ (CGSize)text:(NSString *)text sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    if ([BKBaseFunctions getIosVer] >= 7.0f)
    {
        CGRect frame = [text boundingRectWithSize:size
                                          options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                       attributes:@{NSFontAttributeName:font}
                                          context:nil];
        return frame.size;
    }
    else
    {
        return [text sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    }
}

@end
