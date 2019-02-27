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

#define firstPage (0)

NS_ASSUME_NONNULL_BEGIN


@protocol SSPageControllDelegate <NSObject>

@required


@optional

- (void)onDataReadyWithChapterId:(NSString *)chapterId;

@end


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
 更新阅读进度，预加载相邻章节
 */
- (void)onNewPageDidAppear:(SSPageControllData *)layoutPageData;


/**
 返回初始化章节第一个页面的数据，有数据则直接显示；否则显示loading；
 */
- (SSPageControllData *)getFirstPageControllData;

/**
 获取相邻页面的内容

 @param isNext YES表示获取下一页，NO表示获取上一页；
 @return 页面排版数据，为空表示还没数据
 */
- (SSPageControllData *)getNearPageDataWithIsNext:(BOOL)isNext;

// todo 同步初始化，后期可以改成callback，在初始化h完毕后回调，期间可以由UI层显示loading；
- (void)syncInitFirstPage;

@end

NS_ASSUME_NONNULL_END
