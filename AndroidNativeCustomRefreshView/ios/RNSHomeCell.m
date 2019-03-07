//
//  SHOPHomeCell.m
//  AndroidNativeCustomRefreshView
//
//  Created by huangchengdu on 2019/3/6.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "RNSHomeCell.h"
#import "Masonry/Masonry.h"
#import "SHOPConstant.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface RNSHomeCell ()

@property(nonatomic, strong)UIView *placeView;
@property(nonatomic, strong)UIImageView *iconImageView;
@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UILabel *discountPriceLabel;
@property(nonatomic, strong)UILabel *originPriceLabel;
@property(nonatomic, strong)UILabel *awardLabel;
@property(nonatomic, strong)UILabel *soldCountLabel;


@end

@implementation RNSHomeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.contentView.backgroundColor = RGBColorHex(0x999999);
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
  [self.placeView addSubview:self.iconImageView];
  
  self.titleLabel = [RNSHomeCell configLabelWithFont:[UIFont boldSystemFontOfSize:14] color:[UIColor blackColor] textAlign:NSTextAlignmentLeft];
  [self.placeView addSubview:self.titleLabel];
  
  self.discountPriceLabel = [RNSHomeCell configLabelWithFont:[UIFont boldSystemFontOfSize:14] color:[UIColor redColor] textAlign:NSTextAlignmentLeft];
  [self.placeView addSubview:self.discountPriceLabel];
  
  self.originPriceLabel = [RNSHomeCell configLabelWithFont:[UIFont systemFontOfSize:12] color:RGBColorHex(0x333333) textAlign:NSTextAlignmentLeft];
  [self.placeView addSubview:self.originPriceLabel];
  
  self.awardLabel = [RNSHomeCell configLabelWithFont:[UIFont systemFontOfSize:12] color:[UIColor redColor] textAlign:NSTextAlignmentLeft];
  [self.placeView addSubview:self.awardLabel];
  
  self.soldCountLabel = [RNSHomeCell configLabelWithFont:[UIFont systemFontOfSize:12] color:RGBColorHex(0x333333) textAlign:NSTextAlignmentLeft];;
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
  CGFloat defaultTitlePadding = 8;
  [self.placeView mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 5.0, 5.0, 5.0));
  }];
  
  [self.iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.top.equalTo(self.placeView).offset(defaultPadding);
    make.bottom.equalTo(self.placeView).offset(-defaultPadding);
    make.height.width.mas_equalTo(80);
  }];
  
  [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.iconImageView.mas_right).offset(defaultTitlePadding);
    make.top.equalTo(self.placeView).offset(defaultPadding);
    make.right.equalTo(self.placeView).offset(-defaultPadding);
  }];
  
  [self.originPriceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.iconImageView.mas_right).offset(defaultTitlePadding);
    make.bottom.equalTo(self.placeView).offset(-defaultPadding);
    make.right.equalTo(self.placeView).offset(-100);
  }];
  
  [self.discountPriceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.originPriceLabel);
    make.bottom.equalTo(self.originPriceLabel.mas_top).offset(-defaultPadding);
    make.right.equalTo(self.originPriceLabel);
  }];
  
  [self.soldCountLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self.placeView).offset(-defaultTitlePadding);
    make.bottom.equalTo(self.placeView).offset(-defaultPadding);
    make.width.mas_equalTo(80);
  }];
  
  [self.awardLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self.soldCountLabel);
    make.bottom.equalTo(self.soldCountLabel.mas_top).offset(-defaultPadding);
    make.width.mas_equalTo(80);
  }];
}

-(void)setupCellWithParams:(NSDictionary *)params{
  NSString *title = [params valueForKey:@"title"];
  NSString *imageUrl = [params valueForKey:@"imageUrl"];
  //折扣价
  NSString *finalPrice = [params valueForKey:@"finalPrice"];
  //原价
  NSString *price = [params valueForKey:@"price"];
  //奖励
  NSString *buy_bonus = [params valueForKey:@"buy_bonus"];
  //销量
  NSInteger volume = [params valueForKey:@"volume"];
  
  [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
  self.titleLabel.text = title;
  self.discountPriceLabel.text = [NSString stringWithFormat:@"券后￥%@",finalPrice];
  self.originPriceLabel.text = [NSString stringWithFormat:@"淘宝价￥%@",price];
  self.awardLabel.text = [NSString stringWithFormat:@"奖￥%@",buy_bonus];
  self.soldCountLabel.text = [NSString stringWithFormat:@"越小%d",volume];

}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
  [super setHighlighted:NO animated:NO];
}




@end
