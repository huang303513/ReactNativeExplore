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


NSString *const RNSTableViewCellIdentifier = @"RNSTableViewCellIdentifier";
NSString *const RNSDefaultTableViewCellIdentifier = @"RNSDefaultTableViewCellIdentifier";

@interface RNSTableView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) RCTBubblingEventBlock onClickItem;
@property (nonatomic, copy) RCTDirectEventBlock onRefresh;
@property (nonatomic, copy) RCTDirectEventBlock onEndReached;

@property(nonatomic, strong)id cellClass;
@end


@implementation RNSTableView

- (instancetype)init{
  self = [super init];
  if (self) {
    self.backgroundColor = [UIColor greenColor];
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.layer.borderColor = [[UIColor redColor] CGColor];;
    self.tableView.layer.borderWidth = 1;
    [self addSubview:self.tableView];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
      make.edges.equalTo(self);
    }];
    
    __weak __typeof(self) weakSelf = self;
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
      __strong __typeof(weakSelf) strongSelf = weakSelf;
      if ([strongSelf.tableView.mj_header isRefreshing]) {
        [strongSelf.tableView.mj_footer endRefreshing];
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
        [strongSelf.tableView.mj_header endRefreshing];
        return;
      }
      strongSelf.onRefresh(@{});
    }];
    
  }
  return self;
}

-(void)setData:(NSArray *)data{
  _data = data;
  [self.tableView.mj_footer endRefreshing];
  [self.tableView.mj_header endRefreshing];
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
    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_header endRefreshing];
  }
}

- (void)insertReactSubview:(UIView *)subview atIndex:(NSInteger)atIndex
{
 if ([subview isKindOfClass:[RNSTableFooterView class]]){
    RNSTableFooterView *footerView = (RNSTableFooterView *)subview;
   self.tableView.tableFooterView = footerView;
  } else if ([subview isKindOfClass:[RNSTableHeaderView class]]){
    RNSTableHeaderView *headerView = (RNSTableHeaderView *)subview;
    self.tableView.tableHeaderView = headerView;
  }else{
    [super insertSubview:subview atIndex:atIndex];
  }
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
  NSDictionary *params = self.data[indexPath.row];
  [cell setupCellWithParams:params];
  return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  self.onClickItem(@{@"index":@(indexPath.row)});
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
