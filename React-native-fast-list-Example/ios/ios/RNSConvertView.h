//
//  RNSConvertView.h
//  RNSFastList
//
//  Created by huangchengdu on 2019/4/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface RNSConvertView : NSObject

@property(nonatomic, strong)NSString *templateName;

- (instancetype)initWithRootView:(UIView *)rootView;

- (void)convertView:(NSDictionary *)viewConfig params:(NSArray *)params;

@end

NS_ASSUME_NONNULL_END
