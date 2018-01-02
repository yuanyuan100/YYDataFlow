# YYDataFlow

[![CI Status](http://img.shields.io/travis/Yvan/YYDataFlow.svg?style=flat)](https://travis-ci.org/Yvan/YYDataFlow)
[![Version](https://img.shields.io/cocoapods/v/YYDataFlow.svg?style=flat)](http://cocoapods.org/pods/YYDataFlow)
[![License](https://img.shields.io/cocoapods/l/YYDataFlow.svg?style=flat)](http://cocoapods.org/pods/YYDataFlow)
[![Platform](https://img.shields.io/cocoapods/p/YYDataFlow.svg?style=flat)](http://cocoapods.org/pods/YYDataFlow)

## introduce

正在开发的App为金融类型，后台频繁快速推送数据，UI界面需要及时响应。为了解决频繁reload UITableView等空间，解决办法是某个数据发生变化，仅刷新相应的独立UI元素（如，UILable，UIButton）。

利用单例作为观察者，所以大大简化了代码。利用对象必须先释放属性的特性，解决了频繁移除观察者的代码量，因此不再需要过分关注释放观察者的问题。默认单例不会释放，若意外释放，App将Crash。

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```objc
cell.textLabel.text = [self.dataSource[indexPath.row] name];
[cell.textLabel yyPassiveKeyPath:@"text" adjectiveObject:self.dataSource[indexPath.row] adjectiveKeyPath:@"name"];
```
## Requirements

```ruby
s.ios.deployment_target = '8.0'
```

## Installation

YYDataFlow is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'YYDataFlow'
```

## Author

Yvan, yuanyuan_pyy@163.com

## License

YYDataFlow is available under the MIT license. See the LICENSE file for more info.
