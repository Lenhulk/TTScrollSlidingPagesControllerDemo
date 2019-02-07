//
//  NSAttributedString+NTExtension.h
//  ChairConcept
//
//  Created by Neo on 2018/1/17.
//  Copyright © 2018年 Neo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (NTExtension)

// 1. 由文本生成attributedString
+ (NSAttributedString *)attributedStringWithText:(NSString *)text textColor:(UIColor *)color textFont:(UIFont *)font hasUnderlineStyle:(BOOL)hasUnderLineStyle lineSpacing:(float)line paragraphSpacing:(float)paragraph;

// 2. 由图片生成attributedString
+ (NSAttributedString *)attributedStringWithImage:(UIImage *)image imageBounds:(CGRect)bounds;

// 3. 多个AttributedString拼接成一个resultAttributedString
+ (NSAttributedString *)jointAttributedStringWithItems:(NSArray *)items;

@end
