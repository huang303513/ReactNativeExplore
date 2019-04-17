//
//  SHOPHomeCell.m
//  AndroidNativeCustomRefreshView
//
//  Created by huangchengdu on 2019/3/6.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "RNSHomeCell.h"
#import "Masonry/Masonry.h"
//#import <RNSFastList/RNSCellProtocol.h>
#import "ios/RNSCellProtocol.h"
#import "SHOPConstant.h"
#import <SDWebImage/UIImageView+WebCache.h>

static CGFloat zeroWidth = 64;
static CGFloat zeroHeight = 26;
static CGFloat defaultPadding = 8;

@interface RNSHomeCell ()<RNSCellProtocol>

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
@property(nonatomic, strong)UIView *zeroView;
@property(nonatomic, strong)UILabel *zeroLabel;
@property(nonatomic, strong)UILabel *hotTitleLabel;
@property(nonatomic, strong)UIButton *nowGrabButton;

@property(nonatomic, assign)BOOL isCurrentVersionOnline;
@property(nonatomic, assign)BOOL showFreeBuy;
@end

@implementation RNSHomeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
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
  self.placeView.layer.cornerRadius = 5.0f;
  [self.contentView addSubview:self.placeView];
  
  self.iconImageView = [UIImageView new];
  self.iconImageView.contentMode = UIViewContentModeScaleToFill;
  [self.placeView addSubview:self.iconImageView];
  
  self.videoImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ic_video.png"]];
  self.videoImageView.hidden = YES;
  [self.iconImageView addSubview:self.videoImageView];
  
  self.zeroView = [[UIView alloc]initWithFrame:CGRectMake(0, 7, zeroWidth, zeroHeight)];
  self.zeroView.backgroundColor = [UIColor clearColor];
  [self.iconImageView addSubview:self.zeroView];
  
//  /**
//   *  1.通过CAGradientLayer 设置渐变的背景。
//   */
  CAGradientLayer *layer = [CAGradientLayer new];
  //colors存放渐变的颜色的数组
  layer.colors=@[(__bridge id)[UIColor colorWithRed:246/255.0 green:53/255.0 blue:38/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:245/255.0 green:99/255.0 blue:35/255.0 alpha:1.0].CGColor];
  /**
   * 起点和终点表示的坐标系位置，(0,0)表示左上角，(1,1)表示右下角
   */
  layer.startPoint = CGPointMake(0.5, 0);
  layer.endPoint = CGPointMake(0.5, 1);
  layer.frame = self.zeroView.bounds;
  [self.zeroView.layer addSublayer:layer];
  UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.zeroView.bounds byRoundingCorners:UIRectCornerBottomRight | UIRectCornerTopRight cornerRadii:CGSizeMake(15, 15)];
  CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
  maskLayer.frame = self.zeroView.bounds;
  maskLayer.path = maskPath.CGPath;
  layer.mask = maskLayer;
  
  self.zeroLabel = [RNSHomeCell configLabelWithFont:[UIFont boldSystemFontOfSize:14] color:[UIColor whiteColor] textAlign:NSTextAlignmentCenter];
  self.zeroLabel.numberOfLines = 1;
  self.zeroLabel.text = @"0元购";
  [self.zeroView addSubview:self.zeroLabel];
  
  self.titleLabel = [[UILabel alloc]init];
  self.titleLabel.numberOfLines = 2;
  self.titleLabel.lineBreakMode=UILineBreakModeCharacterWrap;
  [self.placeView addSubview:self.titleLabel];
  
  self.hotTitleLabel = [RNSHomeCell configLabelWithFont:[UIFont boldSystemFontOfSize:12] color:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] textAlign:NSTextAlignmentLeft];
  self.hotTitleLabel.numberOfLines = 1;
  [self.placeView addSubview:self.hotTitleLabel];
  
  
  self.couponImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"quan-icon-red"]];
  [self.placeView addSubview:self.couponImageView];
  
  self.couponLabel = [RNSHomeCell configLabelWithFont:[UIFont systemFontOfSize:12] color:[UIColor whiteColor] textAlign:NSTextAlignmentLeft];
  self.couponLabel.numberOfLines = 1;
  [self.couponImageView addSubview:self.couponLabel];
  
  
  self.discountPriceLabel = [RNSHomeCell configLabelWithFont:[UIFont boldSystemFontOfSize:16] color:[UIColor colorWithRed:212/255.0 green:41/255.0 blue:47/255.0 alpha:1.0] textAlign:NSTextAlignmentLeft];
  [self.placeView addSubview:self.discountPriceLabel];
  
  self.originPriceLabel = [RNSHomeCell configLabelWithFont:[UIFont systemFontOfSize:12] color:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] textAlign:NSTextAlignmentLeft];
  [self.placeView addSubview:self.originPriceLabel];
  
  self.awardLabel = [RNSHomeCell configLabelWithFont:[UIFont systemFontOfSize:12] color:[UIColor colorWithRed:242/255.0 green:97/255.0 blue:97/255.0 alpha:1.0] textAlign:NSTextAlignmentRight];
  [self.placeView addSubview:self.awardLabel];
  
  self.nowGrabButton = [[UIButton alloc]init];
  self.nowGrabButton.userInteractionEnabled = NO;
  self.nowGrabButton.backgroundColor = [UIColor colorWithRed:246/255.0 green:53/255.0 blue:38/255.0 alpha:1.0];
  [self.nowGrabButton setTitle:@"马上抢 >" forState:UIControlStateNormal];
  [self.nowGrabButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  self.nowGrabButton.layer.cornerRadius = 12.5;
  self.nowGrabButton.titleLabel.font = [UIFont systemFontOfSize:14];
//  [self.nowGrabButton addTarget:self action:@selector(clickZeroButton:) forControlEvents:UIControlEventTouchUpInside];
  [self.placeView addSubview:self.nowGrabButton];
  
  self.soldCountLabel = [RNSHomeCell configLabelWithFont:[UIFont systemFontOfSize:11] color:[UIColor colorWithRed:159/255.0 green:159/255.0 blue:159/255.0 alpha:1.0] textAlign:NSTextAlignmentRight];;
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
  [self.placeView mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 5.0, 5.0, 5.0));
  }];
  
  [self.iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.top.equalTo(self.placeView).offset(defaultPadding);
    make.bottom.equalTo(self.placeView).offset(-defaultPadding);
    make.height.width.mas_equalTo(128);
  }];
  
  [self.videoImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.bottom.right.equalTo(self.iconImageView).offset(-defaultPadding);
  }];
  
  [self.zeroLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(self.zeroView);
  }];
  
  [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.iconImageView.mas_right).offset(defaultPadding);
    make.top.equalTo(self.placeView).offset(defaultPadding);
    make.right.equalTo(self.placeView).offset(-defaultPadding);
  }];
  
  [self.hotTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.titleLabel);
    make.top.equalTo(self.titleLabel.mas_bottom);
  }];
  
  [self.couponImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.titleLabel);
    make.top.equalTo(self.hotTitleLabel.mas_bottom).offset(defaultPadding);
    make.width.equalTo(@68);
    make.height.equalTo(@18);
  }];
  
  [self.couponLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(self.couponImageView);
  }];
  
  [self.originPriceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.iconImageView.mas_right).offset(defaultPadding);
    make.bottom.equalTo(self.placeView).offset(-defaultPadding);
    make.right.equalTo(self.placeView).offset(-100);
  }];
  
  [self.discountPriceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.originPriceLabel);
    make.bottom.equalTo(self.originPriceLabel.mas_top).offset(-defaultPadding);
    make.right.equalTo(self.originPriceLabel);
  }];
  
  [self.soldCountLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self.placeView).offset(-defaultPadding);
    make.bottom.equalTo(self.placeView).offset(-defaultPadding);
    make.width.mas_equalTo(80);
  }];
  
  [self.awardLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self.soldCountLabel);
    make.bottom.equalTo(self.soldCountLabel.mas_top).offset(-defaultPadding);
    make.width.mas_equalTo(80);
  }];
  
  [self.nowGrabButton mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self.soldCountLabel);
    make.bottom.equalTo(self.soldCountLabel.mas_top).offset(-defaultPadding);
    make.height.equalTo(@25);
    make.width.equalTo(@76);
  }];
}

