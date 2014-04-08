//
//  FullScreenCollectionVC.m
//  Photos
//
//  Created by song on 14-3-23.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//

#import "FullScreenCollectionVC.h"
#import "SWTTransitionController.h"
#import "ImageCell.h"
@interface FullScreenCollectionVC ()

@end

@implementation FullScreenCollectionVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addGestures];
    [self configView];
    

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)prefersStatusBarHidden
{
    return preferStatusBarHidden;
}
- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
    return UIStatusBarAnimationSlide;
}
#pragma mark - Model
-(void)configModel
{
    preferStatusBarHidden = NO;
}
-(void)addGestures
{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reviveTap:)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:singleTap];
}

#pragma mark - View


-(void)configView
{
    self.collectionView.pagingEnabled = YES;
    self.navigationController.navigationBar.translucent = YES;
    
    self.collectionView.frame = CGRectMake(0, -20, 320+40, [ToolKit screenHeight]);
    self.collectionView.alwaysBounceVertical = NO;
    self.collectionView.pagingEnabled = YES;
//    self.collectionView.dataSource = self;
//    [self.collectionView registerClass:[ImageCell class] forCellWithReuseIdentifier:@"FullScreenCollectionVC"];
    

}
#pragma mark - Control
-(void)reviveTap:(UITapGestureRecognizer*)tapGestureRecognizer
{
    BOOL flag = [UIApplication sharedApplication].statusBarHidden;
    preferStatusBarHidden = !flag;
    [self.navigationController setNavigationBarHidden:preferStatusBarHidden animated:YES];
    [UIView animateWithDuration:0 delay:0.2 options:0 animations:^{
        [self setNeedsStatusBarAppearanceUpdate];
        
    } completion:^(BOOL finished) {
        if (finished) {
            if (preferStatusBarHidden) {
                self.collectionView.frame = CGRectMake(0, 0, 320+40, [ToolKit screenHeight]);
            }else
            {
                self.collectionView.frame = CGRectMake(0, -20, 320+40, [ToolKit screenHeight]);
            }
        }
    }];
    
    
    
    
}



#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"xxx");
}
#pragma mark - UICollectionViewDataSource

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
