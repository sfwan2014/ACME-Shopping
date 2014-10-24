//
//  HomeTableVIew.m
//  ACME-Shopping
//
//  Created by fady on 13-10-23.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#define kHomeCellIdentify @"kHomeCellIdentify"
#define kMoreCellIdentify @"kMoreCellIdentify"

#import "HomeTableVIew.h"
#import "CollectionCell.h"
#import "CustomModel.h"
#import "MoreCollectionCell.h"
#import "PageModel.h"
#import "DetailViewController.h"
#import "AppModel.h"

@implementation HomeTableVIew
- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self _initViews];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self _initViews];
}

-(void)_initViews
{
//    self.bounces = NO;
    [self setDelaysContentTouches:NO];
}

/*
 (
 CustomModel:{},
 CustomModel:{},
 CustomModel:{},
 CustomModel:{}
 )
 */

-(void)setData:(id)data
{
    _data = data;
    
    if ([data isKindOfClass:[NSArray class]]) {
        if (array2D == nil) {
            array2D = [[NSMutableArray alloc] init];
            [self _handleData];
        }
        
        [self _regisCollectionCell];
        
        
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        return;
    }
}

/*
    [[], [], []]
 */

-(void)_handleData
{
    NSArray *models = _data;
    
    NSMutableArray *array = nil;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    for (CustomModel *model in models) {
        
        NSString *key = model.title;
        array = [dic objectForKey:key];
        
        if (array == nil) {
            array = [NSMutableArray array];
            [dic setObject:array forKey:key];
        }
        
        if ([model.title isEqualToString:@"图片轮播"]) {
            [array addObject:model];
//            [dic setObject:array forKey:key];
            continue;
        }
        
        [array addObject:model];
    }
    
    [array2D addObject:[dic objectForKey:@"图片轮播"]];
    [array2D addObject:[dic objectForKey:@"图片混排"]];

    [array2D addObject:[dic objectForKey:@"精致女人"]];

    [array2D addObject:[dic objectForKey:@"品位男人"]];
}

-(void)_regisCollectionCell
{
    [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"c_ell"];
    [self registerClass:[CollectionCell class] forCellWithReuseIdentifier:kHomeCellIdentify];
}


#pragma mark - UICollectionView dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return array2D.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    if (section == 0) {
        return 1;
    }

    NSArray *array = array2D[section];
    CustomModel *model = [array lastObject];
    return [model.itemcount intValue];

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kHomeCellIdentify forIndexPath:indexPath];
    if (indexPath.section == 0) {
        
        CustomModel *model = [array2D[0] lastObject];
        cell.data = model.item;
        
        return cell;
    }
    
    CustomModel *model = [array2D[indexPath.section] lastObject];
    
    cell.model = model.item[indexPath.row];

    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeZero;

    if (indexPath.section == 0) {
        CustomModel *custon = [array2D[0] lastObject];
        NSArray *array = custon.item;
        ItemModel *model = array[0];
        return [CollectionCell getContentSize:model];
    }
    
    ItemModel *model = [array2D[indexPath.section] lastObject];
    size = [CollectionCell getContentSize:model];
    
    return size;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0 || section == 1) {
        return CGSizeMake(0, 0);
    }
    
    return CGSizeMake(kScreenWidth - 20, 30);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(0, 0, 10, 0);
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"c_ell" forIndexPath:indexPath];
    view.backgroundColor = [UIColor clearColor];
    
    UILabel *label = (UILabel *)[view viewWithTag:2013];
    
    if (label == nil) {
        view.hidden = NO;
        UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(10, (30-1)/2, 115, 0.7)];
        lineView1.backgroundColor = [UIColor blackColor];
        
        UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(195, (30-1)/2, 115, 0.7)];
        lineView2.backgroundColor = [UIColor blackColor];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(125, (30-20)/2, 70, 20)];
        label.font = [UIFont systemFontOfSize:11];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        label.backgroundColor = [UIColor clearColor];
        label.tag = 2013;
        
        [view addSubview:lineView1];
        [view addSubview:lineView2];
        [view addSubview:label];
    }
    
    if (indexPath.section == 2) {
        label.text = @"精致女人";
        
    } else if (indexPath.section == 3) {
        label.text = @"品味男人";
    }
    
    return view;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detail = [[DetailViewController alloc] init];
    detail.ishomeButton = NO;
    [self.viewController.navigationController pushViewController:detail animated:YES];
}

@end
