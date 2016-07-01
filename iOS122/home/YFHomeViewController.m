//
//  YFHomeViewController.m
//  iOS122
//
//  Created by 颜风 on 15/9/22.
//  Copyright (c) 2015年 iOS122. All rights reserved.
//

#import "YFHomeViewController.h"
#import "YFAutoLayoutCellViewController.h"
#import "YFAutoTransViewController.h"
#import "YFPatternViewController.h"
#import <AFNetworking.h>
#import "YFXibDemoViewController.h"
#import "YFMVCPostListViewController.h"
#import "YFRACViewController.h"
#import "YFMVVMPostListViewController.h"
#import "RAFNMainViewController.h"
#import "YFBlogListViewModel.h"
#import "YFCategoryArticleListModel.h"
#import "YFXmlToJsonViewController.h"
#import "YFRestClientViewController.h"
#import "YFObjectionViewController.h"
#import "YFJSPatchMainViewController.h"
#import "YFReactViewController.h"
#import "YFFXFormsLoginViewController.h"
#import "YFCustomPhotoAlbumViewController.h"
#import "YFJSPatchOnlineViewController.h"

@interface YFHomeViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView * tabelView;
@property (strong, nonatomic) NSArray * dataList; //!< 暂时用一个数组用数据源.

@end

@implementation YFHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"主页";
    self.tabelView = [[UITableView alloc] init];
    
    self.dataList = @[
  @{@"title":@"Masonry + UITableView-FDTemplateLayoutCell", @"detail": @"实现基于约束的自适应单元格的高度tabelView"},
  @{@"title":@"UI设计图自动转iOS UI控件", @"detail": @"给出设计图,就能立即自动生成相应的代码."},
  @{@"title":@"Xib复用示例", @"detail": @"Xib复用的实际例子"},
  @{@"title":@"一个MVC模式的例子", @"detail": @"含网络请求,解析,加载视图等完整内容."},
  @{@"title":@"RAC2.5版示例", @"detail": @"ReactiveCocoa2.5版示例"},
  @{@"title":@"一个MVVM模式的例子", @"detail": @"MVC模式例子的MVVM版本."},
  @{@"title":@"AFNetworking-RACExtensions", @"detail": @"使AFN支持RAC的库,官方实例无法直接跑起来"},
  @{@"title":@"XML转JSON文件实例", @"detail": @"wordpress xml导出文件转leancloud json导入文件"},
  @{@"title":@"iOS Rest Client", @"detail": @"基于RAC和AFN重构LeanCloud的Rest Api"},
  @{@"title":@"Objection实例", @"detail": @"一个依赖注入,解决类耦合问题的库"},
  @{@"title":@"JSPatch 实例", @"detail": @"一个Apple官方支持的实现在线更新iOS应用的库"},
  @{@"title":@"ReactNative(请使用模拟器运行,真机需改IP.)", @"detail": @"正确配置React,在应用根目录执行命令(JS_DIR= ./ReactComponent/iOS; cd node_modules/react-native/React; npm run start -- --root $JS_DIR)"},
  @{@"title":@"FXForms示例", @"detail": @"FXForms自动生成表单示例"},
  @{@"title":@"保存网络图片到自定义相册", @"detail": @"使用SD下载图片,使用另一个第三方库保存."},
  @{@"title":@"JSPatch补丁实例", @"detail": @"更新成功会弹窗提示 我是一个补丁"}];
}

