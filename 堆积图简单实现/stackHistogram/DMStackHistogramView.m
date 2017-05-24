
//
//  DMStackHistogramView.m
//  CollectionLayout
//
//  Created by dqb on 2017/4/4.
//  Copyright © 2017年 yq. All rights reserved.
//

#import "DMStackHistogramView.h"
#import "DMStackHistogramXCoordinateView.h"
#import "DMStackHistogramDataManager.h"

@interface DMStackHistogramView ()<UICollectionViewDelegate,UICollectionViewDataSource,DMStackHistogramLayoutDelegate>

@end

@implementation DMStackHistogramView

- (DMStackHistogramCollectionView *)stackCollectionView{
    if (!_stackCollectionView) {
        DMStackHistogramLayout *layout = [[DMStackHistogramLayout alloc] init];
        layout.itemWidth = _columnWidth;
        layout.spaceWidth = _hspace;
        layout.x_axis_h = _x_axis_h;
        layout.delegate = self;
        _stackCollectionView = [[DMStackHistogramCollectionView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.yCoordinateView.frame), 0, self.bounds.size.width - CGRectGetMaxX(self.yCoordinateView.frame), self.frame.size.height) collectionViewLayout:layout];
//        _stackCollectionView.backgroundColor = [UIColor lightGrayColor];
        _stackCollectionView.delegate = self;
        _stackCollectionView.dataSource = self;
        [_stackCollectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
        [_stackCollectionView registerClass:[DMStackHistogramXCoordinateView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"DMStackHistogramXCoordinateView"];
    }
    return _stackCollectionView;
}

- (DMStackHistogramYCoordinateView *)yCoordinateView{
    if (!_yCoordinateView) {
        _yCoordinateView = [[DMStackHistogramYCoordinateView alloc] init];
        _yCoordinateView.frame = CGRectMake(0, 0, 40, self.frame.size.height);
    }
    return _yCoordinateView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _columnWidth = 30;
        _hspace = 20;
        _x_axis_h = 20;
        [self addSubview:self.stackCollectionView];
        [self addSubview:self.yCoordinateView];
        
    }
    return self;
}

- (void)setY_values:(NSArray *)y_values{
    _y_values = y_values;
    [[DMStackHistogramDataManager shareInstance] setStackViewContentHeight:self.stackCollectionView.bounds.size.height - 40];
    [[DMStackHistogramDataManager shareInstance] setDataSource:y_values];
    self.yCoordinateView.yAxisValues = [[DMStackHistogramDataManager shareInstance] yAxisValues];
    [self.stackCollectionView reloadData];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.y_values.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *sectionItems = [self.y_values objectAtIndex:section];

//    NSInteger number = arc4random() % 5;
//        NSLog(@"==========%zd",number);
    return sectionItems.count ;
}

- (CGSize)stackHistogramView:(UICollectionView *)stackView layout:(UICollectionViewLayout *)stackViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *heights = [[DMStackHistogramDataManager shareInstance] stackHistogramAllItemsHeight];
    NSArray *eachSectionHeights = [heights objectAtIndex:indexPath.section];
    return CGSizeMake(30, [[eachSectionHeights objectAtIndex:indexPath.item] floatValue]);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    NSArray *colors = [self.dataSource stackView:self colorForItem:indexPath];
    if (colors.count) {
        cell.contentView.backgroundColor = [colors objectAtIndex:indexPath.item];
    }
    return cell;
}




- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    DMStackHistogramXCoordinateView *xView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"DMStackHistogramXCoordinateView" forIndexPath:indexPath];
   NSArray *titles = [self.dataSource stackView:self xValueForItem:indexPath];
    if (titles.count) {
        xView.contentLab.text = [titles objectAtIndex:indexPath.section];
    }
    return xView;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate && [self.delegate respondsToSelector:@selector(stackView:didSelectedItemAtIndexPath:)]) {
        [self.delegate stackView:self didSelectedItemAtIndexPath:indexPath];
    }
}



@end
