//
//  LMDetailPhotoViewController.m
//  LMGallery
//
//  Created by itenyh on 13-10-30.
//  Copyright (c) 2013年 lmodel. All rights reserved.
//

#import "LMDetailPhotoViewController.h"
#import "MRZoomScrollView.h"
#import "LMBasicDBOperator.h"
#import "EGOImageView.h"
#import "SLCoverFlowView.h"
#import "SLCoverView.h"
#import "BKUserDefautTool.h"

@interface LMDetailPhotoViewController () <MRZoomScrollViewDelegate, LMModelInfoViewDelegate, SLCoverFlowViewDataSource>
{
    NSMutableArray *photo_arr;
    BOOL isInfoShowed;
    SLCoverFlowView *_coverFlowView;
}
@end

@implementation LMDetailPhotoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        isInfoShowed = YES;
        photo_arr = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _coverFlowView = [[SLCoverFlowView alloc] initWithFrame:self.view.bounds];
    _coverFlowView.backgroundColor = [UIColor clearColor];
    _coverFlowView.delegate = self;
    _coverFlowView.coverSize = CGSizeMake([UIManage getAppWidth], [UIManage getAppHeight] + 60);
    _coverFlowView.coverSpace = 10.0;
    _coverFlowView.coverAngle = 0.0;
    _coverFlowView.coverScale = 1.0;
    [self.view addSubview:_coverFlowView];
    
    infoView = [[LMModelInfoView alloc] initWithParameter:[BKUserDefautTool isToShownPanel] isSaved:[LMBasicDBOperator getSavedStateWithMid:[_curModelBo getStrMid]]];
    infoView.delegate = self;
    [infoView displayWith:_curModelBo];
    [self.view addSubview:infoView];
    
    [LMBasicDBOperator getAllLargePicsWithMId:[_curModelBo getStrMid] callback:^(NSMutableArray *array) {
       
        photo_arr = array;
        [_coverFlowView reloadData];
        
    }];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if([BKBaseFunctions getIosVer] >= 7.0) self.edgesForExtendedLayout = UIRectEdgeTop;
    [self enterFullscreen];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self exitFullscreen];
    
}

#pragma mark - SLCoverFlowViewDataSource
- (NSInteger)numberOfCovers:(SLCoverFlowView *)coverFlowView {

    return photo_arr.count;
}

- (SLCoverView *)coverFlowView:(SLCoverFlowView *)coverFlowView coverViewAtIndex:(NSInteger)index {
    
    SLCoverView *view = [[SLCoverView alloc] initWithFrame:CGRectMake(0.0, 0.0, [UIManage getAppWidth], 100.0)];
    MRZoomScrollView *zview = [[MRZoomScrollView alloc] init];
    zview.frame = CGRectMake(0, 20, [UIManage getAppWidth], [UIManage getAppHeight] + 20);
    LMLargePhotoBo *bo = [photo_arr objectAtIndex:index];
    MRZoomScrollView *zoomView = (MRZoomScrollView *)zview;
    zoomView.mrDelegate = self;
    [zoomView resizeToOriginal];
    [zoomView setTheImageView:bo.pUrl];

    [view addSubview:zoomView];
    
    return view;
}

#pragma mark -
#pragma mark MRZoomScrollViewDelegate
- (void)MRZoomScrollViewSingleTouch:(MRZoomScrollView *)scrollView
{
    if (isInfoShowed) {
        isInfoShowed = NO;
        [UIView animateWithDuration:0.3 animations:^{
            infoView.alpha = 0;
        }];
        
    } else {
        isInfoShowed = YES;
        [UIView animateWithDuration:0.3 animations:^{
            infoView.alpha = 1;
        }];
    }
}

#pragma mark -
#pragma mark LMModelInfoViewDelegate
- (void)lMModelInfoViewClickBack:(LMModelInfoView *)lmInfoView
{
    [self clickLeftBtnEvent:nil];
}

- (void)lMModelInfoViewClickSaveBtn:(LMModelInfoView *)lmInfoView
{
    if (lmInfoView.saveBtn.tag == 1) {
        [LMBasicDBOperator updateSavedState:YES mid:[_curModelBo getStrMid]];
        [self showInfoMessage:@"已收藏"];
    }
    
    else {
        [LMBasicDBOperator updateSavedState:NO mid:[_curModelBo getStrMid]];
        [self showInfoMessage:@"已取消"];
    }
}

- (void)lMModelInfoViewClickUserBtn:(LMModelInfoView *)lmInfoView
{
    [BKUserDefautTool setToShowPanel:lmInfoView.isShown];
}

#pragma mark -OtherMethod
#pragma mark ScreenControll
- (void)enterFullscreen
{
	UIApplication* application = [UIApplication sharedApplication];
	if ([application respondsToSelector: @selector(setStatusBarHidden:withAnimation:)]) {
		[[UIApplication sharedApplication] setStatusBarHidden: YES withAnimation: UIStatusBarAnimationFade]; // 3.2+
	} else {
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
		[[UIApplication sharedApplication] setStatusBarHidden: YES animated:YES]; // 2.0 - 3.2
#pragma GCC diagnostic warning "-Wdeprecated-declarations"
	}
    
    self.BKNavigationBar.hidden = YES;
	
}

- (void)exitFullscreen
{
	UIApplication* application = [UIApplication sharedApplication];
	if ([application respondsToSelector: @selector(setStatusBarHidden:withAnimation:)]) {
		[[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade]; // 3.2+
	} else {
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
		[[UIApplication sharedApplication] setStatusBarHidden:NO animated:NO]; // 2.0 - 3.2
#pragma GCC diagnostic warning "-Wdeprecated-declarations"
	}
    
}

- (void)enableApp
{
	[[UIApplication sharedApplication] endIgnoringInteractionEvents];
}


- (void)disableApp
{
	[[UIApplication sharedApplication] beginIgnoringInteractionEvents];
}

@end
