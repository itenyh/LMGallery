//
//  LMGalleryViewController.h
//  LMGallery
//
//  Created by itenyh on 13-10-14.
//  Copyright (c) 2013年 lmodel. All rights reserved.
//

#import "BKBaseViewController.h"

@interface LMGalleryViewController : BKBaseViewController <UICollectionViewDataSource, UICollectionViewDelegate>
{
    UICollectionView *collectionView;
}
@end
