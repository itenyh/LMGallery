//
//  LMSettingCell.m
//  LMGallery
//
//  Created by Apple on 14-1-8.
//  Copyright (c) 2014年 lmodel. All rights reserved.
//

#define cellHeight 80

#import "LMSettingCell.h"

@implementation LMSettingCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, cellHeight - 1, [UIManage getAppWidth], 0.5)];
        lineView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:lineView];
        
        self.textLabel.textColor = [UIColor whiteColor];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (float)getCellHeight
{
    return cellHeight;
}

@end
