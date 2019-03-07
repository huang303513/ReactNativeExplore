//
//  SHOPTableView.h
//  AndroidNativeCustomRefreshView
//
//  Created by huangchengdu on 2019/3/6.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <React/RCTView.h>

NS_ASSUME_NONNULL_BEGIN

@interface RNSTableView : RCTView

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic, copy)NSArray *data;
@property(nonatomic, copy)NSString *renderItem;
@property(nonatomic, assign)BOOL refreshing;
@property(nonatomic, assign)CGFloat rowHeight;
@property(nonatomic, assign)BOOL fullListLoaded;

@end

NS_ASSUME_NONNULL_END
