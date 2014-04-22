//
//  BKAlterView.h
//  PregnancyParter
//
//  Created by 显宏 黄 on 12-7-11.
//  Copyright (c) 2012年 beikr.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum {
    BKMsgInfo, //信息
    BKMsgError //错误
}BKMsg;

@interface BKAlertView : UIView{

    UILabel *_msglabel;
}
@property(nonatomic,retain) UILabel *msglabel;
+(void)showMsg:(NSString *)msg type:(BKMsg)type inview:(UIView*)inview offsetY:(float)offsetY;
+(void)showInfoMsg:(NSString *)msg inview:(UIView*)inview offsetY:(float)offsetY;
+(void)showErrorMsg:(NSString *)msg inview:(UIView*)inview offsetY:(float)offsetY;
- (id)initWithFrame:(CGRect)frame andType:(BKMsg)type withMsg:(NSString *)msg offsetY:(float)offsetY;
@end
