//
//  RNSConvertView.m
//  RNSFastList
//
//  Created by huangchengdu on 2019/4/16.
//

#import <UIKit/UIKit.h>
#import "RNSTemplateConvert.h"
#import <YYModel/YYModel.h>
#import <Masonry/Masonry.h>
#import "RNSConstant.h"
#import <SDWebImage/SDWebImage.h>
#import "RNSTableViewCell.h"
#import "RNSModelProtocol.h"


@interface RNSTemplateConvert ()
//模板对应的cell
@property(nonatomic, weak) RNSTableViewCell *cell;
//当前cell对应的模板名字
@property(nonatomic, strong)NSString *templateName;

@property(nonatomic, strong)NSMutableArray *subViewArray;
@end


@implementation RNSTemplateConvert

-(instancetype)initWithCell:(RNSTableViewCell *)cell{
  self = [super init];
  if (self) {
    self.cell = cell;
    self.subViewArray = @[].mutableCopy;
  }
  return self;
}

- (void)convertTemplateToView:(NSArray *)templates params:(NSArray *)params{
  if (self.templateName && [self.templateName isEqualToString:params[0]]) {//模板一样
    [templates enumerateObjectsUsingBlock:^(id<RNSModelProtocol>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
      [obj updateView:self.subViewArray[idx] content:((obj.contentIndex > 0) ? params[obj.contentIndex] : nil)];
    }];
    
  }else{
    self.templateName = params[0];
    [self.subViewArray enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
      [obj removeFromSuperview];
    }];
    [self.subViewArray removeAllObjects];
    
    [templates enumerateObjectsUsingBlock:^(id<RNSModelProtocol>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
      UIView *currentView = [obj getView:((obj.contentIndex > 0) ? params[obj.contentIndex] : nil)];
      [self.cell.contentView addSubview:currentView];
      [self.subViewArray addObject:currentView];
    }];
    
  }
  
}


//- (void)convertView:(NSDictionary *)viewConfig params:(nonnull NSArray *)params{
//  self.params = params;
//  if (self.convertModel == nil) {
//     self.convertModel = [RNSConvertModel yy_modelWithJSON:viewConfig];
//  }
//
//  NSMutableArray *stack = [NSMutableArray new];
//  [stack addObject:[[RNSConvertItem alloc] initWithItem:self.convertModel fatherView:self.rootView]];
//  while (stack.count > 0) {
//    RNSConvertItem *lastItem = [stack lastObject];
//    [stack removeLastObject];
//    UIView *currentView = [self createWithItem:lastItem];
//    NSArray * child = lastItem.item.child;
//    if ([child isKindOfClass:[NSArray class]] && child.count > 0) {
//      for (NSInteger i = (child.count - 1); i >= 0; i--) {
//        [stack addObject:[[RNSConvertItem alloc] initWithItem:child[i] fatherView:currentView]];
//      }
//    }
//  }
//}

