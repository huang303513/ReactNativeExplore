//
//  RNSTableViewCell.h
//  RNSFastList
//
//  Created by huangchengdu on 2019/4/15.
//

#import <UIKit/UIKit.h>
#import "RNSCellProtocol.h"

NS_ASSUME_NONNULL_BEGIN


@class RNSConvertView;
@interface RNSTableViewCell : UITableViewCell<RNSCellProtocol>

@property(nonatomic, strong)RNSConvertView *convert;

@end

NS_ASSUME_NONNULL_END
