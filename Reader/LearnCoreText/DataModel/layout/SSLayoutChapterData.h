//
//  SSLayoutChapterData.h
//  LearnCoreText
//
//  Created by loyinglin on 2018/10/24.
//  Copyright © 2018 loyinglin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SSChapterData.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSLayoutChapterData : NSObject

@property (nonatomic, strong) SSChapterData *chapterData; // real data

@property (nonatomic, strong) NSArray<NSValue *> *pagesArr; // 分页后的页面数组

@property (nonatomic, strong) NSAttributedString *attrStr; // 章节富文本

@property (nonatomic, assign) CGSize pageSize;

- (instancetype)initWithChapterData:(SSChapterData *)chapterData pagesArray:(NSArray<NSValue *> *)pagesArr attrStr:(NSAttributedString *)attrStr pageSize:(CGSize)pageSize;

@end

NS_ASSUME_NONNULL_END
