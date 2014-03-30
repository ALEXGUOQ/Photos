//
//  SWTTransitionLayout.m
//  Photos
//
//  Created by song on 14-3-22.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//

#import "SWTTransitionLayout.h"

@implementation SWTTransitionLayout
- (void)setTransitionProgress:(CGFloat)transitionProgress
{
    [super setTransitionProgress:transitionProgress];
    NSLog(@"progress:%f",transitionProgress);
    CGFloat offsetH = [self valueForAnimatedKey:@"offsetH"];
    CGFloat offsetV = [self valueForAnimatedKey:@"offsetV"];
    _offset = UIOffsetMake(offsetH, offsetV);
}


-(void)setOffset:(UIOffset)offset
{
    NSLog(@"%f,%f",offset.horizontal,offset.vertical);
    [self updateValue:offset.horizontal forAnimatedKey:@"offsetH"];
    [self updateValue:offset.vertical   forAnimatedKey:@"offsetV"];
    _offset = offset;
}



@end
