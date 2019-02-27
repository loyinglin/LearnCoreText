//
//  SSPageData.h
//  LearnCoreText
//
//  Created by loyinglin on 2018/10/24.
//  Copyright © 2018 loyinglin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>



@interface SSLayoutPageData : NSObject

@property (nonatomic, strong) NSString *chapterId;
@property (nonatomic, strong) NSString *chapterTitle;
@property (nonatomic, assign) NSUInteger pageCount;
@property (nonatomic, assign) NSUInteger pageIndex;

@property (nonatomic, assign) CTFrameRef frameRef; // 当前页面的排版结果
NS_ASSUME_NONNULL_BEGIN
@property (nonatomic, assign) NSRange range; // current string in chapter
@property (nonatomic, strong) NSAttributedString *attrStr; // content
NS_ASSUME_NONNULL_END


/**
 初始化的接口，传入必须的数据

 @param frameRef 排版结果
 @param range 区域
 @param attrStr 富文本
 @return 页面数据
 */
- (instancetype)initWithCTFrame:(CTFrameRef)frameRef range:(NSRange)range attributeStr:(NSAttributedString *)attrStr;

- (void)addChapterInfoWithChapterId:(NSString *)chapterId chapterTitle:(NSString *)chapterTitle pageCount:(NSUInteger)pageCount pageIndex:(NSUInteger)pageIndex;

@end

