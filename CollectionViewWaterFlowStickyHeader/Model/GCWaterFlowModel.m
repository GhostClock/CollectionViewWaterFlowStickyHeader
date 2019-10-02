//
//  GCWaterFlowModel.m
//  CollectionViewWaterFlowStickyHeader
//
//  Created by GhostClock on 2019/9/28.
//  Copyright © 2019 GhostClock. All rights reserved.
//

#import "GCWaterFlowModel.h"

@implementation GCSubjects

@end

@implementation GCWaterFlowModel

+ (NSArray <GCWaterFlowModel *>*)dataToModelWithDict:(NSArray *)subjects {
    NSMutableArray *temp = [NSMutableArray array];
    for (NSDictionary *dict in subjects) {
        GCWaterFlowModel *model = [GCWaterFlowModel mj_objectWithKeyValues:dict];
        model.subjects = [GCSubjects new];
        model.subjects.image = dict[@"images"][@"large"];
        model.height = (arc4random() % 101) + (arc4random() % 201) + 50; //网络请求回来后算每个Item的高度
        [temp addObject:model];
    }
    return temp;
}

@end
