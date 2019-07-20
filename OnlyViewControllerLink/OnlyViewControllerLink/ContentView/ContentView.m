//
//  ContentView.m
//  OnlyViewControllerLink
//
//  Created by 朱伟阁 on 2019/7/19.
//  Copyright © 2019 朱伟阁. All rights reserved.
//

#import "ContentView.h"
#import "OneCell.h"
#import "TwoCell.h"
#import "ThreeCell.h"
#import "FourCell.h"
#import "FiveCell.h"
#import "SixCell.h"
#import "SevenCell.h"
#import "EightCell.h"
#import "NineCell.h"
#import "TenCell.h"
#import "ElevenCell.h"

@interface ContentView (){
    NSInteger _page;
}
@end

@implementation ContentView

- (instancetype)initWithFrame:(CGRect)frame contentType:(NSString *)contentType selfVc:(ViewController *)selfVc{
    self = [super initWithFrame:frame];
    if(self){
        _self=selfVc;
        _contentType=contentType;
        _currentPageIndex=1;
        _dataSource=[[NSMutableArray alloc] initWithCapacity:0];
        _tv=[[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tv.delegate=self;
        _tv.dataSource=self;
        _tv.separatorColor=[UIColor clearColor];
        _tv.backgroundColor=UICOLOR_RANDOM;
        [self addSubview:_tv];
        if([_contentType isEqualToString:@"0"]){
            [_tv registerClass:[OneCell class] forCellReuseIdentifier:NSStringFromClass([OneCell class])];
        }else if ([_contentType isEqualToString:@"10"]){
            [_tv registerClass:[TwoCell class] forCellReuseIdentifier:NSStringFromClass([TwoCell class])];
        }else if ([_contentType isEqualToString:@"20"]){
            [_tv registerClass:[ThreeCell class] forCellReuseIdentifier:NSStringFromClass([ThreeCell class])];
        }else if ([_contentType isEqualToString:@"30"]){
            [_tv registerClass:[FourCell class] forCellReuseIdentifier:NSStringFromClass([FourCell class])];
        }else if ([_contentType isEqualToString:@"40"]){
            [_tv registerClass:[FiveCell class] forCellReuseIdentifier:NSStringFromClass([FiveCell class])];
        }else if ([_contentType isEqualToString:@"50"]){
            [_tv registerClass:[SixCell class] forCellReuseIdentifier:NSStringFromClass([SixCell class])];
        }else if ([_contentType isEqualToString:@"60"]){
            [_tv registerClass:[SevenCell class] forCellReuseIdentifier:NSStringFromClass([SevenCell class])];
        }else if ([_contentType isEqualToString:@"70"]){
            [_tv registerClass:[EightCell class] forCellReuseIdentifier:NSStringFromClass([EightCell class])];
        }else if ([_contentType isEqualToString:@"80"]){
            [_tv registerClass:[NineCell class] forCellReuseIdentifier:NSStringFromClass([NineCell class])];
        }else if ([_contentType isEqualToString:@"90"]){
            [_tv registerClass:[TenCell class] forCellReuseIdentifier:NSStringFromClass([TenCell class])];
        }else if ([_contentType isEqualToString:@"100"]){
            [_tv registerClass:[ElevenCell class] forCellReuseIdentifier:NSStringFromClass([ElevenCell class])];
        }
        [self tableViewHeaderRefresh];
        [self tableViewFooterRefresh];
        //暂时没用上 监听回调刷新数据可以加上
        //[[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(backLast) name:@"ReloadProdctData" object:nil];
    }
    return self;
}
-(void)backLast{
    [self.tv.mj_header beginRefreshing];
}
- (void)tableViewHeaderRefresh {
    __weak __typeof(self) weakSelf = self;
    self.tv.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.currentPageIndex=1;
        //请求网络数据
        [weakSelf requestData];
    }];
}
- (void)requestData{
    [self.tv.mj_header endRefreshing];
    [self.tv.mj_footer endRefreshingWithNoMoreData];
}
- (void)tableViewFooterRefresh {
    __weak __typeof(self) weakSelf = self;
    self.tv.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.currentPageIndex ++;
        //请求网络数据
        [weakSelf requestData];
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([_contentType isEqualToString:@"0"]){
        OneCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OneCell class])];
        return cell;
    }else if ([_contentType isEqualToString:@"10"]){
        TwoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TwoCell class])];
        return cell;
    }else if ([_contentType isEqualToString:@"20"]){
        ThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ThreeCell class])];
        return cell;
    }else if ([_contentType isEqualToString:@"30"]){
        FourCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FourCell class])];
        return cell;
    }else if ([_contentType isEqualToString:@"40"]){
        FiveCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FiveCell class])];
        return cell;
    }else if ([_contentType isEqualToString:@"50"]){
        SixCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SixCell class])];
        return cell;
    }else if ([_contentType isEqualToString:@"60"]){
        SevenCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SevenCell class])];
        return cell;
    }else if ([_contentType isEqualToString:@"70"]){
        EightCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EightCell class])];
        return cell;
    }else if ([_contentType isEqualToString:@"80"]){
        NineCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NineCell class])];
        return cell;
    }else if ([_contentType isEqualToString:@"90"]){
        TenCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TenCell class])];
        return cell;
    }else {
        ElevenCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ElevenCell class])];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
