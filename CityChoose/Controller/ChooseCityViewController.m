//
//  ChooseCityViewController.m
//  ExpandTableView
//
//  Created by 亚杏 on 16/11/8.
//  Copyright © 2016年 亚杏. All rights reserved.
//

#import "ChooseCityViewController.h"
#import "ExpandCell.h"
#import "MJExtension.h"
#import "CityModel.h"
#define kCell_Height 44


@interface ChooseCityViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray      *_sectionArray;//组名数组(省列表)
    NSMutableArray      *_stateArray;//状态存入
    UIButton            *_buttonCell;
    NSMutableArray *_selecteArray;//保存选中的cell对应的模型数据
    NSMutableArray *_indexArray;//保存选中的indexPath
    NSIndexPath *selIndexPath;
    NSUInteger selSection;

}

@property (strong,nonatomic) UIButton *finishBtn;//完成
@property (copy,nonatomic) NSString *localText;//定位文字
@property (strong,nonatomic) NSMutableArray *dataSource;
@property (strong,nonatomic) UITableView *expandTable;//城市收缩表
@property (copy,nonatomic) NSString *choiceCityText;//选中城市名字


@end

@implementation ChooseCityViewController

-(void)setupStartCell{

    for (int i = 0; i<3; i++) {

        CGFloat x = 0;
        CGFloat y = 44*i;
        CGFloat w = ScreenWidth;
        CGFloat h = 44;

        _buttonCell = [[UIButton alloc]initWithFrame:CGRectMake(x, y,w ,h)];
        _buttonCell.tag = i + 1;
        [_buttonCell addTarget:self action:@selector(buttonCellClick) forControlEvents:UIControlEventTouchUpInside];
        _buttonCell.backgroundColor = [UIColor whiteColor];

        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 43)];
        label1.text = @"定位到当前城市";
        UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, _buttonCell.frame.size.height - 1, _buttonCell.frame.size.width, 1)];
        [line setImage:[UIImage imageNamed:@"line_real"]];
        [_buttonCell addSubview:line];
        [_buttonCell addSubview:label1];
        [self.view addSubview:_buttonCell];

        if (_buttonCell.tag == 1) {
            _buttonCell.backgroundColor = [UIColor grayColor];
            _buttonCell.userInteractionEnabled = NO;
            label1.text = @"定位到当前城市";
        }else if ( _buttonCell.tag == 3){
            _buttonCell.backgroundColor = [UIColor grayColor];
            _buttonCell.userInteractionEnabled = NO;
            label1.text = @"全部";
        }else{
            _buttonCell.backgroundColor = [UIColor whiteColor];
            _buttonCell.userInteractionEnabled = YES;
            label1.text = @"北京";
           // label1.text = self.localText;

        }
    }
}

//点击定位的button
-(void)buttonCellClick{

    NSLog(@"%ld",_buttonCell.tag);
}



- (void)initDataSource
{
    NSArray *cityArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"]];
    NSArray *models = [CityModel mj_objectArrayWithKeyValuesArray:cityArr];
    NSMutableArray *provinces = [NSMutableArray array];
    NSMutableArray *city = [NSMutableArray array];

    for (CityModel *model in models) {
        [provinces addObject:model.state];
        [city addObject:model.cities];
    }
    _selecteArray = [[NSMutableArray alloc] init];
    _indexArray  = [[NSMutableArray alloc] init];

    _sectionArray  = provinces;//省列表数据
    _dataSource = city;//城市列表数据
    _stateArray = [NSMutableArray array];

    for (int i = 0; i < _dataSource.count; i++)
    {
        //所有的分区都是闭合
        [_stateArray addObject:@"0"];
    }
    
    selSection = -1;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    [self setupNavigation];
    [self initDataSource];
    [self initTable];
    [self setupStartCell];
    

}

