//
//  GroupDetailVC.m
//  Photos
//
//  Created by song on 14-3-21.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//

#import "GroupDetailVC.h"
#import "Layouts.h"
#import "ImageCell.h"
#import "SWTTransitionController.h"
#import "FullScreenCollectionVC.h"
#import "AlbumsVC.h"
@interface GroupDetailVC ()
@property SWTTransitionController *transitionController;
@end

@implementation GroupDetailVC


- (id)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        [self configModel];

    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configView];
    [self refreshAssetInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Model
-(void)configModel
{
    assetsInfoArray = [[NSMutableArray alloc] init];
    self.transitionController = [[SWTTransitionController alloc] init];
    
    
}

-(void)refreshAssetInfo
{
    
    [assetsInfoArray removeAllObjects];
    [_group setAssetsFilter:[ALAssetsFilter allAssets]];
    [_group enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result) {
            [assetsInfoArray addObject:result];
        }else
        {

            [self.collectionView reloadData];
            NSInteger numberOfAsst = [_group numberOfAssets];
            if (numberOfAsst>2) {
                [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:numberOfAsst-1 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
            }
            
        }
    }];
}
#pragma mark - View
-(void)configView
{
    self.navigationController.delegate = self;
    imageMode = ImageModeSmall;
    [self.collectionView registerClass:[ImageCell class] forCellWithReuseIdentifier:@"ImageCell"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.title = [_group valueForProperty:ALAssetsGroupPropertyName];
}

#pragma mark - Control
-(void)transitionToMode:(ImageMode)mode
{
    if (mode==ImageModeBig) {
        
        
        
            [self.collectionView setCollectionViewLayout:[Layouts flowLayoutFullScreen] animated:YES completion:^(BOOL finished) {
                if (finished) {
                    
                }
            }];
        [self.collectionView reloadData];
        
    }else
    {
        
    }
}

#pragma mark - UINavigationControllerDelegate


/*
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}
 
 */


- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    return nil;
}
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    
//    UIViewControllerAnimatedTransitioning
    if ([fromVC isKindOfClass:[GroupDetailVC class]] && [toVC isKindOfClass:[FullScreenCollectionVC class ]]) {
        self.transitionController.isPushing = YES;
        return self.transitionController;
    }
    
    if ([fromVC isKindOfClass:[FullScreenCollectionVC class]] && [toVC isKindOfClass:[GroupDetailVC class]]) {
        self.transitionController.isPushing = NO;
        return self.transitionController;
    }
    
    
    if ([fromVC isEqual:self] && [toVC isKindOfClass:[AlbumsVC class]]) {
        self.navigationController.delegate = nil;
    }
    
    return nil;
}
 
#pragma mark - UICollectionViewDelegate
- (UICollectionViewTransitionLayout *)collectionView:(UICollectionView *)collectionView transitionLayoutForOldLayout:(UICollectionViewLayout *)fromLayout newLayout:(UICollectionViewLayout *)toLayout
{
    SWTTransitionLayout *layout = [[SWTTransitionLayout alloc] initWithCurrentLayout:fromLayout nextLayout:toLayout];
    return layout;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//    animationFrame = [collectionView convertRect:cell.frame toView:self.view];
    self.transitionController.animationRect = [collectionView convertRect:cell.frame toView:self.view];
    
    
    FullScreenCollectionVC *full = [[FullScreenCollectionVC alloc] initWithCollectionViewLayout:[Layouts flowLayoutFullScreen]];
    full.group = self.group;
    full.pageIndex = indexPath.row;
    
    [self.navigationController pushViewController:full animated:YES];
//    [self transitionToMode:ImageModeBig];
//    ImageCell *cell = (ImageCell*)[collectionView cellForItemAtIndexPath:indexPath];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger numberOfAssets = [_group numberOfAssets];
    return numberOfAssets;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    
    [_group enumerateAssetsAtIndexes:[NSIndexSet indexSetWithIndex:indexPath.row] options:NSEnumerationReverse usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        [cell loadWithALAsset:result];
    }];
//    [cell loadWithALAsset:assetsInfoArray[indexPath.row]];
    return cell;
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
