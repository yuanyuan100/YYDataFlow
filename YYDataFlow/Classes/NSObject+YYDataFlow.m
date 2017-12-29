//
//  NSObject+YYDataFlow.m
//  YYDataFlow
//
//  Created by GWWL on 2017/12/29.
//

#import "NSObject+YYDataFlow.h"
#import "YYObserverAgent.h"
#import "YYObserveredAgent.h"
#import "NSObject+SJObserverHelper.h"

#import <objc/runtime.h>

static void *kYYDataFlowObserveredAgent = &kYYDataFlowObserveredAgent;

NS_ASSUME_NONNULL_BEGIN

@interface NSObject ()
/* 被观察者的代理 */
@property (nonatomic, strong, nullable) YYObserveredAgent *observeredAgent;
@end

@implementation NSObject (YYDataFlow)

- (void)yyObserveredKeyPath:(NSString *)keyPath changed:(nonnull YYDataFlowChanged)changed {
    // if 已经在观察列表中，则不需要重复观察，仅多一个回调即可
    // 但是需要记录 观察个数，在主动移除中，当同一个对象的观察个数为0则移除观察。
    
    [self.observeredAgent.callBlockArray addObject:changed];
    if (self.observeredAgent.count > 0) {
        // 不需要继续添加观察
        self.observeredAgent.count++;
    } else {
        self.observeredAgent.count = 1;
        self.observeredAgent.realObservered = self;
        [self sj_addObserver:YYObserverAgent.manager forKeyPath:keyPath];
    }
}

- (void)yyRemoveObserveredKeyPath:(NSString *)keyPath changed:(nonnull YYDataFlowChanged)changed {
    if (self.observeredAgent.count > 0) {
        self.observeredAgent.count--;
        [self.observeredAgent.callBlockArray removeObject:changed];
        if (self.observeredAgent.count == 0) {
            // 需要移除
            [self yyRemoveOperationObserveredKeyPath:keyPath];
        }
    } else {
        // 需要移除
        [self yyRemoveOperationObserveredKeyPath:keyPath];
    }
}

- (void)yyRemoveOperationObserveredKeyPath:(NSString *)keyPath {
    [YYObserverAgent.manager.observeredAgentSet removeObject:self.observeredAgent];
    self.observeredAgent = nil;
    [self removeObserver:YYObserverAgent.manager forKeyPath:keyPath];
}

#pragma mark - getter or setter
- (nullable YYObserveredAgent *)observeredAgent {
    id obj = objc_getAssociatedObject(self, kYYDataFlowObserveredAgent);
    if (obj == nil) {
        YYObserveredAgent *agent = [YYObserveredAgent new];
        agent.count = 0;
        [YYObserverAgent.manager.observeredAgentSet addObject:agent];
        self.observeredAgent = agent;
        
        obj = agent;
    }
    
    return obj;
}

- (void)setObserveredAgent:(nullable YYObserveredAgent *)observeredAgent {
    objc_setAssociatedObject(self, kYYDataFlowObserveredAgent, observeredAgent, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

NS_ASSUME_NONNULL_END

