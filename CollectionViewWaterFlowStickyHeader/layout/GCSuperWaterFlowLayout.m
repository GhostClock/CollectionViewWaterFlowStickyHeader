//
//  SuperWaterFlowLayout.m
//  CollectionViewWaterFlowStickyHeader
//
//  Created by GhostClock on 2019/9/28.
//  Copyright © 2019 GhostClock. All rights reserved.
//

#import "GCSuperWaterFlowLayout.h"

@implementation GCSuperWaterFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    // 清除之前所有的布局属性
    [self.attrsArray removeAllObjects];

    self.contentHeight = 0;

    // 清除以前计算的所有高度
    [self.columnHeights removeAllObjects];
    for (NSInteger i = 0; i < self.columnCount; i++) {
        [self.columnHeights addObject:@(self.edgeInsets.top)];
    }

    // 开始创建每一个cell对应的布局属性
    NSInteger count = [self.collectionView numberOfItemsInSection:0];

    for (NSInteger i = 0; i < count; i++) {
        // 创建位置
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];

        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
    }
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 创建布局属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    // collectionView的宽度
    CGFloat collectionViewW = self.collectionView.frame.size.width;

    // 设置布局属性的frame
    CGFloat w = (collectionViewW - self.edgeInsets.left - self.edgeInsets.right - (self.columnCount - 1) * self.columnMargin) / self.columnCount;
    CGFloat h = [self.waterFlowLayoutService waterflowLayout:(id)self heightForItemAtIndex:indexPath.item itemWidth:w];

    // 找出高度最短的那一列
    NSInteger destColumn = 0;
    //假设是第0列最短
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
    for (NSInteger i = 0; i < self.columnCount; i++) {
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];

        if (minColumnHeight > columnHeight) {
            minColumnHeight = columnHeight;
            destColumn = i;
        }
    }

    CGFloat x = self.edgeInsets.left + destColumn * (w + self.columnMargin);
    CGFloat y = minColumnHeight;
    if (y != self.edgeInsets.top) {
        y += self.rowMargin;
    }
    attrs.frame = CGRectMake(x, y, w, h);

    // 更新最短那列的高度
    self.columnHeights[destColumn] = @(CGRectGetMaxY(attrs.frame));

    // 记录内容的高度
    CGFloat columnHeight = [self.columnHeights[destColumn] doubleValue];
    if (self.contentHeight < columnHeight) {
        self.contentHeight = columnHeight;
    }
    return attrs;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return [super layoutAttributesForElementsInRect:rect];
}

- (CGSize)collectionViewContentSize {
    return [super collectionViewContentSize];
}

#pragma mark - getter and settter
- (NSMutableArray *)columnHeights {
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

- (NSMutableArray *)attrsArray {
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

- (CGFloat)rowMargin {
    if ([self.waterFlowLayoutService respondsToSelector:@selector(rowMarginInWaterflowLayout:)]) {
        return [self.waterFlowLayoutService rowMarginInWaterflowLayout:(id)self];
    }
    return DefaultRowMargin();
}

- (CGFloat)columnMargin {
    if ([self.waterFlowLayoutService respondsToSelector:@selector(columnMarginInWaterflowLayout:)]) {
        return [self.waterFlowLayoutService columnMarginInWaterflowLayout:(id)self];
    }
    return DefaultColumnMargin();
}

- (NSInteger)columnCount {
    if ([self.waterFlowLayoutService respondsToSelector:@selector(columnCountInWaterflowLayout:)]) {
        return [self.waterFlowLayoutService columnCountInWaterflowLayout:(id)self];
    }
    return DefaultColumnCount;
}

- (UIEdgeInsets)edgeInsets {
    if ([self.waterFlowLayoutService respondsToSelector:@selector(edgeInsetsInWaterflowLayout:)]) {
        return [self.waterFlowLayoutService edgeInsetsInWaterflowLayout:(id)self];
    }
    return DefaultEdgeInsets();
}

@end

