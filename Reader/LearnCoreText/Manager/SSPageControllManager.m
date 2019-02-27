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

@property (nonatomic, strong) NSMutableDictionary<NSString *, SSChapterData *> *chapterDataDict; // chapterId => SSChapterData，章节数据

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


- (void)onNewPageDidAppear:(SSPageControllData *)pageControllData {
    // reset loading
    self.readingContextData.pageControllData = pageControllData;
    
    switch (pageControllData.pageControllType) {
        case SSPageControllTypeNormal:
        {
            SSLayoutPageData *layoutPageData = pageControllData.layoutPageData;
            if (layoutPageData.chapterId != self.curLayoutChapterData.chapterData.chapterId) { // 新出现章节
                SSChapterData *chapterData = self.chapterDataDict[layoutPageData.chapterId]; // 本地应该有数据，如果没有就算异常情况
                NSAssert(chapterData, @"emtpy data");
                self.curLayoutChapterData = [self getLayoutChapterData:chapterData configData:self.configData];
            }
            [[NSUserDefaults standardUserDefaults] setObject:@(layoutPageData.pageIndex) forKey:KEY_READ_PAGE]; // 缓存
            [[NSUserDefaults standardUserDefaults] synchronize];
            
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
            break;
        }
        case SSPageControllTypeLoading:
        {
            break;
        }
        case SSPageControllTypePay:
        {
            break;
        }
            
        default:
            break;
    }
}

- (SSPageControllData *)getNearPageDataWithIsNext:(BOOL)isNext {
    SSPageControllData *ret;
    
    switch (self.readingContextData.pageControllData.pageControllType) {
        case SSPageControllTypeNormal:
        {
            NSInteger newIndex = isNext ? self.readingContextData.curPage + 1 : self.readingContextData.curPage - 1;
            if (newIndex < self.curLayoutChapterData.pagesArr.count) { // 本章节
                ret = [[SSPageControllData alloc] initWithType:SSPageControllTypeNormal];
                ret.layoutPageData = [self.layoutManager getLayoutPageDataWithLayoutChapterData:self.curLayoutChapterData pageIndex:newIndex];
            }
            else {
                NSString *newChapterId = isNext ? self.curLayoutChapterData.chapterData.nextChapterId : self.curLayoutChapterData.chapterData.lastChapterId;
                if (newChapterId) {
                    if ([self.chapterDataDict objectForKey:newChapterId]) {
                        SSChapterData *newChapterData = [self.chapterDataDict objectForKey:newChapterId];
                        SSLayoutChapterData *newLayoutChapterData = [self.layoutManager getLayoutChapterDataWithChapterData:newChapterData configData:self.configData pageSize:self.readingContextData.pageSize];
                        newIndex = isNext ? 0 : newLayoutChapterData.pagesArr.count - 1;
                        
                        ret = [[SSPageControllData alloc] initWithType:SSPageControllTypeNormal];
                        ret.layoutPageData = [self.layoutManager getLayoutPageDataWithLayoutChapterData:newLayoutChapterData pageIndex:newIndex];
                    }
                    else {
                        ret = [[SSPageControllData alloc] initWithType:SSPageControllTypeLoading];
                        ret.loadingChapterId = newChapterId;
                    }
                }
            }
            break;
        }
        case SSPageControllTypeLoading:
        {
            if (isNext) {
                ret = nil; // no next when loading
            }
            else {
                ret = [[SSPageControllData alloc] initWithType:SSPageControllTypeNormal];
                ret.layoutPageData = [self getLayoutPageDataWithIndex:self.readingContextData.curPage];
            }
            break;
        }
        case SSPageControllTypePay:
        {
            break;
        }
            
        default:
            break;
    }
    
    
    return ret;
}

- (SSPageControllData *)getFirstPageControllData {
    SSPageControllData *ret;
    if ([self isChapterDataReady]) {
        ret = [[SSPageControllData alloc] initWithType:SSPageControllTypeNormal];
        ret.layoutPageData = [self getLayoutPageDataWithIndex:firstPage];
    }
    else {
        ret = [[SSPageControllData alloc] initWithType:SSPageControllTypeLoading];
        ret.loadingChapterId = self.readingContextData.chapterId;
    }
    return ret;
}

- (BOOL)isChapterDataReady {
    return [self.chapterDataDict objectForKey:self.readingContextData.chapterId];
}

- (SSLayoutPageData *)getLayoutPageDataWithIndex:(NSUInteger)pageIndex {
    SSLayoutPageData *ret;
    ret = [self.layoutManager getLayoutPageDataWithLayoutChapterData:self.curLayoutChapterData pageIndex:pageIndex];
    return ret;
}


- (SSLayoutChapterData *)getLayoutChapterData:(SSChapterData *)chapterData configData:(SSConfigData *)configData {
    return [self.layoutManager getLayoutChapterDataWithChapterData:chapterData configData:configData pageSize:self.readingContextData.pageSize];
}


- (void)loadChapterDataWithChapterId:(NSString *)chapterId {
    if (![self.chapterDataDict objectForKey:chapterId]) {
        [self.dataManager asyncGetRemoteChatperDataWithBookId:self.readingContextData.bookId chapterId:chapterId
                                                     callback:^(SSChapterData *chapterData) {
                                                         NSAssert(chapterData && chapterData.chapterId && chapterData.strContent, @"loadChapterDataWithChapterId chapterData is null");
                                                         if (!chapterData.chapterTitle) {
                                                             NSLog(@"loadChapterDataWithChapterId title is null, but is not fatel");
                                                         }
                                                         if (chapterData && chapterData.chapterId) {
                                                             self.chapterDataDict[chapterData.chapterId] = chapterData;
                                                         }
                                                     }];
    }
}


@end
