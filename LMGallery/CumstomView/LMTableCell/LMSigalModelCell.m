//
//  LMSigalModelCell.m
//  LMGallery
//
//  Created by Apple on 14-1-7.
//  Copyright (c) 2014年 lmodel. All rights reserved.
//

#define cellHeight 100

#import "LMSigalModelCell.h"
#import "LMBasicDBOperator.h"

@implementation LMSigalModelCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        headImgView = [[EGOImageView alloc] initWithFrame:CGRectMake(10, 10 / 2, 126.0 / 165.0 * (cellHeight - 10), cellHeight - 10)];
        [self.contentView addSubview:headImgView];
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIManage xFromLeftView:headImgView] + 20, 5, 0, [UIFont boldSystemFontOfSize:18].lineHeight)];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.textAlignment = UITextAlignmentLeft;
        nameLabel.font = [UIFont boldSystemFontOfSize:18];
        [self.contentView addSubview:nameLabel];
        
        lable1 = [[UILabel alloc] initWithFrame:CGRectMake([UIManage xFromLeftView:headImgView] + 20, [UIManage yFromTopView:nameLabel] + 5, 0, [UIFont systemFontOfSize:14].lineHeight)];
        lable1.backgroundColor = [UIColor clearColor];
        lable1.textColor = [UIColor whiteColor];
        lable1.textAlignment = UITextAlignmentLeft;
        lable1.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:lable1];
        
        lable2 = [[UILabel alloc] initWithFrame:CGRectMake([UIManage xFromLeftView:headImgView] + 20, [UIManage yFromTopView:lable1] + 5, 0, [UIFont systemFontOfSize:15].lineHeight)];
        lable2.backgroundColor = [UIColor clearColor];
        lable2.textColor = [UIColor whiteColor];
        lable2.textAlignment = UITextAlignmentLeft;
        lable2.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:lable2];
        
        lable3 = [[UILabel alloc] initWithFrame:CGRectMake([UIManage xFromLeftView:headImgView] + 20, [UIManage yFromTopView:lable2] + 5, 0, [UIFont systemFontOfSize:15].lineHeight)];
        lable3.backgroundColor = [UIColor clearColor];
        lable3.textColor = [UIColor whiteColor];
        lable3.textAlignment = UITextAlignmentLeft;
        lable3.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:lable3];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(-80, cellHeight - 1, [UIManage getAppWidth] + 190, 0.5)];
        lineView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:lineView];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)displayWith:(LMModelBo *)bo
{
    headImgView.imageURL = [NSURL URLWithString:bo.headImgUrl];
    
    [self createCatStrByMid:[bo getStrMid]];
    
    nameLabel.text = bo.name;
    CGSize sizeOfNameData = [UIManage text:nameLabel.text sizeWithFont:nameLabel.font constrainedToSize:CGSizeMake(INT16_MAX, nameLabel.font.lineHeight)];
    nameLabel.frame = CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.origin.y, sizeOfNameData.width, nameLabel.frame.size.height);
    
    lable2.text = [NSString stringWithFormat:@"%d %d/%d/%d %d", (int)bo.height, (int)bo.bust, (int)bo.waist, (int)bo.hips, (int)bo.dressSize];
    CGSize sizeOfIntData = [UIManage text:lable2.text sizeWithFont:lable2.font constrainedToSize:CGSizeMake(INT_MAX, lable2.font.lineHeight)];
    lable2.frame = CGRectMake(lable2.frame.origin.x, lable2.frame.origin.y, sizeOfIntData.width, lable2.frame.size.height);
    
    lable3.text = [NSString stringWithFormat:@"眼睛 %@ 头发 %@", bo.eyesColor, bo.hairColor];
    CGSize sizeOfData = [UIManage text:lable3.text sizeWithFont:lable3.font constrainedToSize:CGSizeMake(INT_MAX, lable3.font.lineHeight)];
    lable3.frame = CGRectMake(lable3.frame.origin.x, lable3.frame.origin.y, sizeOfData.width, lable3.frame.size.height);

}

+ (float)getCellHeight
{
    return cellHeight;
}

- (void)createCatStrByMid:(NSString *)mid
{
    NSMutableString *result = [NSMutableString string];
    
    [LMBasicDBOperator getAllCatsWithMId:mid callback:^(NSMutableArray *array) {
        
        BOOL firstIndex = YES;
        for (LMCategoryBo *bo in array) {
            if (firstIndex) {
                [result appendString:@"类别: "];
                [result appendString:bo.name];
                firstIndex = NO;
            }
            
            else {
                [result appendString:@" "];
                [result appendString:bo.name];
            }
            
        }
        
        lable1.text = result;
        CGSize sizeOfCat = [UIManage text:lable1.text sizeWithFont:lable1.font constrainedToSize:CGSizeMake(INT16_MAX, lable1.font.lineHeight)];
        lable1.frame = CGRectMake(lable1.frame.origin.x, lable1.frame.origin.y, sizeOfCat.width, lable1.frame.size.height);
        
    }];
    
    
}

@end
