//
//  LMGalleryTableCell.h
//  LMGallery
//
//  Created by Apple on 14-1-16.
//  Copyright (c) 2014年 lmodel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMGalleryModelView.h"
#import "LMModelBo.h"

@class LMGalleryTableCell;
@protocol LMGalleryTableCellDelegate <NSObject>

- (void)lMGalleryTableCellPicClicked:(LMGalleryTableCell *)cell picIndex:(int)index;

@end

@interface LMGalleryTableCell : UITableViewCell

@property (nonatomic, weak) id<LMGalleryTableCellDelegate> delegate;

- (void)displayWith:(NSArray *)array;
+ (float)getCellHeight;

@end
