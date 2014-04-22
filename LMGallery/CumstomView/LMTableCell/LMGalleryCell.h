//
//  LMGalleryCell.h
//  LMGallery
//
//  Created by Apple on 13-11-10.
//  Copyright (c) 2013年 lmodel. All rights reserved.
//

#import "EGOImageView.h"
#import "MMGridViewDefaultCell.h"
#import "LMModelBo.h"

@interface LMGalleryCell : MMGridViewDefaultCell
{
    EGOImageView *imageView;
}

- (void)displayWith:(LMModelBo *)bo;

@end
