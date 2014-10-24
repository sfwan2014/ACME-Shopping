//
//  ZZFlowLayout.m
//  ACME-Shopping
//
//  Created by fady on 13-10-30.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "ZZFlowLayout.h"

@implementation ZZFlowLayout


- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return [super layoutAttributesForElementsInRect:rect];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIEdgeInsets edge = UIEdgeInsetsMake(2, 2, 2, 2);
    UICollectionViewLayoutAttributes *attributes = [[UICollectionViewLayoutAttributes alloc] init];
    CGRect frame = UIEdgeInsetsInsetRect(self.collectionView.frame, edge);
    attributes.frame = frame;
    
    return [super layoutAttributesForItemAtIndexPath:indexPath];
}

- (CGSize)collectionViewContentSize
{
    
    CGSize size = CGSizeMake(self.collectionView.frame.size.width, self.collectionView.frame.size.height);

    return size;
}


-(UIEdgeInsets)sectionInset
{
    return [super sectionInset];
}

//- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//
//}
//
//- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString*)decorationViewKind atIndexPath:(NSIndexPath *)indexPath
//{
//
//}

//- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
//{
//
//}

////////////////
//- (UICollectionViewLayoutInvalidationContext *)invalidationContextForBoundsChange:(CGRect)newBounds NS_AVAILABLE_IOS(7_0)
//{
//
//}

//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
//{
//
//}
//
//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset
//{
//
//}

@end
