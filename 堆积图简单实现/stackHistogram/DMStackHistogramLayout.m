//
//  DMStackHistogramLayout.m
//  CollectionLayout
//
//  Created by dqb on 2017/4/4.
//  Copyright © 2017年 yq. All rights reserved.
//

#import "DMStackHistogramLayout.h"

@interface DMStackHistogramLayout ()
{
    CGFloat itemSpace;
}
@end

@implementation DMStackHistogramLayout

- (void)prepareLayout{
    [super prepareLayout];
    itemSpace = _spaceWidth;
}

- (CGSize)collectionViewContentSize{
    NSInteger sectionNumber = [self.collectionView numberOfSections];
    CGFloat totalWidth = (sectionNumber + 1) * itemSpace + sectionNumber * _itemWidth;
    
    return  CGSizeMake(totalWidth, self.collectionView.bounds.size.height);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *tmpAttributes = [NSMutableArray new];
    for (int j = 0; j < self.collectionView.numberOfSections; j++) {
        NSInteger count = [self.collectionView numberOfItemsInSection:j];
        
        for (NSInteger i = 0; i < count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:j];
            [tmpAttributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
        }
        [tmpAttributes addObject:[self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:[NSIndexPath indexPathForRow:0 inSection:j]]];

    }
    return tmpAttributes;
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGSize size = [self.delegate stackHistogramView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    CGRect frame = CGRectZero;
    frame.size = size;
    CGFloat y = self.collectionView.bounds.size.height - _x_axis_h;
    CGFloat x = 0;
    
    x = indexPath.section * (size.width + itemSpace) + itemSpace;
    for (NSInteger j = 0; j <= indexPath.item; j++) {
        CGSize size_a = [self.delegate stackHistogramView:self.collectionView layout:self sizeForItemAtIndexPath:[NSIndexPath indexPathForRow:j inSection:indexPath.section]];
        y = y - size_a.height;
    }
    frame.origin = CGPointMake(x, y);
    attribute.frame = frame;
    return attribute;
}



- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    CGFloat x = indexPath.section*(_itemWidth + itemSpace) + itemSpace *.5;
    attribute.frame = CGRectMake(x, self.collectionView.bounds.size.height - _x_axis_h, _itemWidth + itemSpace, _x_axis_h);
    return attribute;
}



@end
