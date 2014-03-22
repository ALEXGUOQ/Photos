//
//  SWTTransitionController.m
//  Photos
//
//  Created by song on 14-3-22.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//

#import "SWTTransitionController.h"
#import "SWTTransitionLayout.h"
@interface SWTTransitionController()
@property (nonatomic) SWTTransitionLayout* transitionLayout;
@property (nonatomic) id <UIViewControllerContextTransitioning> context;
@property (nonatomic) CGFloat initialPinchDistance;
@property (nonatomic) CGPoint initialPinchPoint;

@end

@implementation SWTTransitionController
-(instancetype)initWithCollectionView:(UICollectionView*)collectionView
{
    self = [super init];
    if (self) {
        UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(reciveGestureRecognizer:)];
        [collectionView addGestureRecognizer:rotationGesture];
        
        UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
        [collectionView addGestureRecognizer:pinchGesture];
        self.collectionView = collectionView;
    }
    return self;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
}

-(void)reciveGestureRecognizer:(UIGestureRecognizer*)recognizer
{
    
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0;
}

- (void)startInteractiveTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    self.context = transitionContext;
    UICollectionViewController* fromCollectionViewController = (UICollectionViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UICollectionViewController* toCollectionViewController   = (UICollectionViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    self.transitionLayout = (SWTTransitionLayout*)[fromCollectionViewController.collectionView startInteractiveTransitionToCollectionViewLayout:toCollectionViewController.collectionViewLayout completion:^(BOOL didFinish, BOOL didComplete) {
        [_context completeTransition:didComplete];
        
        if (didComplete)
            self.collectionView.delegate = toCollectionViewController;
        else
            self.collectionView.delegate = fromCollectionViewController;
        self.transitionLayout = nil;
        self.context = nil;
        self.hasActiveInteraction = FALSE;
    }];
}


-(void)updateWithProgress:(CGFloat)progress andOffset:(UIOffset)offset
{
    if (_context==nil)
    {
        return;
    }
    
    if ((progress != self.transitionLayout.transitionProgress) || !UIOffsetEqualToOffset(offset, self.transitionLayout.offset)) {
        [self.transitionLayout setOffset:offset];
        [self.transitionLayout setTransitionProgress:progress];
        [self.transitionLayout invalidateLayout];
        [_context updateInteractiveTransition:progress];
    }
}


-(void)endInteractionWithSuccess:(BOOL)success
{
    if (_context==nil)
    {
        self.hasActiveInteraction = FALSE;
        return;
    }
    if ((self.transitionLayout.transitionProgress > 0.5) && success)
    {
        [self.collectionView finishInteractiveTransition];
        [_context finishInteractiveTransition];
    }
    else
    {
        [self.collectionView cancelInteractiveTransition];
        [_context cancelInteractiveTransition];
    }
}


-(void)handlePinch:(UIPinchGestureRecognizer*)sender
{
    
    if (sender.numberOfTouches < 2)
    {
        return;
    }
    CGPoint point1 = [sender locationOfTouch:0 inView:sender.view];
    CGPoint point2 = [sender locationOfTouch:1 inView:sender.view];
    CGFloat distance = sqrt((point1.x - point2.x) * (point1.x - point2.x) + (point1.y - point2.y) * (point1.y - point2.y));
    CGPoint point = [sender locationInView:sender.view];
    
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        if (self.hasActiveInteraction)
        {
            return;
        }
        self.initialPinchDistance = distance;
        self.initialPinchPoint = point;
        self.hasActiveInteraction = TRUE;
        [self.delegate interactionBeganAtPoint:point];
        return;
    }
    if (!self.hasActiveInteraction)
    {
        return;
    }
    
    if (sender.state == UIGestureRecognizerStateChanged)
    {
        CGFloat offsetX = point.x - self.initialPinchPoint.x;
        CGFloat offsetY = point.y - self.initialPinchPoint.y;
        UIOffset offsetToUse = UIOffsetMake(offsetX, offsetY);
        
        CGFloat distanceDelta = distance - self.initialPinchDistance;
        if (self.navigationOperation == UINavigationControllerOperationPop)
        {
            distanceDelta = -distanceDelta;
        }
        CGFloat dimension = sqrt(self.collectionView.bounds.size.width*self.collectionView.bounds.size.width + self.collectionView.bounds.size.height*self.collectionView.bounds.size.height);
        CGFloat progress = MAX(MIN((distanceDelta / dimension), 1.0), 0.0);
        [self updateWithProgress:progress andOffset:offsetToUse];
        return;
    }
    
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        [self endInteractionWithSuccess:TRUE];
        return;
    }
    
    if (sender.state == UIGestureRecognizerStateCancelled)
    {
        [self endInteractionWithSuccess:FALSE];
        return;
    }
}
@end
