//
//  MRZoomScrollView.h
//  ScrollViewWithZoom
//
//  Created by xuym on 13-3-27.
//  Copyright (c) 2013年 xuym. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@class MRZoomScrollView;
@protocol MRZoomScrollViewDelegate <NSObject>;
@optional
- (void)MRZoomScrollViewSingleTouch:(MRZoomScrollView *)scrollView;

@end

@interface MRZoomScrollView : UIScrollView <UIScrollViewDelegate, EGOImageViewDelegate>
{
    UIView *bottomView;
    UIActivityIndicatorView *indicator;
}

@property (nonatomic, retain) EGOImageView *locimageView;
@property (nonatomic, assign) id<MRZoomScrollViewDelegate> mrDelegate;

- (void)resizeToOriginal;
- (void)setTheImageView:(NSString *)url;

@end
