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

@property (nonatomic, strong) NSString *chapterId; // 章节id（对应章节目录）

@property (nonatomic, strong) NSString *chapterName; // 章节名

@property (nonatomic, strong) NSDictionary *paragraphDict; // 段落数据，nsrange

@property (nonatomic, strong) NSString *strContent; // 章节内容

@property (nonatomic, strong) NSString *lastChapterId; // 上一章节的id

@property (nonatomic, strong) NSString *nextChapterId; // 下一章节的id

@end

NS_ASSUME_NONNULL_END
