//
//  SHOPHomeCell.m
//  AndroidNativeCustomRefreshView
//
//  Created by huangchengdu on 2019/3/6.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "RNSHomeCell.h"
#import "Masonry/Masonry.h"


@interface RNSHomeCell ()

@property(nonatomic, strong)UILabel *titleLabel;

@end

@implementation RNSHomeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.contentView.backgroundColor = [UIColor greenColor];
    [self setupView];
    [self layoutViews];
  }
  return self;
}

- (void)setupView{
  self.titleLabel = [[UILabel alloc]init];
  [self.contentView addSubview:self.titleLabel];
}

- (void)layoutViews{
  [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.contentView).offset(10);
    make.top.equalTo(self.contentView).offset(10);
    make.bottom.equalTo(self.contentView);
  }];
}

-(void)setupCellWithParams:(NSDictionary *)params{
  NSString *title = [params valueForKey:@"title"];
  self.titleLabel.text = title;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
