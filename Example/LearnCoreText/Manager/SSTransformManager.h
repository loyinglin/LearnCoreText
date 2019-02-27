//
//  SSTransformManager.h
//  LearnCoreText
//
//  Created by loyinglin on 2018/10/24.
//  Copyright © 2018 loyinglin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface SSTransformManager : NSObject

/**
 *  富文本转html字符串
 */
- (NSString *)attributeStrConvertToHtmlStr:(NSAttributedString *)attributeStr;


/**
 *  html字符串转富文本
 */
- (NSAttributedString *)htmlStrConvertToAttributeStr:(NSString *)htmlStr;


@end

NS_ASSUME_NONNULL_END
