//
//  RNSCollectionView.m
//  AndroidNativeCustomRefreshView
//
//  Created by huangchengdu on 2019/3/8.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "RNSCollectionView.h"
#import "Masonry/Masonry.h"
#import "MJRefresh/MJRefresh.h"
#import "RNSCellProtocol.h"
#import "RNSViewProtocol.h"
#import "RNSCollectionFooterView.h"
#import "RNSCollectionHeaderView.h"

static NSString *const RNSCollectionViewCellIdentifier = @"RNSCollectionViewCellIdentifier";
static NSString *const RNSCollectionViewHeaderIdentifier = @"RNSCollectionViewHeaderIdentifier";
static NSString *const RNSCollectionViewFooterIdentifier = @"RNSCollectionViewFooterIdentifier";

static const CGFloat kVerticalSPacing = 5.f;
static const CGFloat kItemSpacing = 5.f;   //item之间的间距  --
static const CGFloat kCellMargins = 5.f;   //左右缩进

@interface RNSCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,RNSViewProtocol,UIScrollViewDelegate>

@property(nonatomic, assign)NSInteger numColumns;
@property(nonatomic, strong)RNSCollectionHeaderView *headerView;
@property(nonatomic, strong)RNSCollectionFooterView *footerView;

@property(nonatomic, strong)UICollectionViewFlowLayout *layout;

@end


@implementation RNSCollectionView

@synthesize data = _data,renderItem = _renderItem,rowHeight = _rowHeight,refreshing = _refreshing,fullListLoaded = _fullListLoaded,onClickItem = _onClickItem,onRefresh = _onRefresh,onEndReached = _onEndReached,onScroll = _onScroll, cellClass = _cellClass,pullToRefresh = _pullToRefresh,onScrollBeginDrag = _onScrollBeginDrag,isCurrentVersionOnline = _isCurrentVersionOnline;

- (instancetype)init{
  self = [super init];
  if (self) {
    self.numColumns = 2;
    self.pullToRefresh = true;
    self.isCurrentVersionOnline = YES;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.layout = layout;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[RNSCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:RNSCollectionViewHeaderIdentifier];
    [self.collectionView registerClass:[RNSCollectionFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:RNSCollectionViewFooterIdentifier];
    [self addSubview:self.collectionView];
    
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
      make.edges.equalTo(self);
    }];
    
    self.backgroundColor = [UIColor clearColor];
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    __weak __typeof(self) weakSelf = self;
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
      __strong __typeof(weakSelf) strongSelf = weakSelf;
      if ([strongSelf.collectionView.mj_header isRefreshing]) {
        [strongSelf.collectionView.mj_footer setState:MJRefreshStateIdle];
        return;
      }
      strongSelf.onEndReached(@{});
    }];
    [footer setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
    [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"已经没有了" forState:MJRefreshStateNoMoreData];
    self.collectionView.mj_footer = footer;
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
      __strong __typeof(weakSelf) strongSelf = weakSelf;
      if ([strongSelf.collectionView.mj_footer isRefreshing]) {
        [strongSelf.collectionView.mj_header setState:MJRefreshStateIdle];
        return;
      }
      if (self.collectionView.mj_footer.state == MJRefreshStateNoMoreData) {
        [self.collectionView.mj_footer setState:MJRefreshStateIdle];
      }
      strongSelf.onRefresh(@{});
    }];
  }
  return self;
}




#pragma mark setter

-(void)setData:(NSArray *)data{
  _data = data;
  [self endRefresh];
  [self.collectionView reloadData];
}

-(void)setRenderItem:(NSString *)renderItem{
  _renderItem = renderItem;
  Class cls = NSClassFromString(renderItem);
  self.cellClass = [cls class];
  if (self.cellClass) {
    [self.collectionView registerClass:self.cellClass forCellWithReuseIdentifier:RNSCollectionViewCellIdentifier];
  }
}

- (void)setRefreshing:(BOOL)refreshing{
  _refreshing = refreshing;
  if (!refreshing) {
    [self endRefresh];
  }
}

- (void)endRefresh{
  if (self.collectionView.mj_footer.state == MJRefreshStateRefreshing) {
    [self.collectionView.mj_footer setState:MJRefreshStateIdle];
  }else if(self.collectionView.mj_header.state == MJRefreshStateRefreshing){
    [self.collectionView.mj_header setState:MJRefreshStateIdle];
  }
}

