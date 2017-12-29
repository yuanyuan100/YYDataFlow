//
//  YYObserveredAgent.m
//  YYDataFlow
//
//  Created by GWWL on 2017/12/29.
//

#import "YYObserveredAgent.h"

@interface YYObserveredAgent ()
@property (nonatomic, strong) NSMutableArray *callBlockArray;
@end

@implementation YYObserveredAgent
- (void)dealloc {
    NSLog(@"%zd - %s", __LINE__, __func__);
}

#pragma mark - getter
- (NSMutableArray *)callBlockArray {
    if (_callBlockArray == nil) {
        _callBlockArray = [[NSMutableArray alloc] init];
    }
    return _callBlockArray;
}

@end
