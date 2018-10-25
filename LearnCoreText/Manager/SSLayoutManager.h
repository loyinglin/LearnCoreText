//
//  SSLayoutManager.h
//  LearnCoreText
//
//  Created by loyinglin on 2018/10/24.
//  Copyright © 2018 loyinglin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import "SSConfigData.h"
#import "SSLayoutPageData.h"
#import "SSlayoutChapterData.h"

NS_ASSUME_NONNULL_BEGIN


@interface SSLayoutManager : NSObject

- (SSLayoutChapterData *)getLayoutChapterDataWithChapterData:(SSChapterData *)chapterData configData:(SSConfigData *)configData pageSize:(CGSize)pageSize;

- (SSLayoutPageData *)getPageDataWithLayoutChapterData:(SSLayoutChapterData *)layoutChapterData pageIndex:(NSUInteger)pageIndex;



@end

NS_ASSUME_NONNULL_END
