#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "NSObject+YYDataFlow.h"
#import "NSObject+YYPassiveObject.h"
#import "YYObserverAgent.h"
#import "YYPassiveKeyPath.h"
#import "YYSameKeyPath.h"

FOUNDATION_EXPORT double YYDataFlowVersionNumber;
FOUNDATION_EXPORT const unsigned char YYDataFlowVersionString[];

