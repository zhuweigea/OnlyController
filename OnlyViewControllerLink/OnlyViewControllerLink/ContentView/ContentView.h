//
//  ContentView.h
//  OnlyViewControllerLink
//
//  Created by 朱伟阁 on 2019/7/19.
//  Copyright © 2019 朱伟阁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ContentView : UIView<UITableViewDelegate,UITableViewDataSource>{
    NSString *_contentType;
    ViewController *_self;
}

@property(nonatomic, strong) UITableView *tv;
@property(nonatomic, strong) NSMutableArray *dataSource;
@property(assign,nonatomic)int currentPageIndex;

- (instancetype)initWithFrame:(CGRect)frame contentType:(NSString*)contentType selfVc:(ViewController *)selfVc;

@end

NS_ASSUME_NONNULL_END
