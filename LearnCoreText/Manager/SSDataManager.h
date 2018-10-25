//
//  SSDataManager.h
//  LearnCoreText
//
//  Created by loyinglin on 2018/10/24.
//  Copyright © 2018 loyinglin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSChapterData.h"

typedef void(^SSDataCallback)(SSChapterData *chapterData);

NS_ASSUME_NONNULL_BEGIN

@interface SSDataManager : NSObject

- (SSChapterData *)syncGetRemoteChatperDataWithBookId:(NSString *)bookId chapterId:(NSString *)chapterId;

- (void)asyncGetRemoteChatperDataWithBookId:(NSString *)bookId chapterId:(NSString *)chapterId callback:(SSDataCallback)callback;

@end

NS_ASSUME_NONNULL_END