-(void)setupCellWithParams:(NSDictionary *)params isCurrentVersionOnline:(BOOL)isCurrentVersionOnline showFreeBuy:(BOOL)showFreeBuy{
  _isCurrentVersionOnline = isCurrentVersionOnline;
  _showFreeBuy = showFreeBuy;
  
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
  NSString *discountTag = @"价格";
  NSString *couponString;
  if (coupon && [coupon[@"price"] floatValue] > 0) {
    discountTag = @"券后";
    isShowDisCountTag = true;
    couponString = [NSString stringWithFormat:@"%.0f元隐藏券",[coupon[@"price"] floatValue]];
  } else if (discount && discount > 0) {
    discountTag = @"折后";
    isShowDisCountTag = true;
    couponString = [NSString stringWithFormat:@"%.1f折",discount];
  }
  
  //0 元购
  BOOL freeBuy = [[params valueForKey:@"freeBuy"] boolValue];
  BOOL shouldShowFreeBuy = self.showFreeBuy && freeBuy;
  if (shouldShowFreeBuy) {
    finalPrice = @"0";
  }
  
  //hotTitle
  NSString *hotTitle = [params valueForKey:@"hotTitle"];
  
  
  [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"ic-place-white.png"]];
  if (video && video.length > 0) {
    self.videoImageView.hidden = NO;
  }else{
    self.videoImageView.hidden = YES;
  }
  if (shouldShowFreeBuy) {
    self.zeroView.hidden = NO;
    
  }else{
    self.zeroView.hidden = YES;
  }
  
  self.titleLabel.attributedText = attri;
  
  if (hotTitle && hotTitle.length > 0) {
    if (self.hotTitleLabel.isHidden) {
      [self.couponImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hotTitleLabel.mas_bottom).offset(defaultPadding);
      }];
    }
    self.hotTitleLabel.hidden = NO;
    self.hotTitleLabel.text = hotTitle;
  }else{
    if (!self.hotTitleLabel.isHidden) {
      [self.couponImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(defaultPadding);
      }];
    }
    self.hotTitleLabel.hidden = YES;
  }
  
  if (isShowDisCountTag) {
    self.couponImageView.hidden = NO;
    self.couponLabel.text = couponString;
  }else{
    self.couponImageView.hidden = YES;
  }
  
  self.discountPriceLabel.text = [NSString stringWithFormat:@"%@￥%@",discountTag,finalPrice];
  
  
  self.originPriceLabel.text = price;
  
  
  if (shouldShowFreeBuy) {
    self.awardLabel.hidden = YES;
    self.nowGrabButton.hidden = NO;
  }else{
    self.nowGrabButton.hidden = YES;
    if (self.isCurrentVersionOnline && buy_bonus && ([buy_bonus floatValue] > 0)) {
      self.awardLabel.text = [NSString stringWithFormat:@"奖￥%@",buy_bonus];
      self.awardLabel.hidden = NO;
    }else{
      self.awardLabel.hidden = YES;
    }
  }
  self.soldCountLabel.text = volume;
}


//- (void)clickZeroButton:(UIButton *)sender{
//  if (self.zeroBuyBlock) {
//    self.zeroBuyBlock();
//  }
//}

@end
