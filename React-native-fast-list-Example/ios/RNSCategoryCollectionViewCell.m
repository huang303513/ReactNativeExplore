//
//  RNSCategoryCollectionViewCell.m
//  AndroidNativeCustomRefreshView
//
//  Created by huangchengdu on 2019/3/8.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "RNSCategoryCollectionViewCell.h"
#import <RNSFastList/RNSCellProtocol.h>
#import "Masonry/Masonry.h"
#import "SHOPConstant.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface RNSCategoryCollectionViewCell ()<RNSCellProtocol>

@property(nonatomic, strong)UIView *placeView;
@property(nonatomic, strong)UIImageView *iconImageView;
@property(nonatomic, strong)UIImageView *videoImageView;
@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UIImageView *couponImageView;
@property(nonatomic, strong)UILabel *couponLabel;
@property(nonatomic, strong)UILabel *discountPriceLabel;
@property(nonatomic, strong)UILabel *originPriceLabel;
@property(nonatomic, strong)UILabel *awardLabel;
@property(nonatomic, strong)UILabel *soldCountLabel;

@property(nonatomic, assign)BOOL isCurrentVersionOnline;
@end

@implementation RNSCategoryCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    [self setupView];
    [self layoutViews];
  }
  return self;
}

- (void)setupView{
  self.placeView = [UIView new];
  self.placeView.backgroundColor = [UIColor whiteColor];
  [self.contentView addSubview:self.placeView];
  
  self.iconImageView = [UIImageView new];
  self.iconImageView.contentMode = UIViewContentModeScaleToFill;
  [self.placeView addSubview:self.iconImageView];
  
  self.videoImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ic_video.png"]];
  self.videoImageView.hidden = YES;
  [self.iconImageView addSubview:self.videoImageView];
  
  self.titleLabel = [[UILabel alloc]init];
  self.titleLabel.numberOfLines = 2;
  self.titleLabel.lineBreakMode=UILineBreakModeCharacterWrap;
  [self.placeView addSubview:self.titleLabel];
  
  
  self.couponImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"quan-icon-red"]];
  [self.placeView addSubview:self.couponImageView];
  
  self.couponLabel = [RNSCategoryCollectionViewCell configLabelWithFont:[UIFont boldSystemFontOfSize:12] color:[UIColor whiteColor] textAlign:NSTextAlignmentLeft];
  self.couponLabel.numberOfLines = 1;
  [self.couponImageView addSubview:self.couponLabel];
  
  
  self.discountPriceLabel = [RNSCategoryCollectionViewCell configLabelWithFont:[UIFont boldSystemFontOfSize:16] color:[UIColor colorWithRed:212/255.0 green:41/255.0 blue:47/255.0 alpha:1.0] textAlign:NSTextAlignmentLeft];
  [self.placeView addSubview:self.discountPriceLabel];
  
  self.originPriceLabel = [RNSCategoryCollectionViewCell configLabelWithFont:[UIFont systemFontOfSize:12] color:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] textAlign:NSTextAlignmentLeft];
  [self.placeView addSubview:self.originPriceLabel];
  
  self.awardLabel = [RNSCategoryCollectionViewCell configLabelWithFont:[UIFont systemFontOfSize:12] color:[UIColor colorWithRed:242/255.0 green:97/255.0 blue:97/255.0 alpha:1.0] textAlign:NSTextAlignmentRight];
  [self.placeView addSubview:self.awardLabel];
  
  self.soldCountLabel = [RNSCategoryCollectionViewCell configLabelWithFont:[UIFont systemFontOfSize:11] color:[UIColor colorWithRed:159/255.0 green:159/255.0 blue:159/255.0 alpha:1.0] textAlign:NSTextAlignmentRight];;
  [self.placeView addSubview:self.soldCountLabel];
}

+ (UILabel *)configLabelWithFont:(UIFont *)font color:(UIColor *)color textAlign:(NSTextAlignment)textAlign{
  UILabel *label = [[UILabel alloc]init];
  label.font = font;
  label.textColor = color;
  label.textAlignment =textAlign;
  return label;
}

