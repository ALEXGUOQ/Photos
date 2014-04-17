//
//  GroupDetailVC.m
//  Photos
//
//  Created by song on 14-3-21.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//

#import "GroupDetailVC.h"
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

    imageMode = ImageModeSmall;
    [self.collectionView registerClass:[ImageCell class] forCellWithReuseIdentifier:@"ImageCell"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.title = [_group valueForProperty:ALAssetsGroupPropertyName];
}

#pragma mark - Control
-(void)transitionToMode:(ImageMode)mode
{
    if (mode==ImageModeBig) {
        
        
        
            [self.collectionView setCollectionViewLayout:[ToolKit flowLayoutFullScreen] animated:YES completion:^(BOOL finished) {
                if (finished) {
                    
                }
            }];
        [self.collectionView reloadData];
        
    }else
    {
        
    }
}


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    self.pressRect = [collectionView convertRect:cell.frame toView:self.view];
    
    FullScreenCollectionVC *full = [[FullScreenCollectionVC alloc] initWithCollectionViewLayout:[ToolKit flowLayoutFullScreen]];
    full.useLayoutToLayoutNavigationTransitions = YES;
    
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
