//
//  CollectionViewController.m
//  Photos
//
//  Created by song on 14-3-30.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//

#import "CollectionViewController.h"
#import "ImageCell.h"
#import "MomentViewController.h"
#import "ToolKit.h"
@interface CollectionViewController ()

@end

@implementation CollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self.collectionView registerClass:[ImageCell class] forCellWithReuseIdentifier:@"ImageCell"];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewFlowLayout *flow = [ToolKit flowLayoutMoments];
    MomentViewController *vc = [[MomentViewController alloc] initWithCollectionViewLayout:flow];
    vc.useLayoutToLayoutNavigationTransitions = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [_collectionsArray count];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *array = _collectionsArray[section];
    return [array count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    
    NSArray *array = _collectionsArray[indexPath.section];
    ALAsset *asset = array[indexPath.row];
    [cell loadWithALAsset:asset];
    
    
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
