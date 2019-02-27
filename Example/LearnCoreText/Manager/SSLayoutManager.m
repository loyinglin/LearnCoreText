//
//  SSLayoutManager.m
//  LearnCoreText
//
//  Created by loyinglin on 2018/10/24.
//  Copyright © 2018 loyinglin. All rights reserved.
//

#import "SSLayoutManager.h"

@implementation SSLayoutManager


- (SSLayoutChapterData *)getLayoutChapterDataWithChapterData:(SSChapterData *)chapterData configData:(SSConfigData *)configData pageSize:(CGSize)pageSize {
    /**
     1、传入章节内容和格式数据，输出富文本；
     2、传入富文本和页面大小，传出分页范围数组；
     3、传入分页内容、页数、富文本，传出当页数据；
     */
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] init];
    [attrStr appendAttributedString:[self getTitleAttributeStrWithStr:[NSString stringWithFormat:@"\n第%@章 保护起来\n", chapterData.chapterId] configData:configData]];
    [attrStr appendAttributedString:[self getAttributeStrWithStr:chapterData.strContent configData:configData]];
    NSArray *pagesArr = [self getPagesArrtWithAttributeStr:attrStr pageSize:pageSize];
    SSLayoutChapterData *layoutChapterData = [[SSLayoutChapterData alloc] initWithChapterData:chapterData pagesArray:pagesArr attrStr:attrStr pageSize:pageSize];
    return layoutChapterData;
}

/**
 计算富文本在特定size的分页情况
 @param attributeStr 富文本
 @param pageSize 页面大小
 @return NSValue，里面放着每页的NSRange
 */
- (NSArray<NSValue *> *)getPagesArrtWithAttributeStr:(NSMutableAttributedString *)attributeStr pageSize:(CGSize)pageSize {
    NSMutableArray<NSValue *> *resultRange = [NSMutableArray array]; // 返回结果数组
    CGRect rect = CGRectMake(0, 0, pageSize.width, pageSize.height); // 每页的显示区域大小
    NSUInteger curIndex = 0; // 分页起点，初始为第0个字符
    while (curIndex < attributeStr.length) { // 没有超过最后的字符串，表明至少剩余一个字符
        NSUInteger maxLength = MIN(1000, attributeStr.length - curIndex); // 1000为最小字体的每页最大数量，减少计算量
        NSAttributedString * subString = [attributeStr attributedSubstringFromRange:NSMakeRange(curIndex, maxLength)]; // 截取字符串
        
        if (curIndex > 0 && [attributeStr.string characterAtIndex:curIndex - 1] != '\n') {
            NSMutableParagraphStyle *style = [attributeStr attribute:NSParagraphStyleAttributeName atIndex:curIndex effectiveRange:NULL];
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.firstLineHeadIndent = 0; // 跨页的逻辑处理太过复杂， 用换行的空格来替代
            //    paragraphStyle.headIndent = 5;
            paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
            paragraphStyle.lineSpacing = style.lineSpacing;
            paragraphStyle.paragraphSpacing = style.paragraphSpacing;
            paragraphStyle.alignment = NSTextAlignmentJustified;
            [attributeStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(curIndex, 1)];
        }
        
        
        CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef) subString); // 根据富文本创建排版类CTFramesetterRef
        UIBezierPath * bezierPath = [UIBezierPath bezierPathWithRect:rect];
        CTFrameRef frameRef = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), bezierPath.CGPath, NULL); // 创建排版数据，第个参数的range.length=0表示放字符直到区域填满
        CFRange visiableRange = CTFrameGetVisibleStringRange(frameRef); // 获取当前可见的字符串区域
        NSRange realRange = {curIndex, visiableRange.length}; // 当页在原始字符串中的区域
        [resultRange addObject:[NSValue valueWithRange:realRange]]; // 记录当页结果
        curIndex += realRange.length; //增加索引
        CFRelease(frameRef);
        CFRelease(frameSetter);
    };
    return resultRange;
}

- (NSAttributedString *)getTitleAttributeStrWithStr:(NSString *)contentStr configData:(SSConfigData *)configData {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[NSFontAttributeName] = configData.titleFont;
    dict[NSForegroundColorAttributeName] = configData.textColor;
    dict[NSKernAttributeName] = @(configData.character);
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.lineSpacing = configData.line;
    paragraphStyle.paragraphSpacingBefore = configData.paragraph;
    paragraphStyle.paragraphSpacing = configData.paragraph;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    dict[NSParagraphStyleAttributeName] = paragraphStyle;
    
    NSAttributedString *ret = [[NSAttributedString alloc] initWithString:contentStr
                                                              attributes:dict];
    return ret;
}