- (void)layoutViews{
  CGFloat defaultPadding = 5;
  [self.placeView mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self.contentView);
  }];
  
  [self.iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.top.right.equalTo(self.placeView);
    make.height.equalTo(self.placeView.mas_width);
  }];
  
  [self.videoImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.bottom.right.equalTo(self.iconImageView).offset(-defaultPadding);
  }];
  
  [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.placeView).offset(defaultPadding);
    make.right.equalTo(self.placeView).offset(-defaultPadding);
    make.top.equalTo(self.iconImageView.mas_bottom).offset(defaultPadding);
    make.height.equalTo(@36);
  }];
  
  [self.couponImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.placeView).offset(defaultPadding);
    make.top.equalTo(self.titleLabel.mas_bottom).offset(defaultPadding);
    make.width.equalTo(@68);
    make.height.equalTo(@18);
  }];
  
  [self.couponLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(self.couponImageView);
  }];
  
  [self.discountPriceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.placeView).offset(defaultPadding);
    make.top.equalTo(self.couponImageView.mas_bottom).offset(15);
  }];
  [self.originPriceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.placeView).offset(defaultPadding);
    make.bottom.equalTo(self.placeView).offset(-defaultPadding);
    make.top.equalTo(self.discountPriceLabel.mas_bottom).offset(5);
  }];
  
  
  [self.awardLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self.placeView).offset(-defaultPadding);
    make.centerY.equalTo(self.discountPriceLabel);
  }];
  [self.soldCountLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self.placeView).offset(-defaultPadding);
    make.centerY.equalTo(self.originPriceLabel);
  }];
}

-(void)setupCellWithParams:(NSDictionary *)params isCurrentVersionOnline:(BOOL)isCurrentVersionOnline{
  _isCurrentVersionOnline = isCurrentVersionOnline;
  
   NSInteger shopType = [[params valueForKey:@"shopType"] integerValue];
  
  NSString *title = [params valueForKey:@"title"];
  NSString *imageUrl = [params valueForKey:@"imageUrl"];
  NSString *video = [params valueForKey:@"video"];
  //折扣价
  NSString *finalPrice = [params valueForKey:@"finalPrice"];
  //原价
  NSString *price = [params valueForKey:@"price"];
  switch (shopType) {
    case 1:
      price = [NSString stringWithFormat:@"淘宝价￥%@",price];
      break;
    case 2:
      price = [NSString stringWithFormat:@"天猫价￥%@",price];
      break;
    case 3:
      price = [NSString stringWithFormat:@"拼多多价￥%@",price];
      break;
    default:
      price = [NSString stringWithFormat:@"淘宝价￥%@",price];
      break;
  }
  //奖励
  NSString *buy_bonus = [params valueForKey:@"buy_bonus"];
  //销量
  NSString *volume = [params valueForKey:@"volume"];
  if ([volume integerValue] != 0) {
    volume = [NSString stringWithFormat:@"月销%@",volume];
  }else{
    volume = @"正在抢购";
  }
  
  NSDictionary *coupon = [params valueForKey:@"coupon"];
  CGFloat discount = [[params valueForKey:@"discount"] floatValue];
  
  UIImage *image = [UIImage imageNamed:@"tb-icon.png"];
  if (shopType == 2) {
    image = [UIImage imageNamed:@"tm-icon"];
  }
  NSTextAttachment *textAttach = [[NSTextAttachment alloc]init];
  textAttach.image = image;
  textAttach.bounds = CGRectMake(0, 0, 14, 14);
  NSAttributedString * strA =[NSAttributedString attributedStringWithAttachment:textAttach];
  // 创建一个富文本
  NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
  [paragraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
  NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@",title] attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 12],NSForegroundColorAttributeName: [UIColor colorWithRed:32/255.0 green:32/255.0 blue:32/255.0 alpha:1.0]}];
  [attri insertAttributedString:strA atIndex:0];
  [attri addAttribute:NSParagraphStyleAttributeName
                        value:paragraphStyle
                        range:NSMakeRange(0,[attri length])];

  
  
  BOOL isShowDisCountTag = false;
  NSString *discountTag;
  NSString *couponString;
  if (coupon && [coupon[@"price"] floatValue] > 0) {
    discountTag = @"券后";
    isShowDisCountTag = true;
    couponString = [NSString stringWithFormat:@"%.0f元券",[coupon[@"price"] floatValue]];
  } else if (discount && discount > 0) {
    discountTag = @"折后";
    isShowDisCountTag = true;
    couponString = [NSString stringWithFormat:@"%.1f折",discount];
  }
  
  [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"ic-place-white.png"]];
  if (video && video.length > 0) {
    self.videoImageView.hidden = NO;
  }else{
    self.videoImageView.hidden = YES;
  }
  
  self.titleLabel.attributedText = attri;
  
  if (isShowDisCountTag) {
    self.couponImageView.hidden = NO;
    self.couponLabel.text = couponString;
  }else{
    self.couponImageView.hidden = YES;
  }
  
  self.discountPriceLabel.text = [NSString stringWithFormat:@"%@￥%@",discountTag,finalPrice];
  
  
  self.originPriceLabel.text = price;
  
  
  if (self.isCurrentVersionOnline && buy_bonus && ([buy_bonus floatValue] > 0)) {
    self.awardLabel.text = [NSString stringWithFormat:@"奖￥%@",buy_bonus];
    self.awardLabel.hidden = NO;
  }else{
    self.awardLabel.hidden = YES;
  }
  
  self.soldCountLabel.text = volume;
  
}


@end
