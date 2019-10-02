//
//  GCSubWaterFlowLayout.m
//  CollectionViewWaterFlowStickyHeader
//
//  Created by GhostClock on 2019/9/27.
//  Copyright © 2019 GhostClock. All rights reserved.
//

#import "GCSubWaterFlowLayout.h"

@implementation GCSubWaterFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
}

// 关键: 重新计算
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attrs = [super layoutAttributesForItemAtIndexPath:indexPath];
    CGRect rect = attrs.frame;
    rect.origin.y += self.headerReferenceSize.height;
    attrs.frame = rect;
    return attrs;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    // 等于父类计算好的attrsArray
    NSMutableArray *answer = self.attrsArray;
    
    NSMutableIndexSet *missingSections = [NSMutableIndexSet indexSet];
    
    for (NSUInteger idx = 0; idx< answer.count; idx ++) {
        UICollectionViewLayoutAttributes *layoutAttributes = answer[idx];
        
        // 找出所有UICollectionElementCategoryCell类型的cell
        if (layoutAttributes.representedElementCategory == UICollectionElementCategoryCell) {
            [missingSections addIndex:layoutAttributes.indexPath.section];
        }
        // 再从里面删除所有UICollectionElementKindSectionHeader类型的cell
        if ([layoutAttributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            [answer removeObjectAtIndex:idx];
            idx--;
        }
    }
    
    // 默认情况下，为missingSections手动插入attributes，应该是为rect外的section生成attributes
    [missingSections enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:idx];
        UICollectionViewLayoutAttributes *layoutAttributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
        [answer addObject:layoutAttributes];
    }];
    
    return answer;
}

// 计算header的位置
- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForSupplementaryViewOfKind:kind atIndexPath:indexPath];
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionView * const cv = self.collectionView;
        CGPoint const contentOffset = cv.contentOffset;
        CGPoint nextHeaderOrigin = CGPointMake(INFINITY, INFINITY);
        
        if (indexPath.section + 1 < [cv numberOfSections]) {
            UICollectionViewLayoutAttributes *nextHeaderAttributes = [super layoutAttributesForSupplementaryViewOfKind:kind atIndexPath:[NSIndexPath indexPathForItem:0 inSection:indexPath.section+1]];
            nextHeaderOrigin = nextHeaderAttributes.frame.origin;
        }
        
        CGRect frame = attributes.frame;
        if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
            frame.origin.y = MIN(MAX(contentOffset.y, frame.origin.y), nextHeaderOrigin.y - CGRectGetHeight(frame));
        } else {
            frame.origin.x = MIN(MAX(contentOffset.x, frame.origin.x), nextHeaderOrigin.x - CGRectGetWidth(frame));
        }
        attributes.zIndex = 1024;
        attributes.frame = frame;
    }
    return attributes;
}

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForSupplementaryViewOfKind:kind atIndexPath:indexPath];
    return attributes;
}

- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForSupplementaryViewOfKind:kind atIndexPath:indexPath];
    return attributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBound {
    return YES;
}

- (CGSize)collectionViewContentSize {
    CGSize size = CGSizeMake(self.collectionView.frame.size.width, self.contentHeight + self.edgeInsets.bottom + self.headerReferenceSize.height);
    return size;
}

@end
