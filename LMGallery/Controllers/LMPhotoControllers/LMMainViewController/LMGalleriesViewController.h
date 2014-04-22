//
//  LMGalleryViewController.h
//  LMGallery
//
//  Created by itenyh on 13-10-14.
//  Copyright (c) 2013年 lmodel. All rights reserved.
//

#import "LMBasicViewController.h"
#import "LMCategoryBo.h"
#import "LMGalleryTableViewController.h"

@interface LMGalleriesViewController : LMBasicViewController
{
    LMGalleryTableViewController *tableCon;
}

@property (nonatomic, strong) LMCategoryBo *curCatBo;

@end
