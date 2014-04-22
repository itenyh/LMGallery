//
//  LMGalleryCell.m
//  LMGallery
//
//  Created by Apple on 13-11-10.
//  Copyright (c) 2013年 lmodel. All rights reserved.
//

#import "LMGalleryCell.h"

@implementation LMGalleryCell

- (id)initWithFrame:(CGRect)frame
{
    
    if ((self = [super initWithFrame:frame])) {
        imageView = [[EGOImageView alloc] init];
        [self.backgroundView addSubview:imageView];
    }
    
    return self;
}

- (void)displayWith:(LMModelBo *)bo
{
    imageView.imageURL = [NSURL URLWithString:bo.headImgUrl];
    self.textLabel.text = bo.name;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
 
    imageView.frame = CGRectMake(0, 0, backgroundView.frame.size.width, backgroundView.frame.size.height);
}

@end
