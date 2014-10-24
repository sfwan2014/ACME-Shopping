//
//  LovingCollectionView.m
//  ACME-Shopping
//
//  Created by fady on 13-11-2.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "LovingCollectionView.h"
#import "DetailViewController.h"
#import "DetailModel.h"

@implementation LovingCollectionView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.dataSource = self;
    self.delegate = self;
    
    self.bounces = NO;
    
    [self registerClass:[LovingCell class] forCellWithReuseIdentifier:@"kCellId"];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 5;
//    self.collectionViewLayout = layout;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LovingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"kCellId" forIndexPath:indexPath];
    cell.deleteDelegate = self;
    cell.isDelete = self.isDelete;
    cell.model = self.data[indexPath.row];
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(150, 150);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(2, 5, 0, 5);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LovingCell *cell = (LovingCell *)[collectionView cellForItemAtIndexPath:indexPath];
    DetailModel *model = self.data[indexPath.row];
    UIImage *image = cell.imgView.image;
    if (self.selectedBlock != nil) {
        self.selectedBlock(image, model);
        return;
    }
    
    DetailViewController *detailCtrl = [[DetailViewController alloc] init];
    detailCtrl.ishomeButton = NO;
    detailCtrl.numId = [model.numIid stringValue];
    [self.viewController.navigationController pushViewController:detailCtrl animated:YES];
}

#pragma mark - LovingCellDelegate
-(void)deleteFinish:(LovingCell *)cell
{
    if (self.block != nil) {
        self.block(self);
    }
}

@end
