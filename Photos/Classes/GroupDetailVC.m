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
#import "SAnimationTransition.h"
@interface GroupDetailVC ()

@end

@implementation GroupDetailVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self configModel];
    }
    return self;
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
            [myCollectionView reloadData];
            NSInteger numberOfAsst = [_group numberOfAssets];
            [myCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:numberOfAsst-1 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
        }
    }];
}
#pragma mark - View
-(void)configView
{
    
    imageMode = ImageModeSmall;
    
    myCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[Layouts flowLayoutFourEachLine]];
    myCollectionView.dataSource = self;
    myCollectionView.delegate = self;
    myCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:myCollectionView];
    [myCollectionView registerClass:[ImageCell class] forCellWithReuseIdentifier:@"ImageCell"];
    
    
    self.title = [_group valueForProperty:ALAssetsGroupPropertyName];
}

#pragma mark - Control
-(void)transitionToMode:(ImageMode)mode
{
    if (mode==ImageModeBig) {
        myCollectionView.pagingEnabled = YES;
        [UIView animateWithDuration:2 animations:^{
            
        }];
        [myCollectionView setCollectionViewLayout:[Layouts flowLayoutFullScreen] animated:YES completion:^(BOOL finished) {
            
        }];
    }else
    {
        
    }
}
#pragma mark - UICollectionViewDelegate
- (UICollectionViewTransitionLayout *)collectionView:(UICollectionView *)collectionView transitionLayoutForOldLayout:(UICollectionViewLayout *)fromLayout newLayout:(UICollectionViewLayout *)toLayout
{
    SAnimationTransition *transitionLayout = [[SAnimationTransition alloc] initWithCurrentLayout:fromLayout nextLayout:toLayout];
    return transitionLayout;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self transitionToMode:ImageModeBig];
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
