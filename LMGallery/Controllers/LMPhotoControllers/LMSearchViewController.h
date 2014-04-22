//
//  LMSearchViewController.h
//  LMGallery
//
//  Created by Apple on 14-1-7.
//  Copyright (c) 2014年 lmodel. All rights reserved.
//

#import "LMBasicViewController.h"
#import "LMModelListViewController.h"

@interface LMSearchViewController : LMBasicViewController
{
    UITapGestureRecognizer *tapGesture;
    UISearchBar *localSearchBar;
    
    LMModelListViewController *listViewController;
}
@end
