//
//  LMPhotoClassViewController.m
//  LMGallery
//
//  Created by itenyh on 13-10-30.
//  Copyright (c) 2013年 lmodel. All rights reserved.
//

#import "LMPhotoClassViewController.h"
#import "BKUpdateTableView.h"
#import "LMGalleryViewController.m"

@interface LMPhotoClassViewController () <BKUpdateTableViewDelegate, BKUpdateTableViewProcessingDelegate, UITableViewDataSource>
{
    BKUpdateTableView *updateTable;
}
@end

@implementation LMPhotoClassViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        updateTable = [[BKUpdateTableView alloc] init];
        updateTable.frame = CGRectMake(0, 43, [UIManage getAppWidth], [UIManage getAppHeight] - 43);
        updateTable.dataSource = self;
        updateTable.pullUpdateDelegate = self;
        updateTable.processingDelegate = self;
        updateTable.userInteractionEnabled = YES;
        updateTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        updateTable.backgroundColor = [UIColor clearColor];
        updateTable.showsVerticalScrollIndicator = YES;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self setNavTitle:@"LModels" LeftBarBtnType:BKNavBtnNone AndLeftTitle:@"" RightBarBtnType:BKNavBtnNone AndRightTitle:@""];
    
}

#pragma mark -
#pragma mark updateTableViewDataSource
- (CGFloat)BKUpdateTableView:(BKUpdateTableView *)updateTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	NSString *contentCellIdentifier = @"";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:contentCellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:contentCellIdentifier];
    }
    
    cell.textLabel.text = @"Test";
    
    return cell;
}

#pragma mark -
#pragma mark updateProcessingDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 5;
}

- (void)BKUpdateTableViewDidSelectRowAtIndexPath:(BKUpdateTableView *)updateTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    LMGalleryViewController *gallery = [[LMGalleryViewController alloc] init];
//    
//    LMAppDelegate *appDele = [UIApplication sharedApplication].delegate;
//    
//    [appDele.rootNavi pushViewController:gallery animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
