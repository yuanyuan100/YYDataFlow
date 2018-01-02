//
//  YYObserverAgent.m
//  YYDataFlow
//
//  Created by GitHub:yuanyuan100 on 2017/12/29.
//

#import "YYObserverAgent.h"
#import "YYSameKeyPath.h"

#import "NSObject+YYDataFlow.h"

@interface NSObject ()
@property (nonatomic, strong, readonly) NSMutableSet<YYSameKeyPath *> *yyKeyPathSet;
@end

static YYObserverAgent *__manager;

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
    
    for (YYSameKeyPath *same in [object yyKeyPathSet]) {
        if ([same.keyPath isEqualToString:keyPath]) {
            for (YYDataFlowChanged b in same.callBlockArray) {
                b(change[@"new"], change[@"old"]);
            }
        }
    }
    
}
@end
