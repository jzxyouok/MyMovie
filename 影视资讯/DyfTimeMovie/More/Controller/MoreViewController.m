//
//  MoreViewController.m
//  DyfTimeMovie
//
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()

@property (strong, nonatomic) IBOutlet UILabel *fileSize;

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"更多";
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 125, 44)];
    titleLabel.text = @"更多";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:20];
    
    self.navigationItem.titleView = titleLabel;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    //显示缓存文件的大小
    _fileSize.text = [NSString stringWithFormat:@"%.2fM",[self countCacheFileSize]];
}

#pragma mark - 计算当前应用程序缓存文件大小之和
- (CGFloat)countCacheFileSize
{
    //获取文件夹的路径
    //NSHomeDirectory函数 用于获取当前程序的沙盒路径
    NSString *homePath = NSHomeDirectory();

    //子文件夹1 视频缓存 /tmp/MediaCache/
    //子文件夹2   /Library/Caches/com.hackemist.SDWebImageCache.default/
    //子文件夹3  /Library/Caches/Snapshots/huiwen.com.DyfTimeMovie/huiwen.com.DyfTimeMovie/
    
    //使用 - (CGFloat)getFileSize:(NSString *)filePath 计算这些文件夹中文件的大小
    NSArray *pathArray = @[@"/tmp/MediaCache/",@"/Library/Caches/com.hackemist.SDWebImageCache.default/",@"/Library/Caches/huiwen.com.DyfTimeMovie/"];
    
    //文件大小之和
    CGFloat fileSize = 0;
    for (NSString *string in pathArray)
    {
        //拼接路径
        NSString *filePath = [NSString stringWithFormat:@"%@%@",homePath,string];
        
        //对上一步计算进行求和
        fileSize +=  [self getFileSize:filePath];
    }
    
    return fileSize;
}

#pragma mark - 根据传入的路径，计算此路径下的文件大小
- (CGFloat)getFileSize:(NSString *)filePath
{
    //文件管理器对象 单列
    NSFileManager *manager = [NSFileManager defaultManager];
    //用数组储存文件夹中所有的子文件夹及文件的名字
    NSArray *fileNames = [manager subpathsOfDirectoryAtPath:filePath error:nil];
    
    long long size = 0;
    //遍历文件夹
    for (NSString *fileName in fileNames)
    {
        //拼接获取文件的路径
        NSString *subFilePath = [NSString stringWithFormat:@"%@%@",filePath,fileName];
        //获取文件信息
        NSDictionary *dic = [manager attributesOfItemAtPath:subFilePath error:nil];
        //获取单个文件的大小
        NSNumber *sizeNumber = dic[NSFileSize];
        //储存文件大小
        long long subFileSize = [sizeNumber longLongValue];
        
        //文件大小求和
        size += subFileSize;
    }
    return size / 1024.0 / 1024;
}

#pragma mark - 清理缓存
- (void)clearCache
{
    //获取文件夹的路径
    NSString *homePath = NSHomeDirectory();
    
    //清理缓存
    NSArray *pathArray = @[@"/tmp/MediaCache/",@"/Library/Caches/com.hackemist.SDWebImageCache.default/",@"/Library/Caches/huiwen.com.DyfTimeMovie/"];
    
    for (NSString *string in pathArray)
    {
        //拼接路径
        NSString *filePath = [NSString stringWithFormat:@"%@%@",homePath,string];
        
        //文件管理器对象
        NSFileManager *manager = [NSFileManager defaultManager];
        //用数组储存文件夹中所有的子文件夹及文件的名字
        NSArray *fileNames = [manager subpathsOfDirectoryAtPath:filePath error:nil];
        
        //遍历文件夹删除文件
        for (NSString *fileName in fileNames)
        {
            //拼接子文件路径
            NSString *subFilePath = [NSString stringWithFormat:@"%@%@",filePath,fileName];
           //删除文件
            [manager removeItemAtPath:subFilePath error:nil];
        }
    }    
    //重新计算缓存文件大小
    _fileSize.text = [NSString stringWithFormat:@"%.2fM",[self countCacheFileSize]];
}

#pragma mark - 单元格的选中事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:@"提示" message:@"确定清理所有缓存?" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        [alertView show];
    }
}

//提示框的按钮点击事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //判断点击的按钮为 "是"
    if (buttonIndex == 1)
    {
        //清理缓存
        [self clearCache];
    }
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
