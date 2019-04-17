//
//  RNSTableViewCell.m
//  RNSFastList
//
//  Created by huangchengdu on 2019/4/15.
//

#import "RNSTableViewCell.h"
#import "RNSConvertView.h"


@implementation RNSTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.contentView.layer.borderColor = [UIColor greenColor].CGColor;
        self.contentView.layer.borderWidth = 1;
      
      self.convert = [[RNSConvertView alloc]initWithRootView:self.contentView];
    }
    return self;
}

- (void)setupCellWithParams:(NSArray *)params rowTemplate:(nonnull NSDictionary *)rowTemplate{
  
    self.convert.templateName = params[0];
    NSDictionary *template = rowTemplate[params[0]];
    dispatch_async(dispatch_get_main_queue(), ^{
      [self.convert convertView:template params:params];
    });
}

@end
