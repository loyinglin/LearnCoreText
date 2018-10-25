//
//  SSPageControlManager.h
//  LearnCoreText
//
//  Created by loyinglin on 2018/10/25.
//  Copyright © 2018 loyinglin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSReadingContextData.h"
#import "SSLayoutChapterData.h"
#import "SSLayoutPageData.h"
#import "SSChapterData.h"
#import "SSConfigData.h"

NS_ASSUME_NONNULL_BEGIN


/**
 分页控制器，持有阅读器中所有章节数据
 
 
  * 进入新章节后，默认请求相邻章节的数据；
  * 处理上/下一页的逻辑：
 1、判断目标页是否在当前章节，是则直接返回，否则进2；
 2、请求相邻章节的本地缓存数据，如果存在，则进行排版分页，返回首页/末页数据；
 3、不存在返回当前页数据，并请求数据；
 
 */
@interface SSPageControllManager : NSObject


- (instancetype)initWithReadingContextData:(SSReadingContextData *)readingContextData configData:(SSConfigData *)configData;

/**
 进入新的页面阅读
 */
- (void)onNewPageDidAppear:(SSLayoutPageData *)layoutPageData;

/**
 获取当前页面的内容
 */
- (SSLayoutPageData *)getCurrentPageData;

//获取相邻页面的内容，isNext=YES表示获取下一页，NO表示获取上一页
- (SSLayoutPageData *)getNearPageDataWithIsNext:(BOOL)isNext;

@end

NS_ASSUME_NONNULL_END
