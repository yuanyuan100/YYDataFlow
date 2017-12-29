//
//  YYObserverAgent.m
//  YYDataFlow
//
//  Created by GWWL on 2017/12/29.
//

#import "YYObserverAgent.h"
#import "NSObject+YYDataFlow.h"

@interface NSObject ()
/* 存放回调 */
@property (nonatomic, strong, readonly) NSMutableArray *yyCallBlockArray;
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
    for (YYDataFlowChanged b in [object yyCallBlockArray]) {
        b(change[@"new"], change[@"old"]);
    }
}
@end
