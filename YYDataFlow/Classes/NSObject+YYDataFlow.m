//
//  NSObject+YYDataFlow.m
//  YYDataFlow
//
//  Created by GWWL on 2017/12/29.
//

#import "NSObject+YYDataFlow.h"
#import "YYObserverAgent.h"
#import "NSObject+SJObserverHelper.h"

#import <objc/runtime.h>

static void *kYYDataFlowYYCount = &kYYDataFlowYYCount;
static void *kYYDataFlowyyCallBlockArray = &kYYDataFlowyyCallBlockArray;

NS_ASSUME_NONNULL_BEGIN

@interface NSObject ()
/* 计数 */
@property (nonatomic, strong) NSNumber *yyCount;
/* 存放回调 */
@property (nonatomic, strong) NSMutableArray *yyCallBlockArray;
@end

@implementation NSObject (YYDataFlow)

- (void)yyObserveredKeyPath:(NSString *)keyPath changed:(nonnull YYDataFlowChanged)changed {
    // if 已经在观察列表中，则不需要重复观察，仅多一个回调即可
    // 但是需要记录 观察个数，在主动移除中，当同一个对象的观察个数为0则移除观察。
    
    [self.yyCallBlockArray addObject:changed];
    if (self.yyCount.integerValue > 0) {
        // 不需要继续添加观察
        self.yyCount = @(self.yyCount.integerValue + 1);
    } else {
        self.yyCount = @(1);
        [self sj_addObserver:YYObserverAgent.manager forKeyPath:keyPath];
    }
}

- (void)yyRemoveObserveredKeyPath:(NSString *)keyPath changed:(nonnull YYDataFlowChanged)changed {
    if (self.yyCount.integerValue > 0) {
        self.yyCount = @(self.yyCount.integerValue - 1);
        [self.yyCallBlockArray removeObject:changed];
        if (self.yyCount.integerValue == 0) {
            // 需要移除
            [self yyRemoveOperationObserveredKeyPath:keyPath];
        }
    } else {
        // 需要移除
        [self yyRemoveOperationObserveredKeyPath:keyPath];
    }
}

- (void)yyRemoveOperationObserveredKeyPath:(NSString *)keyPath {
    [self removeObserver:YYObserverAgent.manager forKeyPath:keyPath];
}

#pragma mark - getter or setter
- (NSNumber *)yyCount {
    id count = objc_getAssociatedObject(self, kYYDataFlowYYCount);
    if (count == nil) {
        return @(0);
    }
    return count;
}

- (void)setYyCount:(NSNumber *)yyCount {
    objc_setAssociatedObject(self, kYYDataFlowYYCount, yyCount, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)yyCallBlockArray {
    id mutableArray = objc_getAssociatedObject(self, kYYDataFlowyyCallBlockArray);
    if (mutableArray == nil) {
        mutableArray = [[NSMutableArray alloc] init];
        self.yyCallBlockArray = mutableArray;
    }
    return mutableArray;
}

- (void)setYyCallBlockArray:(NSMutableArray *)yyCallBlockArray {
    objc_setAssociatedObject(self, kYYDataFlowyyCallBlockArray, yyCallBlockArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

NS_ASSUME_NONNULL_END