- (void)setTabelView:(UITableView *)tabelView
{
    _tabelView = tabelView;
    
    
    [self.view addSubview: self.tabelView];
    
    self.tabelView.delegate = self;
    self.tabelView.dataSource = self;
    
    [self.tabelView remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITabelView 代理方法.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger number = self.dataList.count;
    
    return number;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier: @"cell"];
    
    cell.textLabel.text = @"Masonry + UITableView-FDTemplateLayoutCell";
    
    cell.detailTextLabel.text = @"实现基于约束的自适应单元格的高度tabelView";
    
    NSDictionary * data = [self.dataList objectAtIndex: indexPath.row];
    
    NSString * title = [data objectForKey: @"title"];
    NSString * detail = [data objectForKey: @"detail"];
    
    cell.textLabel.text = title;
    cell.detailTextLabel.text = detail;
    
    [cell setSelectionStyle: UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.row) {
        YFAutoLayoutCellViewController * cellVC = [[YFAutoLayoutCellViewController alloc] init];
        
        [self.navigationController pushViewController: cellVC animated: YES];
    }
    
    if (1 == indexPath.row) {
        YFAutoTransViewController * autoTransVC = [[YFAutoTransViewController alloc] init];
        
        [self.navigationController pushViewController: autoTransVC animated: YES];
    }
    
    if (2 == indexPath.row) {
         YFXibDemoViewController * xibDemoVC = [[YFXibDemoViewController alloc] init];
        
        [self.navigationController pushViewController: xibDemoVC animated: YES];
    }
    
    if (3 == indexPath.row) {
        YFMVCPostListViewController * mvcPostListVC = [[YFMVCPostListViewController alloc] init];
        
        mvcPostListVC.categoryName = @"ui";

        
        [self.navigationController pushViewController: mvcPostListVC animated: YES];
    }
    
    if (4 == indexPath.row) {
        YFRACViewController * racVC = [[YFRACViewController alloc] init];
        
        [self.navigationController pushViewController: racVC animated: YES];
    }
    
    if (5 == indexPath.row) {
        YFMVVMPostListViewController * mvvmPostVC = [[YFMVVMPostListViewController alloc] init];
        
        YFCategoryArticleListModel * articleListModel = [[YFCategoryArticleListModel alloc] init];
        articleListModel.category = @"ui";
        
        YFBlogListViewModel * listVM = [[YFBlogListViewModel alloc] initWithCategoryArtilceListModel: articleListModel];
        
        mvvmPostVC.viewModel = listVM;
        
        [self.navigationController pushViewController: mvvmPostVC animated: YES];
    }
    
    if (6 == indexPath.row) {
        RAFNMainViewController * afnRACVC = [[RAFNMainViewController alloc] init];
        
        [self.navigationController pushViewController: afnRACVC animated: YES];
    }
    
    if (7 == indexPath.row) {
        YFXmlToJsonViewController * xmlToJsonVC = [YFXmlToJsonViewController new];
        
        [self.navigationController pushViewController: xmlToJsonVC animated: YES];
    }
    
    
    if (8 == indexPath.row) {
        YFRestClientViewController * restVC = [YFRestClientViewController new];
        
        [self.navigationController pushViewController: restVC animated: YES];
    }
    
    
    if (9 == indexPath.row) {
        YFObjectionViewController * objectionVC = [[YFObjectionViewController alloc]init];
        
        [self.navigationController pushViewController: objectionVC animated: YES];
    }
    
    
    
    if (10 == indexPath.row) {
        YFJSPatchMainViewController * jspatchVC = [[YFJSPatchMainViewController alloc]init];
        
        [self.navigationController pushViewController: jspatchVC animated: YES];
    }
    
    
    if (11 == indexPath.row) {
        YFReactViewController * reactVC = [[YFReactViewController alloc]init];
        
        [self.navigationController pushViewController: reactVC animated: YES];
    }
    
    if (12 == indexPath.row) {
        YFFXFormsLoginViewController * vc = [[YFFXFormsLoginViewController alloc]init];
        
        [self.navigationController pushViewController: vc animated: YES];
    }
    
    
    if (13 == indexPath.row) {
        YFCustomPhotoAlbumViewController * vc = [[YFCustomPhotoAlbumViewController alloc]init];
        
        [self.navigationController pushViewController: vc animated: YES];
    }
    
    if (14 == indexPath.row) {
        YFJSPatchOnlineViewController * vc = [[YFJSPatchOnlineViewController alloc]init];
        
        [self.navigationController pushViewController: vc animated: YES];
    }


}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 100;
    
    return height;
}


@end
