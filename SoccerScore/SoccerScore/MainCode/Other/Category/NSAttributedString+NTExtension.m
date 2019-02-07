//
//  NSAttributedString+NTExtension.m
//  ChairConcept
//
//  Created by Neo on 2018/1/17.
//  Copyright © 2018年 Neo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSAttributedString+NTExtension.h"

@implementation NSAttributedString (NTExtension)

// 1. 由文本生成attributedString
+ (NSAttributedString *)attributedStringWithText:(NSString *)text textColor:(UIColor *)color textFont:(UIFont *)font hasUnderlineStyle:(BOOL)hasUnderLineStyle lineSpacing:(float)line paragraphSpacing:(float)paragraph {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    NSRange range = NSMakeRange(0, text.length);
    [paragraphStyle setLineSpacing:line];
    [paragraphStyle setParagraphSpacing:paragraph];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:range];
    [attributedString addAttribute:NSFontAttributeName value:font range:range];

    if (hasUnderLineStyle) {
        [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range];
    }

    return attributedString;
}

// 2. 由图片生成attributedString
+ (NSAttributedString *)attributedStringWithImage:(UIImage *)image imageBounds:(CGRect)bounds {
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = image;
    textAttachment.bounds = CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height);
    NSAttributedString *attachmentAttributedString = [NSAttributedString attributedStringWithAttachment:textAttachment];

    return attachmentAttributedString;
}

// 3. 多个AttributedString拼接成一个resultAttributedString
+ (NSAttributedString *)jointAttributedStringWithItems:(NSArray *)items {
    NSMutableAttributedString *resultAttributedString = [[NSMutableAttributedString alloc] init];

    for (int i = 0; i < items.count; i++) {
        if ([items[i] isKindOfClass:[NSAttributedString class]]) {
            [resultAttributedString appendAttributedString:items[i]];
        }
    }

    return resultAttributedString;
}
@end