//- (UIView *)createWithItem:(RNSConvertItem *)item{
//  RNSConvertModel *model = item.item;
//  UIView *fatherView = item.fatherView;
//  NSLog(@"----------%@",[model.tag stringValue]);
//  UIView *currentView;
//  if ([model.content.type isEqualToString:@"view"]) {
//    currentView = [[UIView alloc]init];
//  }else if([model.content.type isEqualToString:@"imageView"]){
//    currentView = [[UIImageView alloc]init];
//    [((UIImageView *)currentView) sd_setImageWithURL:[NSURL URLWithString:self.params[model.content.contentIndex]] placeholderImage:nil options:SDWebImageRefreshCached];
//  }else if([model.content.type isEqualToString:@"text"]){
//    currentView = [[UILabel alloc]init];
//    UILabel *placeLabel = currentView;
//    placeLabel.text = self.params[model.content.contentIndex];
//
//    Content *content = model.content;
//    if ([content.fontSize isKindOfClass:[NSNumber class]]) {
//      placeLabel.font = [UIFont systemFontOfSize:[content.fontSize integerValue]];
//    }
//    NSString *align = content.align;
//    if ([align isKindOfClass:[NSString class]]) {
//      if ([align isEqualToString:@"left"]) {
//        placeLabel.textAlignment = NSTextAlignmentLeft;
//      }else if ([align isEqualToString:@"right"]) {
//        placeLabel.textAlignment = NSTextAlignmentRight;
//      }
//    }
//
//  }else{
//    currentView = [[UIView alloc]init];
//  }
//  [fatherView addSubview:currentView];
//
//  if ([model.tag isKindOfClass:[NSNumber class]]) {
//    currentView.tag = [model.tag integerValue];
//  }
//
//  if ([model.bgColor isKindOfClass:[NSArray class]]) {
//    CGFloat red = [model.bgColor[0] floatValue];
//    CGFloat green = [model.bgColor[1] floatValue];
//    CGFloat blue = [model.bgColor[2] floatValue];
//    CGFloat alpha = [model.bgColor[3] floatValue];
//    currentView.backgroundColor = RGBColor(red,green,blue, alpha);
//  }
//
//  if (model.cornerRadius > 0) {
//    currentView.layer.cornerRadius = model.cornerRadius;
//  }
//
//
//  NSArray *rect = model.rect;
//  if ([rect isKindOfClass:[NSArray class]]) {
//    id top = rect[0];
//    id left = rect[1];
//    id bottom = rect[2];
//    id right = rect[3];
//
//    //顶部
//    if ([top isKindOfClass:[NSNumber class]]) {
//      CGFloat topFloat = [top floatValue];
//      [currentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(fatherView).offset(topFloat);
//      }];
//    }else if([top isKindOfClass:[NSDictionary class]]){
//      NSString *f = top[@"f"];
//      NSString *t = top[@"t"];
//      CGFloat offset = [top[@"o"] floatValue];
//      NSInteger rTag = [top[@"r"] unsignedIntegerValue];
//      UIView *rView = [self.cell.contentView viewWithTag:rTag];
//      [currentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        [self convertMasonryLayout:make f:f t:t rView:rView offset:offset];
//      }];
//    }
//    //左边
//    if ([left isKindOfClass:[NSNumber class]]) {
//      CGFloat leftFloat = [left floatValue];
//      [currentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(fatherView).offset(leftFloat);
//      }];
//    }else if([left isKindOfClass:[NSDictionary class]]){
//      NSString *f = left[@"f"];
//      NSString *t = left[@"t"];
//      CGFloat offset = [left[@"o"] floatValue];
//      NSInteger rTag = [left[@"r"] unsignedIntegerValue];
//      UIView *rView = [self.cell.contentView viewWithTag:rTag];
//      [currentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        [self convertMasonryLayout:make f:f t:t rView:rView offset:offset];
//      }];
//    }
//    //下边
//    if ([bottom isKindOfClass:[NSNumber class]]) {
//      CGFloat bottomFloat = [bottom floatValue];
//      [currentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(fatherView).offset(bottomFloat);
//      }];
//    }else if([bottom isKindOfClass:[NSDictionary class]]){
//      NSString *f = bottom[@"f"];
//      NSString *t = bottom[@"t"];
//      CGFloat offset = [bottom[@"o"] floatValue];
//      NSInteger rTag = [bottom[@"r"] unsignedIntegerValue];
//      UIView *rView = [self.cell.contentView viewWithTag:rTag];
//      [currentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        [self convertMasonryLayout:make f:f t:t rView:rView offset:offset];
//      }];
//    }
//    //右边
//    if ([right isKindOfClass:[NSNumber class]]) {
//      CGFloat rightFloat = [right floatValue];
//      [currentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(fatherView).offset(rightFloat);
//      }];
//    }else if([right isKindOfClass:[NSDictionary class]]){
//      NSString *f = right[@"f"];
//      NSString *t = right[@"t"];
//      CGFloat offset = [right[@"o"] floatValue];
//      NSInteger rTag = [right[@"r"] unsignedIntegerValue];
//      UIView *rView = [self.cell.contentView viewWithTag:rTag];
//      [currentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        [self convertMasonryLayout:make f:f t:t rView:rView offset:offset];
//      }];
//    }
//  }
//
//  NSArray *size = model.size;
//  if ([size isKindOfClass:[NSArray class]]) {
//    if ([size[0] isKindOfClass:[NSNumber class]]) {
//      CGFloat width = [size[0] floatValue];
//      [currentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(width);
//      }];
//    }
//    if ([size[1] isKindOfClass:[NSNumber class]]) {
//      CGFloat height = [size[1] floatValue];
//      [currentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(height);
//      }];
//    }
//  }
//
//  return currentView;
//}

- (void)convertMasonryLayout:(MASConstraintMaker *)make f:(NSString *)f t:(NSString *)t rView:(UIView *)rView offset:(CGFloat)offset{
  
  
  if ([f isEqualToString:@"left"] && [t isEqualToString:@"left"]) {
    make.left.equalTo(rView).offset(offset);
  }else if ([f isEqualToString:@"left"] && [t isEqualToString:@"right"]) {
    make.left.equalTo(rView.mas_right).offset(offset);
  }else if ([f isEqualToString:@"bottom"] && [t isEqualToString:@"bottom"]) {
    make.bottom.equalTo(rView).offset(offset);
  }else if ([f isEqualToString:@"bottom"] && [t isEqualToString:@"top"]) {
    make.bottom.equalTo(rView.mas_top).offset(offset);
  }else if ([f isEqualToString:@"right"] && [t isEqualToString:@"right"]) {
    make.right.equalTo(rView).offset(offset);
  }else if ([f isEqualToString:@"right"] && [t isEqualToString:@"left"]) {
    make.right.equalTo(rView.mas_left).offset(offset);
  }else if ([f isEqualToString:@"top"] && [t isEqualToString:@"top"]) {
    make.top.equalTo(rView).offset(offset);
  }else if ([f isEqualToString:@"top"] && [t isEqualToString:@"bottom"]) {
    make.top.equalTo(rView.mas_bottom).offset(offset);
  }
}

@end