-(void)setRowHeight:(CGFloat)rowHeight{
  _rowHeight = rowHeight;
}

- (void)setNumColumns:(NSInteger)numColumns{
  _numColumns = numColumns;
}


- (void)setPullToRefresh:(BOOL)pullToRefresh{
  _pullToRefresh = pullToRefresh;
  if (!pullToRefresh) {
    self.collectionView.mj_header = nil;
  }
}

- (void)setFullListLoaded:(BOOL)fullListLoaded{
  _fullListLoaded = fullListLoaded;
  if (fullListLoaded) {
    [self.collectionView.mj_footer setState:MJRefreshStateNoMoreData];
  }else{
    [self.collectionView.mj_footer setState:MJRefreshStateIdle];
  }
}

- (void)insertReactSubview:(UIView *)subview atIndex:(NSInteger)atIndex
{
  if ([subview isKindOfClass:[RNSCollectionHeaderView class]]){
    self.headerView = (RNSCollectionHeaderView *)subview;
    return;
  } else if ([subview isKindOfClass:[RNSCollectionFooterView class]]){
    self.footerView = (RNSCollectionFooterView *)subview;
    return;
  }
  [super insertSubview:subview atIndex:atIndex];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return self.data.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  if (self.cellClass) {
    UICollectionViewCell<RNSCellProtocol> *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RNSCollectionViewCellIdentifier forIndexPath:indexPath];
    if (self.data.count > indexPath.row) {
      [cell setupCellWithParams:self.data[indexPath.row] isCurrentVersionOnline:self.isCurrentVersionOnline];
    }
    return cell;
  }
  return nil;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
  UICollectionReusableView *reusableview = nil;
  if (kind == UICollectionElementKindSectionHeader) {
    RNSCollectionHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:RNSCollectionViewHeaderIdentifier forIndexPath:indexPath];
    reusableview = header;
    if (self.headerView && reusableview) {
      [reusableview addSubview:self.headerView];
    }
  }
  if (kind == UICollectionElementKindSectionFooter) {
     RNSCollectionFooterView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:RNSCollectionViewFooterIdentifier forIndexPath:indexPath];
    reusableview = footer;
    if (self.footerView && reusableview) {
      self.footerView.frame = CGRectMake(0, 0, CGRectGetWidth(self.footerView.frame), CGRectGetHeight(self.footerView.frame));
      [reusableview addSubview:self.footerView];
    }
  }
  if (reusableview) {
     reusableview.backgroundColor = [UIColor clearColor];
  }
  return reusableview;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
  if (self.cellClass) {
   return CGSizeMake(([UIScreen mainScreen].bounds.size.width -kItemSpacing*(self.numColumns-1) - kCellMargins * 2)/self.numColumns, self.rowHeight);
  }
  return CGSizeZero;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
  return UIEdgeInsetsMake(kCellMargins, kCellMargins, kCellMargins, kCellMargins);
}

//定义每个UICollectionView的横向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
  return kItemSpacing;
}

//定义每个UICollectionView的纵向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
  return kVerticalSPacing;
}

//headerview的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{

  if (self.headerView) {
   return CGSizeMake(CGRectGetWidth(collectionView.frame), CGRectGetHeight(self.headerView.frame));
  }
  return CGSizeZero;
}
//footer的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
  if (self.footerView) {
    return CGSizeMake(CGRectGetWidth(collectionView.frame), CGRectGetHeight(self.footerView.frame));
  }
  return CGSizeZero;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  if ((self.data.count > indexPath.row) && self.onClickItem) {
    dispatch_async(dispatch_get_main_queue(), ^{
      self.onClickItem(@{@"index":@(indexPath.row)});
    });
  }
}

#pragma mark UIScrollViewDelegate;

//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
//    NSLog(@"滑动停止 = page");
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
  dispatch_async(dispatch_get_main_queue(), ^{
  self.onScroll(@{@"contentOffset":@{ @"y":@(scrollView.contentOffset.y),@"x":@(scrollView.contentOffset.x)}});
  });
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
  dispatch_async(dispatch_get_main_queue(), ^{
    self.onScrollBeginDrag(@{@"contentOffset":@{ @"y":@(scrollView.contentOffset.y),@"x":@(scrollView.contentOffset.x)}});
  });
}


@end
