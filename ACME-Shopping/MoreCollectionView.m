//
//  MoreCollectionView.m
//  ACME-Shopping
//
//  Created by fady on 13-10-25.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "MoreCollectionView.h"
#import <QuartzCore/QuartzCore.h>
#import "PageModel.h"
#import "MoreCollectionCell.h"
#import "HomeScrollView.h"
#import "DetailViewController.h"
#import "ListModel.h"
#import "WebViewController.h"

@interface MoreCollectionView ()<RFQuiltLayoutDelegate>

@property (nonatomic) NSMutableArray* numbers;

@end

@implementation MoreCollectionView

- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self registerClass:[MoreCollectionCell class] forCellWithReuseIdentifier:@"cellId"];
        self.backgroundColor = [UIColor clearColor];
        self.isPull = YES;
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [self registerClass:[MoreCollectionCell class] forCellWithReuseIdentifier:@"cellId"];
    self.backgroundColor = [UIColor clearColor];
    
    RFQuiltLayout* layout = [[RFQuiltLayout alloc] init];
    layout.direction = UICollectionViewScrollDirectionVertical;
    layout.blockPixels = CGSizeMake(100, 100);
    
    layout.delegate = self;
    self.isPull = YES;
    self.collectionViewLayout = layout;
}

-(void)setData:(id)data
{
    _data = data;
    if ([data isKindOfClass:[NSArray class]]) {
        
        array2D = nil;
        NSArray *array = (NSArray *)data;
        array2D = [[NSMutableArray alloc] init];
        [array2D addObjectsFromArray:array];
        [self reloadData];
        
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        NSString *key = [[data allKeys] lastObject];
        NSArray *array = [data objectForKey:key];
        array2D = nil;
        array2D = [[NSMutableArray alloc] init];
        [array2D  addObjectsFromArray:array];
        
        [self reloadData];
    }
}


#pragma mark - UICollectionView Datasource



- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return array2D.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MoreCollectionCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    
    cell.model = array2D[indexPath.row];
    
    return cell;
}


#pragma mark – RFQuiltLayoutDelegate

- (CGSize) blockSizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BaseModel *model = array2D[indexPath.row];
    CGSize size = {0, 0};
    
    if (indexPath.row %6 == 0) {
        size = CGSizeMake(220, 220);
    } else {
        size = CGSizeMake(110, 110);
    }
    
    if ([model isKindOfClass:[PageModel class]]) {
        size = [MoreCollectionCell getContentSize:(PageModel *)model];
    }
    
    float width = size.width/110.0;
    float height = size.height/110.0;
    
    if (width> 1.5) {
        width = 2;
    } else {
        width = 1;
    }
    
    if (height > 1.5) {
        height = 2;
    } else {
        height = 1;
    }
    
    size = CGSizeMake(width, height);
    return size;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
//    if ([model isKindOfClass:[ListModel class]]) {
//        WebViewController *web = [[WebViewController alloc] init];
//        web.url = ((ListModel *)model).detail_url;
//        [self.viewController.navigationController pushViewController:web animated:YES];
//        return;
//    }
    BaseModel *model = array2D[indexPath.row];   
    DetailViewController *detail = [[DetailViewController alloc] init];
    detail.model = model;
    detail.ishomeButton = NO;
    [self.viewController.navigationController pushViewController:detail animated:YES];
}

@end
