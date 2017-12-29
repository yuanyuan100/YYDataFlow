//
//  YYViewController.m
//  YYDataFlow
//
//  Created by Yvan on 12/29/2017.
//  Copyright (c) 2017 Yvan. All rights reserved.
//

#import "YYViewController.h"
#import <YYDataFlow/NSObject+YYDataFlow.h>
#import "Person.h"

@interface YYViewController ()

@end

@implementation YYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    Person *person = [Person new];
    person.name = @"pyy1";
    [person yyObserveredKeyPath:@"name" changed:^(id  _Nonnull newData, id  _Nonnull oldData) {
        
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        person.name = @"pyy2";
    });
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
