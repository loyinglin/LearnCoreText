//
//  SSDataManager.h
//  LearnCoreText
//
//  Created by loyinglin on 2018/10/24.
//  Copyright © 2018 loyinglin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSChapterData.h"
#import "SSReadingContextData.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSDataManager : NSObject

- (SSChapterData *)getRemoteChatperDataWithId:(SSReadingContextData *)readingContextData;

@end

NS_ASSUME_NONNULL_END
