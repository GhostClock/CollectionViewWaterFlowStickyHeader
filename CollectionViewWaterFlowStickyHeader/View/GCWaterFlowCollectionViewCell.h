//
//  GCWaterFlowCollectionViewCell.h
//  CollectionViewWaterFlowStickyHeader
//
//  Created by GhostClock on 2019/9/27.
//  Copyright © 2019 GhostClock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GCWaterFlowModel;

@interface GCWaterFlowCollectionViewCell : UICollectionViewCell

- (void)reloadDataWithModel:(GCWaterFlowModel *)model;

@end

NS_ASSUME_NONNULL_END
