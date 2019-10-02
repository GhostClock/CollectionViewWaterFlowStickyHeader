//
//  GCWaterFlowHeaderReusableView.m
//  CollectionViewWaterFlowStickyHeader
//
//  Created by GhostClock on 2019/9/27.
//  Copyright © 2019 GhostClock. All rights reserved.
//

#import "GCWaterFlowHeaderReusableView.h"

#ifdef __IPHONE_11_0
@implementation GCWaterFlowHeaderLayer

- (CGFloat)zPosition {
    return 0;
}

@end
#endif


@implementation GCWaterFlowHeaderReusableView

#ifdef __IPHONE_11_0
+ (Class)layerClass {
    return [GCWaterFlowHeaderLayer class];
}
#endif

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.purpleColor;
    }
    return self;
}


@end