//设置导航控制器
-(void)setupNavigation{
    self.navigationItem.title = @"所在地区";
    _finishBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    //[button setImage:image forState:UIControlStateNormal];
    [_finishBtn addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
    [_finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    [_finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:_finishBtn];

    self.navigationItem.rightBarButtonItem = item;


}

//点击完成
-(void)finish{
    [_finishBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
}

//初始化扩展表
-(void)initTable{
    _expandTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 132, self.view.frame.size.width, ScreenHeight - 64 - 132) style:UITableViewStylePlain];
    _expandTable.dataSource = self;
    _expandTable.delegate =  self;
    _expandTable.tableFooterView = [UIView new];
    [_expandTable registerClass:[ExpandCell class] forCellReuseIdentifier:@"cell"];

    [self.view addSubview:_expandTable];
}

#pragma mark - UITableViewDataSource UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_stateArray[section] isEqualToString:@"1"]){
        //如果是展开状态
        NSArray *array = [self.dataSource objectAtIndex:section];
        return array.count;
    }else{
        //如果是闭合，返回0
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExpandCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (selIndexPath) {
        if (selIndexPath == indexPath) {
            cell.textLabel.textColor = [UIColor orangeColor];
        }else {
            cell.textLabel.textColor = [UIColor blackColor];
        }
    }
    cell.textLabel.text = self.dataSource[indexPath.section][indexPath.row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _sectionArray[section];
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    [button setTag:section+1];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 60)];
    [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, button.frame.size.height-1, button.frame.size.width, 1)];
    [line setImage:[UIImage imageNamed:@"line_real"]];
    [button addSubview:line];


    UIImageView *_imgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-30, (kCell_Height-6)/2, 10, 6)];

    if ([_stateArray[section] isEqualToString:@"0"]) {
        _imgView.image = [UIImage imageNamed:@"ico_listdown"];
    }else if ([_stateArray[section] isEqualToString:@"1"]) {
        _imgView.image = [UIImage imageNamed:@"ico_listup"];
    }
    [button addSubview:_imgView];

    UILabel *tLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, (kCell_Height-20)/2, 200, 20)];
    [tLabel setBackgroundColor:[UIColor clearColor]];
    tLabel.textColor = [UIColor blackColor];
    [tLabel setFont:[UIFont systemFontOfSize:20]];
    [tLabel setText:_sectionArray[section]];
    tLabel.tag = section + 101;
    [button addSubview:tLabel];
    
    if (selSection == section) {
        tLabel.textColor = [UIColor orangeColor];
    }
    
    return button;
}


#pragma mark  -select cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    selIndexPath = indexPath;
    [_selecteArray addObject:self.dataSource[indexPath.section][indexPath.row]];
//    //保存选中的城市数据
    self.choiceCityText = [NSString stringWithFormat:@"%@%@",_sectionArray[indexPath.section],cell.textLabel.text];
    [tableView reloadData];
    NSLog(@"%@",self.choiceCityText);

    [_indexArray addObject:indexPath];
//    NSLog(@"%@",cell);

}
//#pragma mark  -deselect cell
//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    cell.textLabel.textColor = [UIColor blackColor];
//    if ([_selecteArray containsObject:self.dataSource[indexPath.section][indexPath.row]]) {
//        [_selecteArray removeObject:self.dataSource[indexPath.section][indexPath.row]];
//    }
//    if ([_indexArray containsObject:indexPath]) {
//        [_indexArray removeObject:indexPath];
//    }
//    NSLog(@"2222%@",cell);
//
//}



- (void)buttonPress:(UIButton *)sender//headButton点击
{
    //判断状态值
    if ([_stateArray[sender.tag - 1] isEqualToString:@"1"]){
        selSection = -1;
        //展开状态
        [_stateArray replaceObjectAtIndex:sender.tag - 1 withObject:@"0"];


    }else{
        //收缩状态
        selSection = sender.tag - 1;
        [_stateArray replaceObjectAtIndex:sender.tag - 1 withObject:@"1"];
       // _selecteArray = nil;
        if (_indexArray.count > 1) {
            [_indexArray removeObjectAtIndex:0];
        }

    }
    [self.expandTable reloadSections:[NSIndexSet indexSetWithIndex:sender.tag-1] withRowAnimation:UITableViewRowAnimationAutomatic];
    UILabel *tLabel = [sender viewWithTag:sender.tag + 100];
    tLabel.textColor = [UIColor orangeColor];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCell_Height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kCell_Height;
}

@end
