//
//  MRZoomScrollView.m
//  ScrollViewWithZoom
//
//  Created by xuym on 13-3-27.
//  Copyright (c) 2013年 xuym. All rights reserved.
//

#import "MRZoomScrollView.h"

#define MRScreenWidth      CGRectGetWidth([UIScreen mainScreen].applicationFrame)
#define MRScreenHeight     CGRectGetHeight([UIScreen mainScreen].applicationFrame)
#define MaxImgScale 1.1

@interface MRZoomScrollView (Utility)

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center;

@end

@implementation MRZoomScrollView
@synthesize locimageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.delegate = self;
        self.frame = CGRectMake(0, 0, MRScreenWidth, MRScreenHeight);
        indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        indicator.center = self.center;
    }
    return self;
}

- (void)setTheImageView:(NSString *)url
{
    if (bottomView != nil) {
        [bottomView removeFromSuperview];
    }
    
    [self initImageView];
    locimageView.delegate = self;
    locimageView.imageURL = [NSURL URLWithString:url];
    
    float minimumScale = self.frame.size.width / bottomView.frame.size.width;
    [self setMinimumZoomScale:minimumScale];
    [self setZoomScale:minimumScale];
    
}

- (void)initImageView
{
    
    bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width * 2.5, self.frame.size.height * 2.5)];
    [self addSubview:bottomView];
    bottomView.backgroundColor = [UIColor clearColor];
    
    locimageView = [[EGOImageView alloc] init];
    locimageView.frame = CGRectMake(([UIManage getAppWidth] - 100) / 2 * 2.5, ([UIManage getAppHeight] - 84) / 2 * 2.5, 100 * 2.5, 84 * 2.5);
    locimageView.placeholderImage = [UIImage imageNamed:@"placeholder"];
    locimageView.userInteractionEnabled = YES;
    [bottomView addSubview:locimageView];
    
    [self addSubview:indicator];
    [indicator startAnimating];
    
    // Add gesture,double tap zoom imageView.
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(handleDoubleTap:)];
    [doubleTapGesture setNumberOfTapsRequired:2];
    [bottomView addGestureRecognizer:doubleTapGesture];
    [doubleTapGesture release];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [bottomView addGestureRecognizer:singleTap];
    [singleTap setNumberOfTapsRequired:1];
    [singleTap requireGestureRecognizerToFail:doubleTapGesture];
    [singleTap release];
}


#pragma mark - Zoom methods
- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer
{
    if (indicator.isAnimating) {
        return;      
    }
    
    if (self.zoomScale == self.maximumZoomScale) {
        // jump back to minimum scale
        [self updateZoomScaleWithGesture:gestureRecognizer newScale:self.minimumZoomScale];
    }
    else {
        // double tap zooms in
//        CGFloat newScale = MIN(self.zoomScale * 2, self.maximumZoomScale);
        CGFloat newScale = self.maximumZoomScale;
        [self updateZoomScaleWithGesture:gestureRecognizer newScale:newScale];
    }
    
}

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center
{
    CGRect zoomRect;
    zoomRect.size.height = self.frame.size.height / scale;
    zoomRect.size.width  = self.frame.size.width  / scale;
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}


#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return bottomView;
}

//- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
//{
////    NSLog(@"SCALE : %@",@(scale));
////    [scrollView setZoomScale:scale animated:NO];
//}

#pragma mark - helpping method

- (void)updateZoomScale:(CGFloat)newScale withCenter:(CGPoint)center {
    assert(newScale >= self.minimumZoomScale);
    assert(newScale <= self.maximumZoomScale);
    
    if (self.zoomScale != newScale) {
        CGRect zoomRect = [self zoomRectForScale:newScale withCenter:center];
        [self zoomToRect:zoomRect animated:YES];
    }
}

- (void)updateZoomScaleWithGesture:(UIGestureRecognizer *)gestureRecognizer newScale:(CGFloat)newScale {
    CGPoint center = [gestureRecognizer locationInView:gestureRecognizer.view];
    [self updateZoomScale:newScale withCenter:center];
}

- (void)resizeToOriginal
{
    CGRect zoomRect = [self zoomRectForScale:self.minimumZoomScale withCenter:CGPointMake(MRScreenWidth / 2, MRScreenHeight / 2)];
    [self zoomToRect:zoomRect animated:NO];
}

- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer
{
    if ([_mrDelegate respondsToSelector:@selector(MRZoomScrollViewSingleTouch:)]) {
        [_mrDelegate MRZoomScrollViewSingleTouch:self];
    }
}

#pragma mark - EGOImageView delegate
- (void)imageViewLoadedImage:(EGOImageView *)imageView
{
    [indicator stopAnimating];
    indicator.hidden = YES;
    
    CGSize imageSize = [UIManage createImgSize:imageView.image];
    CGRect oldFrame = CGRectMake(([UIManage getAppWidth] - imageSize.width) / 2 * 2.5, ([UIManage getAppHeight] - [UIManage createImgSize:imageView.image].height) / 2 * 2.5, imageSize.width * 2.5, imageSize.height * 2.5);
    imageView.frame = oldFrame;
}

#pragma mark - View cycle
- (void)dealloc
{
    [locimageView release];
    [bottomView release];
    [indicator release];
    [super dealloc];
}

@end
