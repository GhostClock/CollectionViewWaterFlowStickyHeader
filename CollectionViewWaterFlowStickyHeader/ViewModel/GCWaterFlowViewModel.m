//
//  GCWaterFlowViewModel.m
//  CollectionViewWaterFlowStickyHeader
//
//  Created by GhostClock on 2019/9/27.
//  Copyright © 2019 GhostClock. All rights reserved.
//

#import "GCWaterFlowViewModel.h"
#import "GCWaterFlowModel.h"

#define URL @"https://api.douban.com/v2/movie/top250?start=%zu&count=10&apikey=0df993c66c0c636e29ecbb5344252a4a"

@interface GCWaterFlowViewModel()

@property (nonatomic, strong) GCWaterFlowModel *videoWaterFlowModel;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation GCWaterFlowViewModel

- (instancetype)init {
    if (self = [super init]) {
        self.dataSource = [NSMutableArray array];
        self.services = self;
    }
    return self;
}

- (void)requestDataWithCount:(NSInteger)count reloadData:(void(^)(void))reloadData {
    
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:URL, count]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves |NSJSONReadingAllowFragments error:nil];
            if (responseObject.count) {
                [self.dataSource addObjectsFromArray:[GCWaterFlowModel dataToModelWithDict:responseObject[@"subjects"]]];
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    !reloadData ?: reloadData();
                }];
            }
        } else {
            NSLog(@"请求错误, %@", error.userInfo);
        }
    }] resume];
}

- (CGFloat)waterflowLayout:(GCWaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth {
    if (self.dataSource.count) {
        GCWaterFlowModel *model = self.dataSource[index];
        return model.height;
    }
    return 0;
}

- (void)operationDataSource {
    [self.dataSource removeAllObjects];
}

- (NSInteger)collectionView:(id)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath complete:(void (^)(id))completedHandler {
    
}


@end
