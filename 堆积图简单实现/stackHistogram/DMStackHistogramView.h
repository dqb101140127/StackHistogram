//
//  DMStackHistogramView.h
//  CollectionLayout
//
//  Created by dqb on 2017/4/4.
//  Copyright © 2017年 yq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMStackHistogramCollectionView.h"
#import "DMStackHistogramLayout.h"
#import "CollectionViewCell.h"
#import "DMStackHistogramYCoordinateView.h"

@class DMStackHistogramView;
@protocol DMStackHistogramViewDataSource <NSObject>
@required;
- (NSArray *)stackView:(DMStackHistogramView *)stackView colorForItem:(NSIndexPath *)indexPath;
- (NSArray *)stackView:(DMStackHistogramView *)stackView xValueForItem:(NSIndexPath *)indexPath;

@end

@protocol DMStackHistogramViewDelegate <NSObject>
- (void)stackView:(DMStackHistogramView *)stackView didSelectedItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface DMStackHistogramView : UIView
@property (nonatomic, strong) DMStackHistogramCollectionView *stackCollectionView;
@property (nonatomic, strong) DMStackHistogramYCoordinateView *yCoordinateView;
@property (nonatomic, weak) id<DMStackHistogramViewDataSource>dataSource;
@property (nonatomic, weak) id<DMStackHistogramViewDelegate>delegate;
/**
 *柱状图宽度
 */
@property (nonatomic, assign) CGFloat columnWidth;
/**
 *水平间隙
 */
@property (nonatomic, assign) CGFloat hspace;
/**
 * x轴坐标高度
 */
@property (nonatomic, assign) CGFloat x_axis_h;

@property (nonatomic, strong) NSArray *y_values;
@property (nonatomic, strong) NSArray *colors;
@end
