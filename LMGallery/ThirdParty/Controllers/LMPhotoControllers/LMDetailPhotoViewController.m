//
//  LMDetailPhotoViewController.m
//  LMGallery
//
//  Created by itenyh on 13-10-30.
//  Copyright (c) 2013年 lmodel. All rights reserved.
//

#import "LMDetailPhotoViewController.h"
#import "SwipeView.h"

@interface LMDetailPhotoViewController () <SwipeViewDelegate, SwipeViewDataSource>
{
    SwipeView *_swipeView;
    NSArray *photo_arr;
}
@end

@implementation LMDetailPhotoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _swipeView = [[SwipeView alloc] init];
    _swipeView.alignment = SwipeViewAlignmentCenter;
    _swipeView.pagingEnabled = YES;
    _swipeView.wrapEnabled = NO;
    _swipeView.itemsPerPage = 1;
    _swipeView.truncateFinalPage = YES;
    
    
    photo_arr = [NSArray arrayWithObjects:@"0_full.JPG",@"1_full.JPG",@"2_full.JPG",@"3_full.JPG",@"4_full.JPG",@"5_full.JPG", nil];
}

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return 6;
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    
    //create or reuse view
    if (view == nil)
    {
        view = [[UIView alloc] initWithFrame:self.view.frame];
        [view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[photo_arr objectAtIndex:index]]]];
    }
   
    return view;
}

- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView
{
    //update page control page
}

- (void)swipeView:(SwipeView *)swipeView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"Selected item at index %d", index);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
