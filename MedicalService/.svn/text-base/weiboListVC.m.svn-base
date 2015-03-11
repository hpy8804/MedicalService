//
//  weiboListVC.m
//  MedicalService
//
//  Created by 张琼芳 on 13-8-28.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "weiboListVC.h"

#import "weiboCell.h"

#import "weiboMainVC.h"

@interface weiboListVC ()<ASIHTTPRequestDelegate>
{
    FLActivity *activity;
    
    NSMutableArray *fansNumArray;
    NSMutableArray *imageArray;
    NSArray *title;
    NSArray *URLSArray;
    NSInteger index;
}
@end

@implementation weiboListVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Appoint_background"]];
    [self.tableView setBackgroundView:background];
    
    activity = [[FLActivity alloc] init];
    fansNumArray = [[NSMutableArray alloc] init];
    imageArray = [[NSMutableArray alloc] init];
    self.title = @"医院微博";
    title = [[NSArray alloc ]initWithObjects:
                      
                      @"智慧健康镇江",
                      @"健康镇江",
                      @"镇江市中心血站",
                      @"镇江市卫生监督所",
                      
                      @"健康镇江12320",
                      @"镇江市卫生局团委",
                      @"镇江市口腔医院",
                      @"镇江市中医院",
                      @"镇江市第一人民医院",
                      
                      @"镇江市第二人民医院",
                      @"镇江市第二人民医院团委",
                      @"镇江市第三人民医院",
                      @"镇江市第四人民医院",
                      @"江大附院(江滨医院)",
             
                      @"琢磨医改",
                      @"镇江市大市口社区卫生服务中心",
                      @"丹徒市卫生局",
                      @"京口区谏壁镇社区卫生服务中心",
                      @"京口疾控", nil];
    [self getFansNum];
    [self setImage];

    
}
-(void)viewWillDisappear:(BOOL)animated
{
    
    [[ASIHTTPRequest sharedQueue] cancelAllOperations];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setImage{
    NSArray *imageNames = [NSArray arrayWithObjects:@"Wisdom_Health_ZhenJiang",@"Public_Heath_Bureau",@"blood_Center",@"health_Inspection_Bureau",@"12320",@"Youth_League_Committee",@"Stomatological_Hospital",@"Chinese_Medicine",@"First_Peoples_Hospital",@"Second_Peoples_Hospital",@"Youth_League_Committee",@"Third_Peoples_Hospital",@"Fourth_People_Hospital",@"UJS_Hospital",@"Medical_Reform",@"Stomatological_Hospital",@"DanTu",@"JianBi_Zhen",@"JingKou_CDC", nil];
    for(NSString *name in imageNames){
       
        UIImage *image = [UIImage imageNamed:name];
        
        [imageArray addObject:image];
    }
}
-(void)getFansNum{
        URLSArray = [NSArray arrayWithObjects:
                    
                    @"http://e.weibo.com/u/2259575454",
                    @"http://e.weibo.com/u/2494516840",
                    @"http://weibo.com/zjszxxz",
                    @"http://e.weibo.com/u/2436512633",
                    
                    @"http://e.weibo.com/u/1323817160",
                    @"http://e.weibo.com/zjwstw",
                    @"http://e.weibo.com/2507535874/map",
                    @"http://e.weibo.com/u/2511057440",
                    @"http://e.weibo.com/zjsdyrmyy",
                    
                    @"http://e.weibo.com/u/2437996593",
                    @"http://e.weibo.com/u/2331514263",
                    @"http://e.weibo.com/u/2506808292",
                    @"http://e.weibo.com/u/2510722312",
                    @"http://weibo.com/u/2472976265",
                 
                    @"http://weibo.com/u/2122418382",
                    @"http://weibo.com/u/2615977923",
                    @"http://weibo.com/u/2799753110",
                    @"http://weibo.com/u/2615953883",
                    @"http://weibo.com/u/2614880363",nil];
    index = 0;
//    [activity startActivity:self.tableView parentViewDisabled:YES];
    NSURL *weiboUrl = [NSURL URLWithString:[URLSArray objectAtIndex:index]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:weiboUrl];
    request.delegate  = self;
    [request startAsynchronous];
    

}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    index++;
    NSString *string = [request responseString];
    NSString *num;
    NSArray *spit = [string componentsSeparatedByString:@"<span class=\"ft12 CH W_textb\">("];
    if ([spit count]<2) {
        NSArray *array = [string componentsSeparatedByString:@"<strong node-type=\"fans\">("];
        num = [[[array lastObject]componentsSeparatedByString:@")<\"/strong>"] objectAtIndex:0];
        
    }
    if ([num length]>1000) {
        NSArray *array = [string componentsSeparatedByString:@"粉丝["];
        num = [[[array lastObject] componentsSeparatedByString:@"]</a>"] objectAtIndex:0];
    }
    else{
        num =  [[[spit lastObject] componentsSeparatedByString:@")</span></div>"] objectAtIndex:0];
    }
    
    if ([num length]>1000) {
        num = @"";
    }
    if ([num length]>0) {
        weiboCell *cell = (weiboCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index-1 inSection:0]];
        
        cell.detailLabel.text = [NSString stringWithFormat:@"粉丝(%@)",num];
    }
    
    [fansNumArray addObject:num];
    
    
    
    if (index<[URLSArray count]) {
        NSURL *weiboUrl = [NSURL URLWithString:[URLSArray objectAtIndex:index]];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:weiboUrl];
        request.delegate  = self;
        [request startAsynchronous];
    }
    else{
        [self.view showToast:@"加载完成"];
    }
    
}
#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [title count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    weiboCell *cell = [weiboCell reuseableCell:tableView withOwner:nil];
    
    if (cell == nil) {
        cell = [[weiboCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    if ([title count]>indexPath.row) {
        cell.titleLabel.text = [title objectAtIndex:indexPath.row];
    }
    if ([fansNumArray count]>indexPath.row&&[[fansNumArray objectAtIndex:indexPath.row] length]>0) {
        cell.detailLabel.text = [NSString stringWithFormat:@"粉丝(%@)",[fansNumArray objectAtIndex:indexPath.row]];
    }
    if ([imageArray count]>indexPath.row) {
        [cell.image setImage:[imageArray objectAtIndex:indexPath.row]];
    }
    cell.image.layer.masksToBounds = YES;
    cell.image.layer.borderWidth = 4.0;
    cell.image.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    weiboMainVC *detailVC = [[weiboMainVC alloc] initWithNibNameSupportIPhone5AndIPad:@"weiboMainVC"];
    detailVC.weiboURL =[NSURL URLWithString:[URLSArray objectAtIndex:indexPath.row]];
    detailVC.title = [title objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
