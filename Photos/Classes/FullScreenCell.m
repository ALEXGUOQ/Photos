//
//  FullScreenCell.m
//  Photos
//
//  Created by song on 14-3-23.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//

#import "FullScreenCell.h"

@implementation FullScreenCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)loadWithALAsset:(ALAsset*)asset
{
    //    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{

    NSURL *url = [asset valueForProperty:ALAssetPropertyAssetURL];
    imageView.image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:url]];

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
