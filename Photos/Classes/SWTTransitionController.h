//
//  SWTTransitionController.h
//  Photos
//
//  Created by song on 14-3-22.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;


@interface SWTTransitionController : NSObject <UIViewControllerAnimatedTransitioning,UIViewControllerInteractiveTransitioning>
@property (nonatomic) BOOL isPushing;
@property (nonatomic) CGRect animationRect;


@end
