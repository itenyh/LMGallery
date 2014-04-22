//
//  LMColofulClassCell.h
//  LMGallery
//
//  Created by Apple on 13-11-17.
//  Copyright (c) 2013年 lmodel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMCategoryBo.h"

@interface LMColofulClassCell : UITableViewCell
{
    UILabel *chCatLabel;
    UILabel *enCatLaebl;
    
    UIView *bottomView;
}

- (void)displayWith:(LMCategoryBo *)bo;
+ (float)getCellHeight;

@end
