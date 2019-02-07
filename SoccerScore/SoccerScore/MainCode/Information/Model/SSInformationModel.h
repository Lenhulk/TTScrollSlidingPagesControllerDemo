//
//  SSInformationModel.h
//  SoccerScore
//
//  Created by 大雄 on 2018/6/27.
//  Copyright © 2018年 大雄. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSInformationModel : NSObject
/// 更新时间
@property (nonatomic, copy) NSString *lmodify;
/// 文章编号
@property (nonatomic, copy) NSString *docid;
/// 文章标题
@property (nonatomic, copy) NSString *title;
/// 文章图片
@property (nonatomic, copy) NSString *imgsrc;
/// 文章简介（删除“网易”，可用来判断是否存在 筛除图片新闻、广告、直播等其他内容）
@property (nonatomic, copy) NSString *digest;
/// 特殊内容（图片新闻，专题等，筛掉）
@property (nonatomic, copy) NSString *skipType;

@end
