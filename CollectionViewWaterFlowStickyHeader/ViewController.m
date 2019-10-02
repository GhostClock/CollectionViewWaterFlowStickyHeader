//
//  ViewController.m
//  CollectionViewWaterFlowStickyHeader
//
//  Created by GhostClock on 2019/9/27.
//  Copyright © 2019 GhostClock. All rights reserved.
//

#import "ViewController.h"
#import "GCSubWaterFlowLayout.h"
#import "GCWaterFlowHeaderReusableView.h"
#import "GCWaterFlowViewModel.h"
#import "GCWaterFlowCollectionViewCell.h"

#define kScreenWidth self.view.bounds.size.width
#define kScreenHeight self.view.bounds.size.height

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) GCWaterFlowViewModel *viewModel;
@property (nonatomic, strong) UITableView *bgTableView;
@property (nonatomic, strong) MJRefreshHeader *header;
@property (nonatomic, assign) CGFloat contentHeight;
@property (nonatomic, strong) UICollectionView *mainCollectionView;
@property (nonatomic, strong) GCSubWaterFlowLayout *layout;
@property (nonatomic, strong) GCWaterFlowHeaderReusableView *headerView;
@property (nonatomic, assign) NSInteger pageCount;

@end

@implementation ViewController

- (instancetype)init {
    if (self = [super init]) {
        self.viewModel = GCWaterFlowViewModel.new;
        self.pageCount = 1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.mainCollectionView];
    [self.mainCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    __weak __typeof__(self)weakSelf = self;
    [self.viewModel requestDataWithCount:self.pageCount reloadData:^{
        [weakSelf reloadData];
    }];
    
    [self refreshView];
}

- (void)refreshView {
    __weak __typeof__(self)weakSelf = self;
    self.mainCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.viewModel operationDataSource];
        [weakSelf.viewModel requestDataWithCount:0 reloadData:^{
            [weakSelf reloadData];
        }];
    }];
    
    self.mainCollectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        weakSelf.pageCount ++;
        [weakSelf.viewModel requestDataWithCount:weakSelf.pageCount reloadData:^{
            [weakSelf reloadData];
        }];
    }];
}

- (void)reloadData {
    [self.mainCollectionView reloadData];
    [self.mainCollectionView.mj_header endRefreshing];
    [self.mainCollectionView.mj_footer endRefreshing];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.viewModel.services collectionView:collectionView numberOfItemsInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GCWaterFlowCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(GCWaterFlowCollectionViewCell.class) forIndexPath:indexPath];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        self.headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(GCWaterFlowHeaderReusableView.class) forIndexPath:indexPath];
    }
    return self.headerView;
}

- (UICollectionView *)mainCollectionView {
    if (!_mainCollectionView) {
        _layout = GCSubWaterFlowLayout.new;
        _layout.waterFlowLayoutService = (id<GCWaterLayoutService>)self.viewModel;
        _layout.headerReferenceSize = CGSizeMake(kScreenWidth, 100);//头部
        
        _mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
        _mainCollectionView.backgroundColor = UIColor.whiteColor;
        _mainCollectionView.dataSource = self;
        _mainCollectionView.delegate = self;
        _mainCollectionView.alwaysBounceVertical = YES;
        if (@available(iOS 11.0, *)){
            _mainCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }

        [_mainCollectionView registerClass:GCWaterFlowHeaderReusableView.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(GCWaterFlowHeaderReusableView.class)];
        [_mainCollectionView registerClass:GCWaterFlowCollectionViewCell.class forCellWithReuseIdentifier:NSStringFromClass(GCWaterFlowCollectionViewCell.class)];
    }
    return _mainCollectionView;
}

@end
