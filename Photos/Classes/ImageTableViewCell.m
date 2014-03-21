//
//  ImageTableViewCell.m
//  Photos
//
//  Created by tag_mac_05 on 14-3-19.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//

#import "ImageTableViewCell.h"

@implementation ImageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(8, 4, 70, 74);

//    NSLog(@"%@",self.detailTextLabel);
}

-(void)loadData:(ALAssetsGroup*)group
{
    if (!groupName) {
        groupName = [[UILabel alloc] initWithFrame:CGRectZero];
        groupName.frame = CGRectMake(190/2, 45/2, 200, 20);
        groupName.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:groupName];
    }
    if (!subTitle) {
        subTitle = [[UILabel alloc] initWithFrame:CGRectZero];
        subTitle.frame = CGRectMake(190/2, 96/2, 200, 15);
        subTitle.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:subTitle];
    }
    self.imageView.image = [UIImage imageWithCGImage:group.posterImage];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    NSInteger type = [[group valueForProperty:ALAssetsGroupPropertyType] integerValue];
    switch (type) {
        case ALAssetsGroupPhotoStream:
        {
            groupName.text = @"我的照片流";
        }
            break;
        case ALAssetsGroupSavedPhotos:
        {
            groupName.text = @"胶卷相机";
        }break;
            
        default:
        {
            groupName.text = [group valueForProperty:ALAssetsGroupPropertyName];
        }
            break;
    }
    NSInteger number = [group numberOfAssets];
    
    subTitle.text = [NSString stringWithFormat:@"%d",(int)number];
}
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
