//
//  YYDetailViewController.m
//  YYDataFlow_Example
//
//  Created by GWWL on 2017/12/31.
//  Copyright © 2017年 Yvan. All rights reserved.
//

#import "YYDetailViewController.h"

#import "Person.h"

#import <YYDataFlow/NSObject+YYDataFlow.h>

#define TEST_COUNT 40
static CGFloat t;

@interface YYDetailViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation YYDetailViewController

- (void)dealloc {
    NSLog(@"%zd - %s", __LINE__, __func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *methodNames = @[@"yytableViewOwer:"];
    [self performSelector:NSSelectorFromString(methodNames[self.index]) withObject:self afterDelay:0];
    [self performSelector:@selector(setupCloseUI) withObject:nil afterDelay:0];
}

#pragma mark - close
- (void)yyclose:(UIButton *)btn {
    [_timer invalidate];
    _timer = nil;
    t = 0;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - YYDetailViewController UI
- (void)yytableViewOwer:(UIViewController<UITableViewDelegate, UITableViewDataSource> *)ower {
    UITableView *tableView = [[UITableView alloc] initWithFrame:ower.view.frame style:UITableViewStylePlain];
    tableView.dataSource = ower;
    tableView.delegate = ower;
    [ower.view addSubview:tableView];
    
    self.dataSource = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < TEST_COUNT; i++) {
        Person *p = [Person new];
        [self.dataSource addObject:p];
    }
    
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(yychangeData:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)yychangeData:(NSTimer *)timer {
    t += timer.timeInterval;
    Person *p = self.dataSource[0];
    p.name = [NSString stringWithFormat:@"%f", t];
    p.age = -1;
    
    Person *p_30 = self.dataSource[29];
    p_30.name = [NSString stringWithFormat:@"%f", t - 29];
    p_30.age =  -30;
}

- (void)setupCloseUI {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor redColor]];
    [button setTitle:@"关闭" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(yyclose:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 80, 30);
    [self.view addSubview:button];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return TEST_COUNT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell__"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"cell__"];
    }
    cell.textLabel.text = [self.dataSource[indexPath.row] name];
    [cell.textLabel yyPassiveKeyPath:@"text" adjectiveObject:self.dataSource[indexPath.row] adjectiveKeyPath:@"name"];
    
    if ([self.dataSource[indexPath.row] age] != 0) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", (long)[self.dataSource[indexPath.row] age]];
    } else {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    }
    [cell.detailTextLabel yyPassiveKeyPath:@"text" adjectiveObject:self.dataSource[indexPath.row] adjectiveKeyPath:@"age" transformToString:YES];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
