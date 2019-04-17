//
//  RNSTableViewCell.h
//  RNSFastList
//
//  Created by huangchengdu on 2019/4/15.
//

#import <UIKit/UIKit.h>
#import "RNSCellProtocol.h"

NS_ASSUME_NONNULL_BEGIN
@class RNSTemplateConvert;
@interface RNSTableViewCell : UITableViewCell<RNSCellProtocol>

@property(nonatomic, strong)RNSTemplateConvert *templateConvert;

@end

NS_ASSUME_NONNULL_END
