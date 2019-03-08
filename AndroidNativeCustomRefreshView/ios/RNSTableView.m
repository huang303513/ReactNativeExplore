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


NSString *const RNSTableViewCellIdentifier = @"RNSTableViewCellIdentifier";
NSString *const RNSDefaultTableViewCellIdentifier = @"RNSDefaultTableViewCellIdentifier";

@interface RNSTableView ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, copy)NSArray *data;
@property(nonatomic, copy)NSString *renderItem;
@property(nonatomic, assign)CGFloat rowHeight;
@property(nonatomic, assign)BOOL refreshing;
@property(nonatomic, assign)BOOL fullListLoaded;
@property(nonatomic, copy) RCTBubblingEventBlock onClickItem;
@property(nonatomic, copy) RCTDirectEventBlock onRefresh;
@property(nonatomic, copy) RCTDirectEventBlock onEndReached;
@property(nonatomic, assign)CGFloat cacheHeight;

@property(nonatomic, strong)id cellClass;
@end


@implementation RNSTableView

- (instancetype)init{
  self = [super init];
  if (self) {
    self.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
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
  [self.tableView reloadData];
}

-(void)setRenderItem:(NSString *)renderItem{
  _renderItem = renderItem;
  Class cls = NSClassFromString(renderItem);
  self.cellClass = [cls class];
  if (self.cellClass) {
    [self.tableView registerClass:self.cellClass forCellReuseIdentifier:RNSTableViewCellIdentifier];
  }
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

- (void)setFullListLoaded:(BOOL)fullListLoaded{
  _fullListLoaded = fullListLoaded;
  if (fullListLoaded) {
    [self.tableView.mj_footer setState:MJRefreshStateNoMoreData];
  }else{
    [self.tableView.mj_footer setState:MJRefreshStateIdle];
  }
}

- (void)setCacheHeight:(CGFloat)cacheHeight{
  _cacheHeight = cacheHeight;
  self.tableView.estimatedRowHeight = _cacheHeight;
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
  
  UITableViewCell<RNSCellProtocol> *cell =[tableView dequeueReusableCellWithIdentifier:RNSTableViewCellIdentifier forIndexPath:indexPath];
  if (cell == nil) {
    if (self.cellClass) {
       cell = [[self.cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RNSTableViewCellIdentifier];
    }else{
        cell = [[UITableViewCell<RNSCellProtocol> alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RNSDefaultTableViewCellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
  }
  if (self.data.count > indexPath.row) {
    NSDictionary *params = self.data[indexPath.row];
    [cell setupCellWithParams:params];
  }
  return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  if (self.rowHeight) {
    return self.rowHeight;
  }
  if (self.cacheHeight > 0) {
    return self.cacheHeight;
  }
  if (self.cellClass) {
    CGFloat height = [tableView fd_heightForCellWithIdentifier:RNSTableViewCellIdentifier configuration:^(id cell) {
      if (self.data.count > indexPath.row) {
        NSDictionary *params = self.data[indexPath.row];
        [cell setupCellWithParams:params];
      }
    }];
    self.cacheHeight = height;
    return height;
  }
  return [tableView fd_heightForCellWithIdentifier:RNSDefaultTableViewCellIdentifier configuration:^(id cell) {
  }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  if ((self.data.count > indexPath.row) && self.onClickItem) {
    dispatch_async(dispatch_get_main_queue(), ^{
      self.onClickItem(@{@"index":@(indexPath.row)});
    });
  }
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
