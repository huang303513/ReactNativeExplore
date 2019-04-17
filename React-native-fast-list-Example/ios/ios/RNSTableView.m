//
//  SHOPTableView.m
//  AndroidNativeCustomRefreshView
//
//  Created by huangchengdu on 2019/3/6.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "RNSTableView.h"
#import "RNSTableViewManager.h"
#import "Masonry/Masonry.h"
#import "MJRefresh/MJRefresh.h"
#import "RNSCellProtocol.h"
#import "RNSTableHeaderView.h"
#import "RNSTableFooterView.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "RNSViewProtocol.h"
#import "RNSTableViewCell.h"
#import <YYModel/YYModel.h>
#import "RNSUIViewModel.h"
#import "RNSUILableModel.h"
#import "RNSModelFactory.h"


//NSString *const RNSTableViewCellIdentifier = @"RNSTableViewCellIdentifier";
NSString *const RNSDefaultTableViewCellIdentifier = @"RNSDefaultTableViewCellIdentifier";

@interface RNSTableView ()<UITableViewDataSource, UITableViewDelegate,RNSViewProtocol,UIScrollViewDelegate>

@property(nonatomic, assign)BOOL showFreeBuy;

@property(nonatomic, assign)CGFloat cacheHeight;

@end


@implementation RNSTableView

@synthesize data = _data,renderItem = _renderItem,rowHeight = _rowHeight,refreshing = _refreshing,fullListLoaded = _fullListLoaded,onClickItem = _onClickItem,onRefresh = _onRefresh,onEndReached = _onEndReached,onScroll = _onScroll, cellClass = _cellClass,pullToRefresh = _pullToRefresh,onScrollBeginDrag = _onScrollBeginDrag, isCurrentVersionOnline = _isCurrentVersionOnline, rowTemplate = _rowTemplate;

- (instancetype)init{
  self = [super init];
  if (self) {
    
    self.pullToRefresh = true;
    self.isCurrentVersionOnline = true;
    self.showFreeBuy = false;
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerClass:[RNSTableViewCell class] forCellReuseIdentifier:RNSDefaultTableViewCellIdentifier];
    [self addSubview:self.tableView];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
      make.edges.equalTo(self);
    }];
    
    self.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    __weak __typeof(self) weakSelf = self;
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
      __strong __typeof(weakSelf) strongSelf = weakSelf;
      if ([strongSelf.tableView.mj_header isRefreshing]) {
        [strongSelf.tableView.mj_footer setState:MJRefreshStateIdle];
        return;
      }
      strongSelf.onEndReached(@{});
    }];
    [footer setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
    [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"已经没有了" forState:MJRefreshStateNoMoreData];
    self.tableView.mj_footer = footer;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
      __strong __typeof(weakSelf) strongSelf = weakSelf;
      if ([strongSelf.tableView.mj_footer isRefreshing]) {
        [strongSelf.tableView.mj_header setState:MJRefreshStateIdle];
        return;
      }
      if (self.tableView.mj_footer.state == MJRefreshStateNoMoreData) {
        [self.tableView.mj_footer setState:MJRefreshStateIdle];
      }
      strongSelf.onRefresh(@{});
    }];
    
  }
  return self;
}

-(void)setData:(NSArray *)data{
  _data = data;
  [self endRefresh];
  dispatch_async(dispatch_get_main_queue(), ^{
    [self.tableView reloadData];
  });

}

- (void)setRefreshing:(BOOL)refreshing{
  _refreshing = refreshing;
  if (!refreshing) {
    [self endRefresh];
  }
}

- (void)endRefresh{
  if (self.tableView.mj_footer.state == MJRefreshStateRefreshing) {
    [self.tableView.mj_footer setState:MJRefreshStateIdle];
  }else if(self.tableView.mj_header.state == MJRefreshStateRefreshing){
    [self.tableView.mj_header setState:MJRefreshStateIdle];
  }
}


-(void)setRowHeight:(CGFloat)rowHeight{
  _rowHeight = rowHeight;
  self.tableView.estimatedRowHeight = rowHeight;
}

- (void)setPullToRefresh:(BOOL)pullToRefresh{
  _pullToRefresh = pullToRefresh;
  if (!pullToRefresh) {
    self.tableView.mj_header = nil;
  }
}

- (void)setFullListLoaded:(BOOL)fullListLoaded{
  _fullListLoaded = fullListLoaded;
  if (fullListLoaded) {
    [self.tableView.mj_footer setState:MJRefreshStateNoMoreData];
  }else{
    [self.tableView.mj_footer setState:MJRefreshStateIdle];
  }
}

- (void)setRowTemplate:(NSDictionary *)rowTemplate{
  
  __block NSMutableDictionary *temp = @{}.mutableCopy;
  
  [rowTemplate enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSArray *obj, BOOL * _Nonnull stop) {
    __block NSMutableArray *viewArray = @[].mutableCopy;
    [obj enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
      [viewArray addObject:[RNSModelFactory createModel:obj]];
    }];
    [temp setValue:viewArray forKey:key];
  }];
  
  _rowTemplate = temp;
}

- (void)insertReactSubview:(UIView *)subview atIndex:(NSInteger)atIndex
{
  if ([subview isKindOfClass:[RNSTableFooterView class]]){
    RNSTableFooterView *footerView = (RNSTableFooterView *)subview;
   self.tableView.tableFooterView = footerView;
   return;
  } else if ([subview isKindOfClass:[RNSTableHeaderView class]]){
    RNSTableHeaderView *headerView = (RNSTableHeaderView *)subview;
    self.tableView.tableHeaderView = headerView;
    return;
  }
  [super insertSubview:subview atIndex:atIndex];
}


#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RNSTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:RNSDefaultTableViewCellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
                cell = [[RNSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RNSDefaultTableViewCellIdentifier];
    }
    
    if (self.data.count > indexPath.row) {
        NSArray *params = self.data[indexPath.row];
        [cell setupCellWithParams:params rowTemplate:self.rowTemplate[params[0]]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  if ((self.data.count > indexPath.row) && self.onClickItem) {
    dispatch_async(dispatch_get_main_queue(), ^{
      self.onClickItem(@{@"index":@(indexPath.row)});
    });
  }
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
