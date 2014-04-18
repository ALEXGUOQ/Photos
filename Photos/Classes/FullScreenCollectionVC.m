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
    return UIStatusBarAnimationFade;
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
//    self.collectionView.dataSource = self;
//    [self.collectionView registerClass:[ImageCell class] forCellWithReuseIdentifier:@"FullScreenCollectionVC"];
    

}
#pragma mark - Control
-(void)reviveTap:(UITapGestureRecognizer*)tapGestureRecognizer
{
    BOOL flag = [UIApplication sharedApplication].statusBarHidden;
    preferStatusBarHidden = !flag;
    [self setNeedsStatusBarAppearanceUpdate];
    
}





#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}
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
