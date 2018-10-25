//
//  SSChapterData.h
//  LearnCoreText
//
//  Created by loyinglin on 2018/10/24.
//  Copyright © 2018 loyinglin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSChapterData : NSObject

@property (strong, nonatomic) NSString *chapterId; // 章节id（对应章节目录）

@property (strong, nonatomic) NSString *chapterName; // 章节名

@property (strong, nonatomic) NSString *strContent; // 章节内容

@property (strong, nonatomic) NSString *lastChapterId; // 上一章节的id

@property (strong, nonatomic) NSString *nextChapterId; // 下一章节的id

@end

NS_ASSUME_NONNULL_END
