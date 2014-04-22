//
//  LMSearchViewController.m
//  LMGallery
//
//  Created by Apple on 14-1-7.
//  Copyright (c) 2014年 lmodel. All rights reserved.
//

#import "LMSearchViewController.h"
#import "LMBasicDBOperator.h"
#import "LMSigalModelCell.h"
#import "LMDetailPhotoViewController.h"

@interface LMSearchViewController () <UISearchBarDelegate>

@end

@implementation LMSearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self setNavTitle:@"Search" LeftBarBtnType:BKNavBtnNone AndLeftTitle:@"" RightBarBtnType:BKNavBtnNone AndRightTitle:@""];
    [self setRightBtnImage:[UIImage imageNamed:@"btn_colse"]];
    
    localSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, [UIManage getAppWidth], 50)];
    localSearchBar.barStyle = UIBarStyleBlackOpaque;
    localSearchBar.delegate = self;
    [localSearchBar sizeToFit];
    [localSearchBar becomeFirstResponder];
    localSearchBar.placeholder = @"输入模特儿姓名";
    [self addSubViewInContentView:localSearchBar];
    
    listViewController = [[LMModelListViewController alloc] initWithStyle:UITableViewStylePlain];
    listViewController.view.frame = CGRectMake(0, localSearchBar.frame.size.height, [UIManage getAppWidth], [UIManage getAppHeight] - LMNavHeight - localSearchBar.frame.size.height);
    [self addChildViewController:listViewController];
    [self addSubViewInContentView:listViewController.view];
    
}

#pragma - Search Delegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *searchStr = searchBar.text;
    
    NSMutableArray *searchArr = [LMBasicDBOperator searchAllModelWtihName:searchStr];
    
    if (searchArr.count != 0) {
        listViewController.searchResultArr = searchArr;
        [listViewController.tableView reloadData];
    }
    
    else {
        [self showErrorMessage:@"没有结果"];
    }
    
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    if (tapGesture == nil) {
        tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignKeyBoard)];
        [self.contentView addGestureRecognizer:tapGesture];
    }
    
    return YES;
}

#pragma - other functions
- (void)clickRightBtnEvent:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)resignKeyBoard
{
    if (tapGesture != nil) {
        [localSearchBar resignFirstResponder];
        [self.contentView removeGestureRecognizer:tapGesture];
        tapGesture = nil;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
