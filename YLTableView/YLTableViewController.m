//
//  YLTableViewTableViewController.m
//  YLTableView
//
//  Created by 鲁玉兰 on 16/6/20.
//  Copyright © 2016年 luyulan. All rights reserved.
//

#import "YLTableViewController.h"
#import "MJRefresh.h"
#import "YLTableViewCell.h"
#import "YLData.h"


@interface YLTableViewController ()
{
    UIView *_headView;
    UIImageView *_imageView;
    
}
@property (strong, nonatomic) NSArray *dataList;
@end

@implementation YLTableViewController

#define IMGAE_WIDTH [[UIScreen mainScreen] bounds].size.width

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCustomHeadView];
    [self refreshView];
    
    [self dataList];
    
    // 注册自定义cell
    [self.tableView registerNib:[UINib nibWithNibName:@"YLTableViewCell" bundle:nil] forCellReuseIdentifier:@"YLTableViewCell"];
    
    
    
}

- (void)setCustomHeadView
{
    // 下拉顶部图片变大
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, IMGAE_WIDTH, 200)];
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, IMGAE_WIDTH, 200)];
    [_imageView setImage:[UIImage imageNamed:@"image.jpg"]];
    [_imageView setAlpha:0.8];
    [_headView addSubview:_imageView];
    self.tableView.tableHeaderView = _headView;
    
}

- (void)refreshView
{
    // 下拉刷新
    self.tableView.mj_header= [MJRefreshGifHeader headerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [self.tableView.mj_header endRefreshing];
        });
    }];
    
    //  上拉翻页
    self.tableView.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [self.tableView.mj_footer endRefreshing];
        });
        
    }];

}

- (NSArray *)dataList {
    if (!_dataList) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"messages" ofType:@"plist"];
        NSArray *originArray = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *mArry = [NSMutableArray array];
        for (NSDictionary *dic in originArray) {
            YLData *model = [YLData messageWithDict:dic];
            [mArry addObject:model];
        }
       
        _dataList = mArry;
    }
    return _dataList;
}



#pragma mark - ScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y = self.tableView.contentOffset.y;
    
    // 向下拉
    if (y<-64) {
        CGFloat factor= ABS(y)+200-64;
        CGRect f = CGRectMake(-(IMGAE_WIDTH*factor/200-IMGAE_WIDTH)/2, -ABS(y)+64, IMGAE_WIDTH*factor/200, factor);
        _imageView.frame = f;
    }
    else {
        CGRect f = _headView.frame;
        f.origin.y = 0;
        _headView.frame = f;
        _imageView.frame = CGRectMake(0, f.origin.y, IMGAE_WIDTH, 200);
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YLTableViewCell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[YLTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YLTableViewCell"];
    }

  
    [cell setMessage:_dataList[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YLData *content = _dataList[indexPath.row];
    return content.cellHeight;
}


#pragma TableView delegate
-(NSArray<UITableViewRowAction*>*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *rowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                         title:@"删除"
                                                                       handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                                                           NSLog(@"删除");
                                                                       }];
    UITableViewRowAction *rowActionSec = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                            title:@"标记"
                                                                          handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                                                              NSLog(@"标记");
                                                                          }];
    UITableViewRowAction *rowActionThd = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                            title:@"详情"
                                                                          handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                                                              NSLog(@"详情");
                                                                          }];
    rowActionSec.backgroundColor = [UIColor greenColor];
    rowActionThd.backgroundColor = [UIColor grayColor];
    NSArray *arr = @[rowAction,rowActionSec, rowActionThd];
    return arr;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 点击后，选中颜色立刻消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"点击了第几行:%ld", indexPath.row+1);
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
