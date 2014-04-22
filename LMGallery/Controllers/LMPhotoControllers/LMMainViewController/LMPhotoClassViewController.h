//
//  LMPhotoClassViewController.h
//  LMGallery
//
//  Created by itenyh on 13-10-30.
//  Copyright (c) 2013年 lmodel. All rights reserved.
//

#import "LMBasicViewController.h"

@interface LMPhotoClassTableViewController : UITableViewController
{

}

@property (nonatomic, strong) NSMutableArray *modelTypes;

@end

@interface LMPhotoClassViewController : LMBasicViewController
{
    LMPhotoClassTableViewController *tableViewController;
}
@end
