//
//  PhotosVC.m
//  Photos
//
//  Created by tag_mac_05 on 14-3-17.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//

#import "PhotosVC.h"

@interface PhotosVC ()

@end

@implementation PhotosVC

#pragma mark - UICollectionViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {

    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

//        NSLog(@"%ld",(long)NSIntegerMax);
    
    
    // Get the assets library
    [self confgiModel];
    [self configView];
    [self loadData];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


#pragma mark - Model
-(void)confgiModel
{
    yearArray = [[NSMutableArray alloc] init];
    
    
}

-(void)loadData
{
    NSMutableArray *allYears = [[NSMutableArray alloc] init];
    
    for (int i=0; i<200; i++) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [allYears addObject:array];
    }

    ALAssetsLibrary *library = [ToolKit sharedAssetsLibrary];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    [library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            
            [group setAssetsFilter:[ALAssetsFilter allAssets]];
            [group enumerateAssetsWithOptions:NSEnumerationConcurrent usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                if (result) {
//                    [allAsset addObject:result];
                    NSDate *date = [result valueForProperty:ALAssetPropertyDate];
                    NSInteger index = [[formatter stringFromDate:date] integerValue];
                    index = index-1990;
                    NSMutableArray *array = allYears[index];
                    [array addObject:result];
                }
                
            }];
        }else
        {
                NSLog(@"枚举完成");
            for (NSMutableArray *array in allYears) {
                if ([array count]>0) {
//                    每个是一年
                    [yearArray addObject:array];
                }
            }
            [myCollectionView reloadData];
        }
    } failureBlock:^(NSError *error) {
        
    }];
}



#pragma mark - View
-(void)configView
{
    self.title = @"年度";
    myCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[Layouts flowLayoutYear]];
    myCollectionView.dataSource = self;
    myCollectionView.backgroundColor = [UIColor whiteColor];
    [myCollectionView registerClass:[ImageCell class] forCellWithReuseIdentifier:@"ImageCell"];
    
    [self.view addSubview:myCollectionView];
//    myCollectionView.delegate = self;
//    [self.collectionView setCollectionViewLayout:[Layouts flowLayoutYear]];
    
}

#pragma mark - UICollectionViewDelegate


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [yearArray count];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *array = yearArray[section];
    return [array count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    NSArray *array = yearArray[indexPath.section];
    ALAsset *asset = array[indexPath.row];
    [cell loadWithALAsset:asset];
    return cell;
}

@end
