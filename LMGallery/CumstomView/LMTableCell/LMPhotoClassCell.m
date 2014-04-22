//
//  LMPhotoClassCell.m
//  LMGallery
//
//  Created by Apple on 13-11-11.
//  Copyright (c) 2013年 lmodel. All rights reserved.
//

#import "LMPhotoClassCell.h"
#define CellHeight 160

@implementation LMPhotoClassCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.contentView.backgroundColor = [UIColor blackColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        int Vmargin = 1;
        int Hmargin = 0;
        
        imageView = [[EGOImageView alloc] init];
        imageView.frame = CGRectMake(Hmargin, Vmargin, [UIManage getAppWidth] - 2 * Hmargin, CellHeight - Vmargin);
        [self.contentView addSubview:imageView];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)displayWith:(NSString *)pic
{
    [imageView setImageURL:[NSURL URLWithString:pic]];
}

+ (float)getCellHeight
{
    return CellHeight;
}

@end
