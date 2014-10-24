//
//  SearchCollectionView.m
//  ACME-Shopping
//
//  Created by fady on 13-10-30.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "SearchCollectionView.h"
#import "SearchCollectionCell.h"
#import "ListViewController.h"
#import "SearchModel.h"
#import "ItemModel.h"

@implementation SearchCollectionView

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.bounces = NO;
}

-(void)setData:(NSDictionary *)data
{
 
    _data = data;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.listNames.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    NSString *name = self.listNames[section];
    NSArray *array = [self.data objectForKey:name];
    return array.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SearchCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellId forIndexPath:indexPath];
    
    NSString *name = self.listNames[indexPath.section];
    NSArray *array = [self.data objectForKey:name];
    
    cell.contentView.backgroundColor = rgb(162, 123, 115, 0.6);
    cell.model = array[indexPath.row];


    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ViewId" forIndexPath:indexPath];
    
    UILabel *label = (UILabel *)[view viewWithTag:2013];
    
    if (label == nil) {
        UIView *leftLine = [[UIView alloc] initWithFrame:CGRectMake(10, 30/2, 115, 0.7)];
        leftLine.backgroundColor = [UIColor blackColor];
        
        UIView *rightLine = [[UIView alloc] initWithFrame:CGRectMake(195, 30/2, 115, 0.7)];
        rightLine.backgroundColor = [UIColor blackColor];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(125, (30-20)/2, 70, 20)];
        label.font = [UIFont systemFontOfSize:11];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor blackColor];
        label.tag = 2013;
        
        [view addSubview:leftLine];
        [view addSubview:rightLine];
        [view addSubview:label];
    }
    NSString *name = self.listNames[indexPath.section];
    
    label.text = name;
    
    return view;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreenWidth/3-13.5, 30);
}


-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10, 10, 10);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(kScreenWidth-20, 30);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *name = self.listNames[indexPath.section];
    NSArray *array = [self.data objectForKey:name];
    ListViewController *listCtrl = [[ListViewController alloc] init];

    ItemModel *model = array[indexPath.row];
    
    listCtrl.typeName = name;
    listCtrl.model = model;
    listCtrl.title = model.title;
    [self.viewController.navigationController pushViewController:listCtrl animated:YES];
}

@end
