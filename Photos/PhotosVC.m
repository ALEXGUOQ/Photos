//
//  PhotosVC.m
//  Photos
//
//  Created by tag_mac_05 on 14-3-17.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//

#import "PhotosVC.h"
#import "ImageCell.h"
@interface PhotosVC ()

@end

@implementation PhotosVC

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
//    self.title = @"Years";
    
    
    [self configModel];
    [self configView];
    

    
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
-(void)configModel
{
    allImageInfo = [[NSMutableArray alloc] init];
    [self loadAllImage];
    
}

-(void)loadAllImage
{
    // Get the assets library
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    // Enumerate just the photos and videos group by using ALAssetsGroupSavedPhotos.
    __block NSInteger groupNumber =0;
    [library enumerateGroupsWithTypes:ALAssetsGroupAll
                           usingBlock:^(ALAssetsGroup *group, BOOL *stop)
     {
         groupNumber = groupNumber + 1;
//         NSLog(@"%ld",(long)groupNumber);
         // Within the group enumeration block, filter to enumerate just photos.
         [group setAssetsFilter:[ALAssetsFilter allAssets]];
         
         if (group.editable) {
             NSLog(@"yes");
             
         }else
         {
             NSLog(@"no");

         }
         NSLog(@"%@",[group valueForProperty:ALAssetsGroupPropertyName]);
         NSLog(@"%@",[group valueForProperty:ALAssetsGroupPropertyType]);
         NSLog(@"%@",[group valueForProperty:ALAssetsGroupPropertyPersistentID]);
         NSLog(@"%@",[group valueForProperty:ALAssetsGroupPropertyURL]);
         
         
         // For this example, we're only interested in the first item.
         [group enumerateAssetsAtIndexes:[NSIndexSet indexSetWithIndex:0]
                                 options:0
                              usingBlock:^(ALAsset *alAsset, NSUInteger index, BOOL *innerStop)
          {
              
              // The end of the enumeration is signaled by asset == nil.
              if (alAsset) {
                  ALAssetRepresentation *representation = [alAsset defaultRepresentation];
                  NSDictionary *imageMetadata = [representation metadata];
//                  NSLog(@"%@",imageMetadata);
                  // Do something interesting with the metadata.
              }
          }];
     }
                         failureBlock: ^(NSError *error)
     {
         // Typically you should handle an error more gracefully than this.
         NSLog(@"No groups");
     }];
    
    
}

#pragma mark - View
-(void)configView
{
    [self setTitleWithType:2];
    
    myCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[Layouts flowLayout]];
    [myCollectionView registerClass:[ImageCell class] forCellWithReuseIdentifier:@"ImageCell"];
    myCollectionView.dataSource = self;
}
-(void)setTitleWithType:(NSInteger)type
{
    NSArray *titles = [NSArray arrayWithObjects:@"Years",@"Collections",@"Moments", nil];
    self.title = titles[type];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [allImageInfo count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    
    
    return cell;
}

@end
