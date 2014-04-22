//
//  LMGalleryModelView.m
//  LMGallery
//
//  Created by Apple on 14-1-16.
//  Copyright (c) 2014年 lmodel. All rights reserved.
//

#import "LMGalleryModelView.h"

@implementation LMGalleryModelView
@synthesize headImgView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];
        
        headImgView = [[EGOImageButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:headImgView];
        
        int fontSize = 15;
        float heightLabel = [UIFont systemFontOfSize:fontSize].lineHeight + 5;
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height - heightLabel, frame.size.width, heightLabel)];
        nameLabel.backgroundColor = [UIColor blackColor];
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.font = [UIFont systemFontOfSize:fontSize];
        nameLabel.textAlignment = UITextAlignmentCenter;
        nameLabel.alpha = 0.8;
        [self addSubview:nameLabel];
        
        
    }
    return self;
}

- (void)setUrlAndName:(NSString *)url name:(NSString *)name
{
    headImgView.imageURL = [NSURL URLWithString:url];
    
    nameLabel.text = name;
}

- (void)setUnhilight
{
    nameLabel.textColor = [UIColor grayColor];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
