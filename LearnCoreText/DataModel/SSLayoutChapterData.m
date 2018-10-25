//
//  SSLayoutChapterData.m
//  LearnCoreText
//
//  Created by loyinglin on 2018/10/24.
//  Copyright © 2018 loyinglin. All rights reserved.
//

#import "SSLayoutChapterData.h"

@implementation SSLayoutChapterData

- (instancetype)initWithChapterData:(SSChapterData *)chapterData pagesArray:(NSArray<NSValue *> *)pagesArr attrStr:(NSAttributedString *)attrStr pageSize:(CGSize)pageSize {
    self = [super init];
    if (self) {
        self.chapterData = chapterData;
        self.pagesArr = pagesArr;
        self.attrStr = attrStr;
        self.pageSize = pageSize;
    }
    return self;
}

@end
