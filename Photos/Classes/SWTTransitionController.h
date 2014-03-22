//
//  SWTTransitionController.h
//  Photos
//
//  Created by song on 14-3-22.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@protocol SWTTransitionController <NSObject>
-(void)interactionBeganAtPoint:(CGPoint)p;


@end
@interface SWTTransitionController : NSObject

@property (nonatomic) id <SWTTransitionController> delegate;
@property (nonatomic) BOOL hasActiveInteraction;
@property (nonatomic) UINavigationControllerOperation navigationOperation;
@property (nonatomic) UICollectionView* collectionView;

-(instancetype)initWithCollectionView:(UICollectionView*)collectionView;
@end
