//
//  LMColofulClassCell.m
//  LMGallery
//
//  Created by Apple on 13-11-17.
//  Copyright (c) 2013年 lmodel. All rights reserved.
//

#import "LMColofulClassCell.h"

#define chCatLabelFontSize 20
#define cellMargin 20
#define colorBgHeight 90
#define lrMargin 20

@implementation LMColofulClassCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor blackColor];
        
        bottomView = [[UIView alloc] initWithFrame:CGRectMake(lrMargin, cellMargin, [UIManage getAppWidth] - 2 * lrMargin, colorBgHeight)];
        [self.contentView addSubview:bottomView];
        
        chCatLabel = [[UILabel alloc] init];
        chCatLabel.font = [UIFont boldSystemFontOfSize:chCatLabelFontSize];
        chCatLabel.textColor = [UIColor whiteColor];
        chCatLabel.backgroundColor = [UIColor clearColor];
        [bottomView addSubview:chCatLabel];
        
        enCatLaebl = [[UILabel alloc] init];
        enCatLaebl.font = [UIFont systemFontOfSize:13];
        enCatLaebl.textColor = [UIColor whiteColor];
        enCatLaebl.backgroundColor = [UIColor clearColor];
        [bottomView addSubview:enCatLaebl];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)displayWith:(LMCategoryBo *)bo
{
    if (bo.color == nil || bo.color.length == 0) {
        bottomView.backgroundColor = [UIColor grayColor];
    }
    else {
        bottomView.backgroundColor = [UIManage color:bo.color];
    }
    
    chCatLabel.text = bo.name;
    chCatLabel.frame =CGRectMake(50 + 15, 9, 100, 30);
    
    enCatLaebl.text = bo.enName;
    enCatLaebl.frame =CGRectMake(52 + 15, chCatLabel.frame.size.height + chCatLabel.frame.origin.y - 8, 100, 30);
}

+ (float)getCellHeight
{
    return colorBgHeight + cellMargin;
}

@end
