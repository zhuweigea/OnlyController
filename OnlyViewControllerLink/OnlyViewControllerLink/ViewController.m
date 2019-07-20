//
//  ViewController.m
//  OnlyViewControllerLink
//
//  Created by 朱伟阁 on 2019/7/19.
//  Copyright © 2019 朱伟阁. All rights reserved.
//
#define WIDTH (self.view.bounds.size.width)*1/4
#import "ViewController.h"
#import "NodeCollectionView.h"
#import "NodeCollectionViewCell.h"
#import "ContentView.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>{
    ContentView *_cv;
}

@property(nonatomic, strong) NodeCollectionView *nodeCV;
@property(nonatomic, strong) NSArray<NSString *> *dataSource;
@property(nonatomic, assign) NSInteger currentIndex;

@property(nonatomic, strong) UIScrollView *contentSV;
@property(nonatomic, strong) NSMutableArray<ContentView *> *viewData;
@property(nonatomic, strong) NSArray *stateArr;//标记分类

@end

@implementation ViewController

-(NodeCollectionView *)nodeCV{
    if(!_nodeCV){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _nodeCV = [[NodeCollectionView alloc]initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 50) collectionViewLayout:layout];
        _nodeCV.backgroundColor = [UIColor whiteColor];
        _nodeCV.showsHorizontalScrollIndicator = NO;
        _nodeCV.bounces = NO;
        _nodeCV.delegate = self;
        _nodeCV.dataSource = self;
        [_nodeCV registerClass:[NodeCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([NodeCollectionViewCell class])];
    }
    return _nodeCV;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(WIDTH, 50);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *content = self.dataSource[indexPath.item];
    NodeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([NodeCollectionViewCell class]) forIndexPath:indexPath];
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    UILabel *lab = [UILabel new];
    lab.backgroundColor = [UIColor whiteColor];
    lab.text = content;
    lab.font = [UIFont systemFontOfSize:14];
    lab.textColor = [UIColor blackColor];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.frame = CGRectMake(0, 15, WIDTH, 20);
    [cell.contentView addSubview:lab];
    if (_currentIndex==indexPath.item) {
        lab.textColor = [UIColor redColor];
        UIView  *line=[[UIView alloc] initWithFrame:CGRectMake(10, 48, WIDTH-20, 2)];
        line.backgroundColor=[UIColor redColor];
        [cell.contentView addSubview:line];
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if(indexPath.item==_currentIndex)return;
    _currentIndex = indexPath.item;
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:_currentIndex inSection:0];
    [self.nodeCV reloadData];
    [self.nodeCV scrollToItemAtIndexPath:indexpath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    [self.contentSV setContentOffset:CGPointMake(_currentIndex*SCREEN_WIDTH, 0) animated:NO];
    ContentView *cv = self.viewData[_currentIndex];
    [cv.tv.mj_header beginRefreshing];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.viewData = [NSMutableArray arrayWithCapacity:0];
    self.dataSource = @[@"全部订单",@"待付款",@"待发货",@"待收货",@"待评价",@"已评价",@"点赞",@"订阅",@"分享",@"投诉",@"举报"];
    //分别标记上面的分类
    self.stateArr = @[@"0",@"10",@"20",@"30",@"40",@"50",@"60",@"70",@"80",@"90",@"100"];
    [self.view addSubview:self.nodeCV];
    self.contentSV = [UIScrollView new];
    self.contentSV.frame = CGRectMake(0, 70, self.view.bounds.size.width, self.view.bounds.size.height-70);
    self.contentSV.delegate = self;
    [self.view addSubview:self.contentSV];
    self.contentSV.pagingEnabled = YES;
    self.contentSV.bounces = NO;
    for (int i=0; i<self.dataSource.count; i++) {
        _cv=[[ContentView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, self.contentSV.frame.size.height) contentType:[self.stateArr objectAtIndex:i]  selfVc:self];
        _cv.tag=i+1000;
        [self.contentSV addSubview:_cv];
        if (i==0) {
            [_cv.tv.mj_header beginRefreshing];
        }
        [self.viewData addObject:_cv];
    }
    self.contentSV.contentSize = CGSizeMake(self.dataSource.count*SCREEN_WIDTH, 0);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if([scrollView isKindOfClass:[NodeCollectionView class]]){
        return;
    }
    NSInteger index = scrollView.contentOffset.x/SCREEN_WIDTH;
    if(_currentIndex==index)return;
    _currentIndex = index;
    ContentView *cv = self.viewData[_currentIndex];
    [cv.tv.mj_header beginRefreshing];
    [self.nodeCV reloadData];
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:_currentIndex inSection:0];
    [self.nodeCV scrollToItemAtIndexPath:indexpath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

@end
