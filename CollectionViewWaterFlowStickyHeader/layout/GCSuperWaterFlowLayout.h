//
//  SuperWaterFlowLayout.h
//  CollectionViewWaterFlowStickyHeader
//
//  Created by GhostClock on 2019/9/28.
//  Copyright © 2019 GhostClock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCWaterFlowService.h"

NS_ASSUME_NONNULL_BEGIN

@interface GCSuperWaterFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, strong) NSMutableArray *attrsArray;

@property (nonatomic, strong) NSMutableArray *columnHeights;

@property (nonatomic, assign) CGFloat contentHeight;

@property (nonatomic, assign) NSInteger columnCount;

@property (nonatomic, assign) UIEdgeInsets edgeInsets;

@property (nonatomic, assign) CGFloat rowMargin;

@property (nonatomic, assign) CGFloat columnMargin;

@property (nonatomic, weak) id<GCWaterLayoutService> waterFlowLayoutService;

@end

NS_ASSUME_NONNULL_END