- (NSAttributedString *)getAttributeStrWithStr:(NSString *)contentStr configData:(SSConfigData *)configData {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    if (configData.font) {
        dict[NSFontAttributeName] = configData.font;
    }
    if (configData.textColor) {
        dict[NSForegroundColorAttributeName] = configData.textColor;
    }
    dict[NSKernAttributeName] = @(configData.character);
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    paragraphStyle.firstLineHeadIndent = [configData.font pointSize] * 2; // 跨页的逻辑处理太过复杂， 用换行的空格来替代
//    paragraphStyle.headIndent = 5;
    
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.lineSpacing = configData.line;
    
    paragraphStyle.paragraphSpacing = configData.paragraph;
    paragraphStyle.alignment = NSTextAlignmentJustified;
    dict[NSParagraphStyleAttributeName] = paragraphStyle;

    NSAttributedString *ret = [[NSAttributedString alloc] initWithString:contentStr
                                                              attributes:dict];
    return ret;
}

- (SSLayoutPageData *)getLayoutPageDataWithLayoutChapterData:(SSLayoutChapterData *)layoutChapterData pageIndex:(NSUInteger)pageIndex {
    NSAssert(pageIndex < layoutChapterData.pagesArr.count, @"out range pageIndex");
    NSRange pageRange = [(NSValue *)[layoutChapterData.pagesArr objectAtIndex:pageIndex] rangeValue];
    NSAttributedString * subString = [layoutChapterData.attrStr attributedSubstringFromRange:pageRange]; // 截取字符串
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef) subString); // 根据富文本创建排版类CTFramesetterRef
    UIBezierPath * bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, layoutChapterData.pageSize.width, layoutChapterData.pageSize.height)];
    CTFrameRef frameRef = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), bezierPath.CGPath, NULL); // 创建排版数据，第个参数的range.length=0表示放字符直到区域填满
    CFRelease(frameSetter);
    
    SSLayoutPageData *pageData = [[SSLayoutPageData alloc] initWithCTFrame:frameRef range:pageRange attributeStr:subString];
    [pageData addChapterInfoWithChapterId:layoutChapterData.chapterData.chapterId chapterTitle:layoutChapterData.chapterData.chapterTitle pageCount:layoutChapterData.pagesArr.count pageIndex:pageIndex];
    return pageData;
}

// apple demo
- (void)calculateLineWithView:(UIView *)view {
    double width; CGContextRef context; CGPoint textPosition; CFMutableAttributedStringRef attrString;
    // Initialize those variables.
    width = 100;
    context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, 0, view.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    textPosition = CGPointMake(0, 0);
    //        attrString = (__bridge CFAttributedStringRef)[[NSAttributedString alloc] initWithString:@"textPosition; CFAttributedStringRef attrString;// Initialize those variables."];
    
    // Initialize a string.
    CFStringRef textString = CFSTR("Hello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shine.");
    
    // Create a mutable attributed string with a max length of 0.
    // The max length is a hint as to how much internal storage to reserve.
    // 0 means no hint.
    attrString = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0);
    CFAttributedStringReplaceString (attrString, CFRangeMake(0, 0),
                                     textString);
    
    // Create a typesetter using the attributed string.
    CTTypesetterRef typesetter = CTTypesetterCreateWithAttributedString(attrString);
    
    // Find a break for line from the beginning of the string to the given width.
    CFIndex start = 0;
    CFIndex count = CTTypesetterSuggestLineBreak(typesetter, start, width);
    
    // Use the returned character count (to the break) to create the line.
    CTLineRef line = CTTypesetterCreateLine(typesetter, CFRangeMake(start, count));
    
    // Get the offset needed to center the line.
    float flush = 0.5; // centered
    double penOffset = CTLineGetPenOffsetForFlush(line, flush, width);
    
    // Move the given text drawing position by the calculated offset and draw the line.
    CGContextSetTextPosition(context, textPosition.x + penOffset, textPosition.y);
    CTLineDraw(line, context);
    
    // Move the index beyond the line break.
    start += count;
}


@end
