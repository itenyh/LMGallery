//
//  BKAlterView.m
//  PregnancyParter
//
//  Created by 显宏 黄 on 12-7-11.
//  Copyright (c) 2012年 beikr.com. All rights reserved.
//

#import "BKAlertView.h"
//#import "UIUtil.h"

@interface BKAlertView()
-(void)hideMessage;
@end

@implementation BKAlertView
@synthesize msglabel=_msglabel;

+(void)showMsg:(NSString *)msg type:(BKMsg)type inview:(UIView*)inview offsetY:(float)offsetY{
//    BOOL ish = [[UIApplication sharedApplication] isStatusBarHidden];
    BKAlertView *alt = [[BKAlertView alloc] initWithFrame:CGRectMake(0, 0, inview.bounds.size.width,inview.bounds.size.height) andType:type withMsg:msg offsetY:offsetY];
//    alt.msglabel.text = msg;
    alt.alpha = 0.0f;
    [inview addSubview:alt];
    [UIView animateWithDuration:0.3 animations:^{
        alt.alpha = 1.0f;
    }];
    alt=nil;
}
+(void)showInfoMsg:(NSString *)msg inview:(UIView*)inview offsetY:(float)offsetY{
    [BKAlertView showMsg:msg type:BKMsgInfo inview:inview offsetY:offsetY];
}
+(void)showErrorMsg:(NSString *)msg inview:(UIView*)inview offsetY:(float)offsetY{
    [BKAlertView showMsg:msg type:BKMsgError inview:inview offsetY:offsetY];
}

- (id)initWithFrame:(CGRect)frame andType:(BKMsg)type withMsg:(NSString *)msg offsetY:(float)offsetY
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIFont *disF = [UIFont boldSystemFontOfSize:18];
        int sw = [msg sizeWithFont:disF].width + 40;
        int tw = 140;
        if (sw >140) {
            tw = sw;
        }
        if (sw>300) {
            tw = 300;
        }
        
        CGSize lz = [msg sizeWithFont:disF constrainedToSize:CGSizeMake(tw, 500)];
        int th = 140;
        if (lz.height+50<140) {
            th = 140;
        }
       
        int x = (frame.size.width-tw)/2;
        int y = (frame.size.height-th)/2;
        
        
        
        UIView *tank = [[UIView alloc] initWithFrame:CGRectMake(x, y + offsetY, tw, th)];
        tank.layer.cornerRadius = 5;
//        tank.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.63];
        tank.backgroundColor = [UIManage color:@"ffffff" alpha:0.2];
        
        NSString *imgname = @"ATick.png";
        if (type==BKMsgError) {
            imgname = @"Error.png";
        }
        UIImage *img = [UIImage imageNamed:imgname];
        UIImageView *imgview = [[UIImageView alloc] initWithImage:img];
        imgview.frame = CGRectMake((tw - img.size.width)/2,30, img.size.width, img.size.height);
        [tank addSubview:imgview];
        imgview=nil;
        
        _msglabel = [[UILabel alloc] initWithFrame:CGRectMake(0,th-55 ,tw, lz.height)];
        _msglabel.textAlignment = NSTextAlignmentCenter;
        _msglabel.backgroundColor = [UIColor clearColor];
        _msglabel.font = disF;
        _msglabel.numberOfLines = 0;
        _msglabel.textColor = [UIColor whiteColor];
        _msglabel.text = msg;
        
        [tank addSubview:_msglabel];
        
        [self addSubview:tank];
        tank=nil;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = frame;
        [btn addTarget:self action:@selector(hideMessage) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        [self performSelector:@selector(hideMessage) withObject:nil afterDelay:3];
    }
    return self;
}
- (void)dealloc {
//    [_msglabel release],
    _msglabel=nil;
//    [super dealloc];
}
-(void)hideMessage{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
