//
//  ViewController.m
//  ListTest-OC
//
//  Created by rambo on 2021/7/8.
//

#import "ViewController.h"
#import "NewViewController.h"


@interface ViewController ()<NeWViewControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) NSMutableArray<NSMutableArray *> *array;

@end


@implementation ViewController

const NSInteger sectionNum = 5;
const NSInteger rowNum = 3;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getData];
    [self constructUI];
}

// 准备数据
- (void)getData
{
    self.array = [[NSMutableArray alloc] init];
    for (NSInteger section = 0; section < sectionNum; section++)
    {
        NSMutableArray *arrayValue = [[NSMutableArray alloc] init];
        for(NSInteger row = 0; row < rowNum; row++)
        {
            [arrayValue addObject:[NSString stringWithFormat:@"row %ld", row + 1]];
        }
        [self.array addObject:arrayValue];
    }
}

// 构建 UI
- (void)constructUI
{
    self.title = @"通讯录";
    //style是一个UITableViewStyle类型的参数，是一个枚举类型，包含UITableViewStylePlain,UITableViewStyleGrouped
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    // 添加 UITableView 的方法
    // 1. viewController要实现UITableViewDelegate,UITableViewDataSource两个delegate
    // 2. UITableView设置self delegate 这样子就会有代码提示
    // 3. 实现 numberOfSectionsInTableView:, tableView:cellForRowAtIndexPath: 这些方法
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // 创建头部信息
    UILabel* headerLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    [headerLable setText:@"联系人列表"];
    headerLable.textAlignment = NSTextAlignmentCenter;
    [self.tableView setTableHeaderView:headerLable];
    // 创建尾部信息
    UILabel* footerLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    [footerLable setText:@"共有40位联系人"];
    footerLable.textAlignment = NSTextAlignmentCenter;
    [self.tableView setTableFooterView:footerLable];
    //[self.tableView setEditing:YES animated:YES];
    // 将tableview加入到视图中
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.array.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return self.array[section].count;
    // return [self.array[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: understand dequeueReusableCellWithIdentifier
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell"];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mycell"];
    }
    cell.textLabel.text = self.array[indexPath.section][indexPath.row];
    if (@available(iOS 13.0, *))
    {
        cell.imageView.image = [UIImage systemImageNamed:@"person.crop.circle.fill"];
    }
    else
    {
        // Fallback on earlier versions
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Section %ld", section + 1];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.indexPath = indexPath;
    NewViewController *newView = [[NewViewController alloc] init];
    // - MARK: 从前往后传值是否是这样
    newView.str = self.array[self.indexPath.section][self.indexPath.row];
    newView.delegate = self;
    __weak typeof(self) weakSelf = self;
    newView.sendValueBlock = ^(NSString *str) {
        weakSelf.title = str;
    };
//    [newView returnSendValue:^(NSString *str) {
//        self.title = str;
//    }];
    [self.navigationController pushViewController:newView animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.array[indexPath.section] removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)sendValue:(NSString *)string
{
    self.title = string;
    self.array[self.indexPath.section][self.indexPath.row] = string;
    [self.tableView reloadRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationLeft];
}

@end
