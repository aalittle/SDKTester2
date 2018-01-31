//
//  InboxTableViewController.m
//  SDKTest2
//
//  Created by Andrew Little on 2017-07-13.
//  Copyright © 2017 Andrew Little. All rights reserved.
//

#import "InboxTableViewController.h"
//#import "ETMessage.h"
//#import "ExactTargetEnhancedPushDataSource.h"
//#import "ETAnalytics.h"

@interface InboxTableViewController ()<UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView *inboxTable;
//@property (nonatomic, strong) ExactTargetEnhancedPushDataSource *dataSource;
@end

@implementation InboxTableViewController

//// setup the data source for the table view
//- (ExactTargetEnhancedPushDataSource *) dataSource {
//  if(_dataSource == nil) {
//    _dataSource = [[ExactTargetEnhancedPushDataSource alloc]init];
//  }
//  return _dataSource;
//}
//
//- (void)viewDidLoad {
//  [super viewDidLoad];
//  // Do any additional setup after loading the view.
//  
//  // set delegate to table
//  self.inboxTable.delegate = self;
//  
//  // set data source to table
//  self.inboxTable.dataSource = self.dataSource;
//  
//  // This is a reference to the tableview in UIViewController. We need a reference to it to reload data periodically.
//  [self.dataSource setInboxTableView:self.inboxTable];
//  
//  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Refresh" style:UIBarButtonItemStylePlain target:self action:@selector(onRefresh)];
//}
//
//-(void)onRefresh {
//  
//  if (_dataSource.messages == nil || [_dataSource.messages count]) {
//    NSLog(@"no messages");
//  }
//  
//  for (ETMessage *message in _dataSource.messages) {
//    NSLog(@"%@", message.subject);
//  }
//}
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//  return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//  return [self.dataSource.messages count];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
//  
//  // Configure the cell...
//  ETMessage *message = _dataSource.messages[indexPath.row];
//  if (message) {
//    cell.textLabel.text = message.subject;
//    cell.detailTextLabel.text = message.messageIdentifier;
//  } else {
//    cell.textLabel.text = @"default";
//    cell.detailTextLabel.text = @"default";
//  }
//  return cell;
//}
//
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//  /*
//   *  Get the ETMessage object from the data source. Refer to the ETMessage.h file that is included in the SDK in order to see the available properties and methods
//   */
//  ETMessage *msg = [self.dataSource messages][indexPath.row];
//  
//  /*
//   * This must be called on a message in order for it to be marked as read
//   */
//  [msg markAsRead];
//  
//  /**
//   * Open the URL in Safari
//   */
//  [[UIApplication sharedApplication] openURL:msg.siteURL];
//  
//  /**
//   * reload table
//   */
//  [self.inboxTable reloadData];
//}
@end
