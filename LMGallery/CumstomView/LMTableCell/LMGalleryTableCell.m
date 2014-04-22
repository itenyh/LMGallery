//
//  LMGalleryTableCell.m
//  LMGallery
//
//  Created by Apple on 14-1-16.
//  Copyright (c) 2014年 lmodel. All rights reserved.
//

#define baseTag 238

#import "LMGalleryTableCell.h"

@implementation LMGalleryTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        int internal = 1;
        float width = ([UIManage getAppWidth] - 4 * internal) / 3.0;
        float height = 165.0 / 126.0 * width;
        
        for (int i = 0; i < 3; i++) {
            
            LMGalleryModelView *imageView = [[LMGalleryModelView alloc] initWithFrame:CGRectMake((i + 1) * internal + i * width, 0, width, height)];
            imageView.tag = i + baseTag;
            imageView.headImgView.tag = i + baseTag;
            [imageView.headImgView addTarget:self action:@selector(imgClick:) forControlEvents:UIControlEventTouchUpInside];
            imageView.hidden = YES;
            [self.contentView addSubview:imageView];
            
        }
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)displayWith:(NSArray *)array
{
    for (int i = 0; i < array.count; i++) {
        LMModelBo *bo = [array objectAtIndex:i];
        LMGalleryModelView *view = (LMGalleryModelView *)[self.contentView viewWithTag:i + baseTag];
        view.hidden = NO;
        [view setUrlAndName:bo.headImgUrl name:bo.name];
        if (!bo.isAvaliable) {
            [view setUnhilight];
        }
    }
    
    
}

- (void)imgClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if ([_delegate respondsToSelector:@selector(lMGalleryTableCellPicClicked:picIndex:)]) {
        [_delegate lMGalleryTableCellPicClicked:self picIndex:btn.tag - baseTag];
    }
}

+ (float)getCellHeight
{
    return 165.0 / 126.0 * ([UIManage getAppWidth] - 4 * 1) / 3.0;
}

@end
