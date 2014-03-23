//
//  SWTTransitionController.m
//  Photos
//
//  Created by song on 14-3-22.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//

#import "SWTTransitionController.h"
#import "SWTTransitionLayout.h"
#import "ToolKit.h"
@interface SWTTransitionController()


@end

@implementation SWTTransitionController

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 2;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    
    CGFloat screenHeight = [ToolKit screenHeight];
    UIViewController *fromController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *from = [fromController view];
    UIView *to = [toController view];
    UIView *container = [transitionContext containerView];
    
    to.frame = container.bounds;
    from.frame = container.bounds;
    if (self.isPushing) {
        
        to.frame = CGRectMake(320, 0, 320, screenHeight);
    }else
    {
        
    }
    
    [UIView animateKeyframesWithDuration:2 delay:0 options:0 animations:^{
        if (self.isPushing) {
            to.frame = CGRectMake(0, 0, 320, screenHeight);
        }
    } completion:^(BOOL finished) {
            [transitionContext completeTransition:finished];
    }];
    
}

#pragma mark - UIViewControllerContextTransitioning


@end
