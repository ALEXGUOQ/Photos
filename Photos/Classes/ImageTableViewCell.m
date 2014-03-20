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
        subTitle = [[UILabel alloc] initWithFrame:CGRectZero];
        subTitle.frame = CGRectMake(190/2, 96/2, 200, 15);
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(8, 4, 70, 74);
    NSLog(@"%@",self.detailTextLabel);
}

-(void)loadData
{
    
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
