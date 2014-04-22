//
//  LMGalleryModelView.h
//  LMGallery
//
//  Created by Apple on 14-1-16.
//  Copyright (c) 2014年 lmodel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageButton.h"

@interface LMGalleryModelView : UIView
{
    UILabel *nameLabel;
}

@property (nonatomic, strong) EGOImageButton *headImgView;

- (void)setUrlAndName:(NSString *)url name:(NSString *)name;
- (void)setUnhilight;

@end
