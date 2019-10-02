//
//  GCWaterFlowModel.h
//  CollectionViewWaterFlowStickyHeader
//
//  Created by GhostClock on 2019/9/28.
//  Copyright © 2019 GhostClock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GCSubjects : NSObject

@property (nonatomic, copy) NSString *image;

@end

@interface GCWaterFlowModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) GCSubjects *subjects;
@property (nonatomic, assign) CGFloat height;

+ (NSArray <GCWaterFlowModel *>*)dataToModelWithDict:(NSArray *)subjects;

@end

NS_ASSUME_NONNULL_END
