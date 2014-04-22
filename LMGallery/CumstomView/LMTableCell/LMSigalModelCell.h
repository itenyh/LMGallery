//
//  LMSigalModelCell.h
//  LMGallery
//
//  Created by Apple on 14-1-7.
//  Copyright (c) 2014年 lmodel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMModelBo.h"
#import "EGOImageView.h"

@interface LMSigalModelCell : UITableViewCell
{
    EGOImageView *headImgView;
    UILabel *nameLabel;
    UILabel *lable1;
    UILabel *lable2;
    UILabel *lable3;
}

- (void)displayWith:(LMModelBo *)bo;
+ (float)getCellHeight;

@end
