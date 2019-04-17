//
//  RNSViewProtocol.h
//  AndroidNativeCustomRefreshView
//
//  Created by huangchengdu on 2019/3/8.
//  Copyright © 2019 Facebook. All rights reserved.
//

#ifndef RNSViewProtocol_h
#define RNSViewProtocol_h

@protocol RNSViewProtocol <NSObject>

@required
@property(nonatomic, copy)NSArray *data;
@property(nonatomic, copy)NSString *renderItem;
@property(nonatomic, assign)CGFloat rowHeight;
@property(nonatomic, assign)BOOL refreshing;
@property(nonatomic, assign)BOOL fullListLoaded;
@property(nonatomic, copy) RCTBubblingEventBlock onClickItem;
@property(nonatomic, copy) RCTDirectEventBlock onRefresh;
@property(nonatomic, copy) RCTDirectEventBlock onEndReached;

@property(nonatomic, copy) RCTDirectEventBlock onScrollBeginDrag;
@property(nonatomic, copy)RCTDirectEventBlock onScroll;
@property(nonatomic, assign)BOOL pullToRefresh;
@property(nonatomic, assign)BOOL isCurrentVersionOnline;
@property(nonatomic, copy)NSDictionary *rowTemplate;


@property(nonatomic, strong)id cellClass;

@end

#endif /* RNSViewProtocol_h */
