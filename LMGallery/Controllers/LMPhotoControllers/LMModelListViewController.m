//
//  LMModelListViewController.m
//  LMGallery
//
//  Created by Apple on 14-1-9.
//  Copyright (c) 2014年 lmodel. All rights reserved.
//

#import "LMModelListViewController.h"
#import "LMSigalModelCell.h"
#import "LMDetailPhotoViewController.h"
#import "LMBasicDBOperator.h"

@interface LMModelListViewController ()

@end

@implementation LMModelListViewController
@synthesize searchResultArr;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor clearColor];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        searchResultArr = [NSMutableArray array];
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

#pragma - tableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [LMSigalModelCell getCellHeight];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return searchResultArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *searchResultCellId = @"searchResultCell";
    
    LMSigalModelCell *cell = [tableView dequeueReusableCellWithIdentifier:searchResultCellId];
    if (cell == nil) {
        cell = [[LMSigalModelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:searchResultCellId];
    }
    
    LMModelBo *bo = [searchResultArr objectAtIndex:indexPath.row];
    [cell displayWith:bo];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LMDetailPhotoViewController *dp = [[LMDetailPhotoViewController alloc] init];
    dp.curModelBo = [searchResultArr objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:dp animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    if (tapGesture != nil) {
//        [self resignKeyBoard];
//    }
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        LMModelBo *bo = [searchResultArr objectAtIndex:indexPath.row];
        [LMBasicDBOperator updateSavedState:NO mid:[bo getStrMid]];
        [searchResultArr removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    
}


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
