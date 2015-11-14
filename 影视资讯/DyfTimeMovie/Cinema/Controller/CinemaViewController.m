//
//  CinemaViewController.m
//  DyfTimeMovie
//
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "CinemaViewController.h"
#import "CinemaCell.h"
#import "Cinema.h"
#import "District.h"

@interface CinemaViewController ()
{
    NSMutableArray *_districtData; //地区数据
    UITableView *_tableView;  //表视图
}

@end

@implementation CinemaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"影院";
    
    //加载数据
    [self loadData];
    
    //creatView
    [self creatView];
    
}

#pragma mark - 加载数据
- (void)loadData
{
    //读取地区信息
    NSDictionary *dicD = [MovieJSON readJSONFile:@"district_list"];
    NSArray *arrayD = dicD[@"districtList"];
    
    _districtData = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in arrayD)
    {
        District *district = [[District alloc] initContentWithDic:dic];
        [_districtData addObject:district];
    }
    
    //读取影院信息
    NSDictionary *dicCinema = [MovieJSON readJSONFile:@"cinema_list"];
    NSArray *arrayCinema = dicCinema[@"cinemaList"];
    for (NSDictionary *dicCm in arrayCinema)
    {
        Cinema *cinema = [[Cinema alloc] initContentWithDic:dicCm];
        for (District *dis in _districtData)
        {
            //比较电影院的地区id 和 地区是否匹配
            if ([dis.districtID isEqualToString:cinema.districtId])
            {
                //如果匹配，就说明这家电影院在这个地区中
                [dis.cinemas addObject:cinema];
                
                break;
            }
        }
    }
}

- (void)creatView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    _tableView.showsVerticalScrollIndicator = NO;
    
    _tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main@2x"]];
    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //组数
    return _districtData.count;
}

#pragma mark - 获取分组的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    District *dis = _districtData[section];
    if (dis.isShow)
    {
        return dis.cinemas.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CinemaCell";
    CinemaCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CinemaCell" owner:self options:nil] lastObject];
    }
    //单元格属性
    cell.backgroundColor = [UIColor blackColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    District *dis = _districtData[indexPath.section];
    cell.cinema = dis.cinemas[indexPath.row];
    return cell;
}

#pragma mark - 自定义头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //给头视图创建按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, tableView.bounds.size.width, 30);
    [button setBackgroundImage:[UIImage imageNamed:@"hotMovieBottomImage@2x"] forState:UIControlStateNormal];
    
    button.tag = section + 100;
    
#pragma mark - 获取分组的标题
    District *dis = _districtData[section];
    [button setTitle:dis.name forState:UIControlStateNormal];
    
    //设置标题左对齐
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

#pragma mark - 自定义头视图时需要初始化头视图的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (void)buttonAction:(UIButton *)button
{
    //获取对应的小组索引
    NSInteger didSection = button.tag - 100;
    
    //每一次点击，展开状态取反
    District *dis = _districtData[didSection];
    dis.isShow = !dis.isShow;
    
    //刷新对应的分组
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:didSection] withRowAnimation:UITableViewRowAnimationNone];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //单元格的高度
    return 90;
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



