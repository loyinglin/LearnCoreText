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
@property (nonatomic, assign) NSUInteger pageIndex;

@property (nonatomic, assign) CTFrameRef frameRef; // 当前页面的排版结果
NS_ASSUME_NONNULL_BEGIN
@property (nonatomic, assign) NSRange range; // current string in chapter
@property (nonatomic, strong) NSAttributedString *attrStr; // content
NS_ASSUME_NONNULL_END

- (instancetype)initWithCTFrame:(CTFrameRef)frameRef range:(NSRange)range attributeStr:(NSAttributedString *)attrStr;

@end

