//
//  SSPageControlManager.m
//  LearnCoreText
//
//  Created by loyinglin on 2018/10/25.
//  Copyright © 2018 loyinglin. All rights reserved.
//

#import "SSPageControllManager.h"
#import "SSLayoutManager.h"
#import "SSDataManager.h"


@interface SSPageControllManager ()

@property (nonatomic, strong) SSReadingContextData *readingContextData;

@property (nonatomic, strong) NSMutableDictionary *chapterDataDict; // chapterId => SSChapterData，章节数据

@property (nonatomic, strong) SSLayoutChapterData *curLayoutChapterData;

@property (nonatomic, strong) SSLayoutManager *layoutManager;

@property (nonatomic, strong) SSDataManager *dataManager;

@property (nonatomic, strong) SSConfigData *configData;
@end


@implementation SSPageControllManager

- (instancetype)initWithReadingContextData:(SSReadingContextData *)readingContextData configData:(nonnull SSConfigData *)configData {
    if (self = [super init]) {
        self.readingContextData = readingContextData;
        self.layoutManager = [[SSLayoutManager alloc] init];
        self.configData = configData;
        self.dataManager = [[SSDataManager alloc] init];
        self.chapterDataDict = [[NSMutableDictionary alloc] init];
        
        [self syncInitFirstPage];
        
    }
    return self;
}

- (void)syncInitFirstPage {
    SSChapterData *chapterData = [self.dataManager syncGetRemoteChatperDataWithBookId:self.readingContextData.bookId chapterId:self.readingContextData.chapterId];
    self.chapterDataDict[chapterData.chapterId] = chapterData;
    self.curLayoutChapterData = [self getLayoutChapterData:chapterData configData:self.configData];
}


/**
 新的页面出现，更新当前章节
 */
- (void)onNewPageDidAppear:(SSLayoutPageData *)layoutPageData {
    if (layoutPageData.chapterId == self.curLayoutChapterData.chapterData.chapterId) { // 新出现的仍是本章节
        
    }
    else {
        SSChapterData *chapterData = self.chapterDataDict[layoutPageData.chapterId]; // 本地应该数据，如果没有就算异常情况
        NSAssert(chapterData, @"emtpy data");
        self.curLayoutChapterData = [self getLayoutChapterData:chapterData configData:self.configData];
    }
    self.readingContextData.curPage = layoutPageData.pageIndex;
    self.readingContextData.chapterId = layoutPageData.chapterId;
    // 为了防止网络异常情况，可以继续请求下相邻章节的数据
    
    SSChapterData *chapterData = self.chapterDataDict[layoutPageData.chapterId]; // 本地应该数据，如果没有就算异常情况
    if (chapterData.lastChapterId) {
        [self loadChapterDataWithChapterId:chapterData.lastChapterId];
    }
    if (chapterData.nextChapterId) {
        [self loadChapterDataWithChapterId:chapterData.nextChapterId];
    }
}

- (SSLayoutPageData *)getNearPageDataWithIsNext:(BOOL)isNext {
    SSLayoutPageData *ret;
    NSInteger newIndex = isNext ? self.readingContextData.curPage + 1 : self.readingContextData.curPage - 1;
    if (newIndex < self.curLayoutChapterData.pagesArr.count) { // 本章节
        ret = [self.layoutManager getLayoutPageDataWithLayoutChapterData:self.curLayoutChapterData pageIndex:newIndex];
    }
    else {
        NSString *newChapterId = isNext ? self.curLayoutChapterData.chapterData.nextChapterId : self.curLayoutChapterData.chapterData.lastChapterId;
        if (newChapterId) {
            if ([self.chapterDataDict objectForKey:newChapterId]) {
                SSChapterData *newChapterData = [self.chapterDataDict objectForKey:newChapterId];
                SSLayoutChapterData *newLayoutChapterData = [self.layoutManager getLayoutChapterDataWithChapterData:newChapterData configData:self.configData pageSize:self.readingContextData.pageSize];
                newIndex = isNext ? 0 : newLayoutChapterData.pagesArr.count - 1;
                ret = [self.layoutManager getLayoutPageDataWithLayoutChapterData:newLayoutChapterData pageIndex:newIndex];
            }
            else {
                [self loadChapterDataWithChapterId:newChapterId];
            }
        }
        else {
            NSLog(@"reach end: %d", isNext);
        }
    }
    
    return ret;
}

- (SSLayoutPageData *)getCurrentPageData {
    SSLayoutPageData *ret;
    ret = [self.layoutManager getLayoutPageDataWithLayoutChapterData:self.curLayoutChapterData pageIndex:self.readingContextData.curPage];
    return ret;
}


- (SSLayoutChapterData *)getLayoutChapterData:(SSChapterData *)chapterData configData:(SSConfigData *)configData {
    return [self.layoutManager getLayoutChapterDataWithChapterData:chapterData configData:configData pageSize:self.readingContextData.pageSize];
}


- (void)loadChapterDataWithChapterId:(NSString *)chapterId {
    if (![self.chapterDataDict objectForKey:chapterId]) {
        [self.dataManager asyncGetRemoteChatperDataWithBookId:self.readingContextData.bookId chapterId:chapterId
                                                     callback:^(SSChapterData *chapterData) {
                                                         if (chapterData && chapterData.chapterId) {
                                                             self.chapterDataDict[chapterData.chapterId] = chapterId;
                                                         }
                                                     }];
    }
}


@end
