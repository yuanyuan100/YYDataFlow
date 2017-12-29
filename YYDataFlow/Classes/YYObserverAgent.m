//
//  YYObserverAgent.m
//  YYDataFlow
//
//  Created by GWWL on 2017/12/29.
//

#import "YYObserverAgent.h"
#import "YYObserveredAgent.h"
#import "NSObject+YYDataFlow.h"

@interface NSObject ()
/* 被观察者的代理 */
@property (nonatomic, strong, nullable) YYObserveredAgent *observeredAgent;
@end

static YYObserverAgent *__manager;

@interface YYObserverAgent ()
@property (nonatomic, strong) NSMutableSet<YYObserveredAgent *> *observeredAgentSet;
@end

@implementation YYObserverAgent

+ (instancetype)manager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (__manager == nil) {
            __manager = [[self alloc] init];
        }
    });
    return __manager;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSMutableArray *array = [object observeredAgent].callBlockArray;
    for (YYDataFlowChanged b in array) {
        b(change[@"new"], change[@"old"]);
    }
}

- (void)yyRemoveYYObserveredAgentOfSet:(NSObject *)object {
    [self.observeredAgentSet removeObject:object.observeredAgent];
}

#pragma mark - getter
- (NSMutableSet<YYObserveredAgent *> *)observeredAgentSet {
    if (_observeredAgentSet == nil) {
        _observeredAgentSet = [[NSMutableSet alloc] init];
    }
    return _observeredAgentSet;
}
@end
