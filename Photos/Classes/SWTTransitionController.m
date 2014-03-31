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
#import "FullScreenCollectionVC.h"
#import "GroupDetailVC.h"

@interface SWTTransitionController()


@end

@implementation SWTTransitionController
#define kanimateTime 1
#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return kanimateTime;
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
    
    BOOL isPushing = NO;
    if ([toController isKindOfClass:[FullScreenCollectionVC class]]) {
        isPushing = YES;
    }
    [container addSubview:to];
    if (isPushing) {
        
        to.frame = ((GroupDetailVC*)fromController).pressRect;
        
        
        [UIView animateWithDuration:kanimateTime delay:0 usingSpringWithDamping:15 initialSpringVelocity:0.7 options:UIViewAnimationOptionLayoutSubviews animations:^{
            to.frame = CGRectMake(0, 0, 320, screenHeight);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:finished];
        }];
        [transitionContext completeTransition:YES];
        
    }else
    {
        from.frame = CGRectMake(0, 0, 320, screenHeight);
        to.frame = CGRectMake(0, 0, 320, screenHeight);
        [container addSubview:to];

        [UIView animateKeyframesWithDuration:kanimateTime delay:0 options:0 animations:^{
            
                from.frame = self.animationRect;
            
        } completion:^(BOOL finished) {
            if (finished) {

            [transitionContext completeTransition:finished];
            }else
            {
            [transitionContext completeTransition:finished];
            }
        }];
    }
}

@end
