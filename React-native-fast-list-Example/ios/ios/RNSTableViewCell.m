//
//  RNSTableViewCell.m
//  RNSFastList
//
//  Created by huangchengdu on 2019/4/15.
//

#import "RNSTableViewCell.h"
#import "RNSTemplateConvert.h"


@implementation RNSTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      self.backgroundColor = [UIColor clearColor];
      self.contentView.backgroundColor = [UIColor clearColor];
      self.contentView.layer.borderColor = [UIColor greenColor].CGColor;
      self.contentView.layer.borderWidth = 1;
      self.selectionStyle = UITableViewCellSelectionStyleNone;
      
      self.templateConvert = [[RNSTemplateConvert alloc]initWithCell:self];
    }
    return self;
}
/**
 参数列表
 模板列表
 */
- (void)setupCellWithParams:(NSArray *)params rowTemplate:(nonnull NSArray *)rowTemplate{
    dispatch_async(dispatch_get_main_queue(), ^{
      [self.templateConvert convertTemplateToView:rowTemplate params:params];
    });
}

@end
