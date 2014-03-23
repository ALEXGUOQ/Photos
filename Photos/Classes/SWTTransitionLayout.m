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


- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    for (UICollectionViewLayoutAttributes *currentAttribute in attributes)
    {
        CGPoint currentCenter = currentAttribute.center;
        CGPoint updatedCenter = CGPointMake(currentCenter.x + self.offset.horizontal, currentCenter.y + self.offset.vertical);
        currentAttribute.center = updatedCenter;
    }
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    CGPoint currentCenter = attributes.center;
    CGPoint updatedCenter = CGPointMake(currentCenter.x + self.offset.horizontal, currentCenter.y + self.offset.vertical);
    attributes.center = updatedCenter;
    return attributes;
}
@end
