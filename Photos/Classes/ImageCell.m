//
//  ImageCell.m
//  Photos
//
//  Created by song on 14-3-17.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//

#import "ImageCell.h"

@implementation ImageCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        imageView = [[UIImageView alloc] initWithFrame:frame];
        
        [self.contentView addSubview:imageView];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    imageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}
-(void)loadWithALAsset:(ALAsset*)asset
{
//    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
    UIImage *image = [UIImage imageWithCGImage:[asset thumbnail]];
    if (image) {
        imageView.image = image;
    }else
    {
//        NSLog(@"no image");
    }
    
//    }];
//    [[NSOperationQueue mainQueue] addOperation:operation];
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
