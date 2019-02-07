//
//  SSInformationListCell.m
//  SoccerScore
//
//  Created by 大雄 on 2018/6/27.
//  Copyright © 2018年 大雄. All rights reserved.
//

#import "SSInformationListCell.h"
#import "SSInformationModel.h"
#import <UIImageView+WebCache.h>

@interface SSInformationListCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *contentLb;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@end

@implementation SSInformationListCell

- (void)setModel:(SSInformationModel *)model{
    
    _model = model;
    _titleLb.text = model.title;
    _contentLb.text = model.digest;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
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
