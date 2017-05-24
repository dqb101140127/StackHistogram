//
//  DMStackHistogramLayout.h
//  CollectionLayout
//
//  Created by dqb on 2017/4/4.
//  Copyright © 2017年 yq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DMStackHistogramLayoutDelegate <NSObject>
- (CGSize)stackHistogramView:(UICollectionView *)stackView layout:(UICollectionViewLayout *)stackViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface DMStackHistogramLayout : UICollectionViewLayout
@property (nonatomic, assign, readwrite) CGFloat itemWidth;
@property (nonatomic, assign, readwrite) CGFloat spaceWidth;
@property (nonatomic, assign, readwrite) CGFloat x_axis_h;
@property (nonatomic, assign) id<DMStackHistogramLayoutDelegate>delegate;
@end
