//
//  ExhibitorsController.m
//  MDW
//
//  Created by Mahmoud Amin on 4/27/16.
//  Copyright (c) 2016 Mahmoud Amin. All rights reserved.
//

#import "ExhibitorsController.h"
#import "SWRevealViewController.h"
#import "JETSExhibitor.h"
#import "NetWorkHandler.h"
#import "NetWorkDelegate.h"
#import "NetWorkManager.h"
#import "JETSExhibitorModel.h"

@interface ExhibitorsController (){
    NSArray *responseData;
    UIActivityIndicatorView *activity;
}

@end

@implementation ExhibitorsController
   



- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.refreshControl=[[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor=[UIColor purpleColor];
    self.refreshControl.tintColor=[UIColor whiteColor];
    
    [self.refreshControl addTarget:self action:@selector(getLatestExhibitors) forControlEvents:UIControlEventValueChanged];
      [self getLatestExhibitors];
   
    
    _barBtn.target = self.revealViewController;
    _barBtn.action = @selector(revealToggle:);
   [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    UIGraphicsBeginImageContext(self.view.frame.size);
   [[UIImage imageNamed:@"background.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
}
-(void)viewWillAppear:(BOOL)animated{
    NetWorkManager *netMang=[NetWorkManager new];
    NetWorkHandler *netcal=[netMang connect ];
    [netcal getExhibitorWithEmail:@"asmaabadreldin@hotmail.com" WithDelgate:self];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.row);
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[responseData [indexPath.row] companyUrl]]];
    
}
-(void) handleSuccess:(id) data{
   

    responseData =data;
    
    [self.tableView  reloadData];
    [activity stopAnimating];
    
    
    
    
    
}
-(void) handleFaild{
    
    [activity stopAnimating];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please check your connection" delegate:nil cancelButtonTitle:@"" otherButtonTitles:@"Ok", nil];
    
    [alert show];


    
}

-(void)getLatestExhibitors{
    [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    
    [self.refreshControl endRefreshing];
    
    
    
   

}

- (void)reloadData
{
    // Reload table data
    [self.tableView reloadData];
    if(self.refreshControl){
        
        NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d,h:mm a"];
        NSString *title=[NSString stringWithFormat:@"Last update: %@",[formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary=[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle=[[NSAttributedString alloc]initWithString:title attributes:attrsDictionary];
        self.refreshControl.attributedTitle=attributedTitle;
        
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [responseData count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"exhibitor" forIndexPath:indexPath];
    
    
    [cell.textLabel setText:[[responseData objectAtIndex:indexPath.row]companyName]];
    cell.imageView.image = [UIImage imageNamed:@"exihiptors.png"];
    
    cell.backgroundColor=[UIColor clearColor];
  
    // Configure the cell...
    
    return cell;
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
