//
//  GCWaterFlowService.h
//  CollectionViewWaterFlowStickyHeader
//
//  Created by GhostClock on 2019/9/28.
//  Copyright © 2019 GhostClock. All rights reserved.
//

#import <Foundation/Foundation.h>

static const NSInteger DefaultColumnCount = 2;

static inline CGFloat const DefaultColumnMargin() { return 10.5; }

static inline CGFloat const DefaultRowMargin() { return 11; }

static inline UIEdgeInsets const DefaultEdgeInsets() {
    return (UIEdgeInsets){0, 15.5, 10.5, 15.5};
}

@class GCWaterflowLayout;

#pragma mark -
#pragma mark - WaterLayoutService

@protocol GCWaterLayoutService <NSObject>

@required
- (CGFloat)waterflowLayout:(GCWaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;

@optional
- (CGFloat)columnCountInWaterflowLayout:(GCWaterflowLayout *)waterflowLayout;

- (CGFloat)columnMarginInWaterflowLayout:(GCWaterflowLayout *)waterflowLayout;

- (CGFloat)rowMarginInWaterflowLayout:(GCWaterflowLayout *)waterflowLayout;

- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(GCWaterflowLayout *)waterflowLayout;

@end

#pragma mark -
#pragma mark - WaterViewModelService

@protocol GCWaterViewModelService <NSObject>

- (NSArray *)dataSource;

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;

- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath complete:(void (^)(id contentsModel))completedHandler;

@end
