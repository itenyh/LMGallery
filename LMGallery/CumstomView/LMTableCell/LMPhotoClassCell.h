//
//  LMPhotoClassCell.h
//  LMGallery
//
//  Created by Apple on 13-11-11.
//  Copyright (c) 2013年 lmodel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface LMPhotoClassCell : UITableViewCell
{
    EGOImageView *imageView;
}

- (void)displayWith:(NSString *)pic;
+ (float)getCellHeight;

@end
