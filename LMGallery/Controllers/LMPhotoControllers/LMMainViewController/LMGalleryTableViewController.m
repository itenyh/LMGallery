//
//  LMGalleryTableViewController.m
//  LMGallery
//
//  Created by Apple on 14-1-16.
//  Copyright (c) 2014年 lmodel. All rights reserved.
//

#import "LMGalleryTableViewController.h"
#import "LMGalleryTableCell.h"
#import "LMDetailPhotoViewController.h"

@interface LMGalleryTableViewController () <LMGalleryTableCellDelegate>

@end

@implementation LMGalleryTableViewController
@synthesize datas;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        datas = [NSMutableArray array];
        self.view.backgroundColor = [UIColor clearColor];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [LMGalleryTableCell getCellHeight];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (datas.count % 3 == 0) {
        return datas.count / 3;
    }
    
    else {
        return datas.count / 3 + 1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *LMGalleryTableCellIdentifier = @"LMGalleryTableCell";
    LMGalleryTableCell *cell = [tableView dequeueReusableCellWithIdentifier:LMGalleryTableCellIdentifier];
    if (cell == nil) {
        cell = [[LMGalleryTableCell alloc] init];
        cell.delegate = self;
    }
    
    cell.tag = indexPath.row;
    NSMutableArray *sectionDatas = [NSMutableArray array];
    int rowNum = indexPath.row;
    for (int i = rowNum * 3; i < rowNum * 3 + 3; i++) {
        if (i == datas.count) {
            break;
        }
        [sectionDatas addObject:[datas objectAtIndex:i]];
    }
    [cell displayWith:sectionDatas];
    
    return cell;
}

- (void)lMGalleryTableCellPicClicked:(LMGalleryTableCell *)cell picIndex:(int)index
{
    int num = cell.tag * 3 + index;
    LMDetailPhotoViewController *dp = [[LMDetailPhotoViewController alloc] init];
    dp.curModelBo = [datas objectAtIndex:num];
    [self.navigationController pushViewController:dp animated:YES];
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
