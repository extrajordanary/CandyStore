//
//  CandyChatViewController.m
//  CandyStore
//
//  Created by Jordan on 9/25/14.
//  Copyright (c) 2014 Byjor. All rights reserved.
//

#import "CandyChatViewController.h"
#import "Comment.h"
#import "CommentLog.h"

@interface CandyChatViewController ()

@end

@implementation CandyChatViewController {
    CommentLog *commentLog;
    
    int numRows;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

// Not using sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // get array of comment objects
    [commentLog import];

    self.commentObjects = commentLog.objects;
    numRows = (int)[self.commentObjects count] + 1;
//    return numRows;
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    int row = (int)indexPath.row;
//    if (indexPath.row == 1) {
    if (row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"NewComment" forIndexPath:indexPath];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Comment" forIndexPath:indexPath];

        Comment *nextComment = self.commentObjects[numRows - indexPath.row]; // sub from numRows to get reverse order
        [cell.textLabel setText:nextComment.text];
//
//    Candy *nextCandy = self.candyObjects[indexPath.row];
//    [cell.candyName setText:nextCandy.name];

    // reload every other time
//    reloadTable = YES;
    }
    return cell;
}

- (IBAction)sendComment:(id)sender {
    NSLog(@"new comment");
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
