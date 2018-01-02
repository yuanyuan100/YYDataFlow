//
//  YYSameKeyPath.m
//  YYDataFlow
//
//  Created by GitHub:yuanyuan100 on 2017/12/30.
//

#import "YYSameKeyPath.h"
#import "YYObserverAgent.h"

@interface YYSameKeyPath ()
@property (nonatomic, strong) NSMutableArray *callBlockArray;
@end

@implementation YYSameKeyPath
- (void)dealloc {
    NSLog(@"%zd - %s", __LINE__, __func__);
    if (_count > 0) {
        // 默认观察者YYObserverAgent.manager 单利不会dealloc
        // 若YYObserverAgent.manager先释放，则会发生没有释放观察者的情况
        // 由于上述的原因可能隐藏崩溃，但是正常情况下几乎不可能发生，暂时不处理
        [_master removeObserver:YYObserverAgent.manager forKeyPath:_keyPath];
    }
}

- (NSMutableArray *)callBlockArray {
    if (_callBlockArray == nil) {
        _callBlockArray = [[NSMutableArray alloc] init];
    }
    return _callBlockArray;
}
@end
