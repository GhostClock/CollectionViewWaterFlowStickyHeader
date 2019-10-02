//
//  GCWaterFlowViewModel.h
//  CollectionViewWaterFlowStickyHeader
//
//  Created by GhostClock on 2019/9/27.
//  Copyright © 2019 GhostClock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCWaterFlowService.h"

NS_ASSUME_NONNULL_BEGIN

@interface GCWaterFlowViewModel : NSObject <GCWaterViewModelService>

@property (nonatomic, weak) id<GCWaterViewModelService> services;

- (void)operationDataSource;

- (void)requestDataWithCount:(NSInteger)count reloadData:(void(^)(void))reloadData;

@end

NS_ASSUME_NONNULL_END
