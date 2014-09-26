//
//  CandyChatViewController.m
//  CandyStore
//
//  Created by Jordan on 9/25/14.
//  Copyright (c) 2014 Byjor. All rights reserved.
//

#import "CandyChatViewController.h"
#import "CommentInputTableViewCell.h"
#import "Comment.h"
#import "CommentLog.h"

@interface CandyChatViewController ()

@property (strong, nonatomic) IBOutlet UITextField *textInput;

@end

@implementation CandyChatViewController {
    CommentLog *commentLog;
    
    int numRows;
    int commentCount;
    NSTimer *myTimer;
    
    UITextField *commentInput;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    commentLog = [[CommentLog alloc] init];
    commentCount = 0;
    
//    myTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(updateComments) userInfo:nil repeats:YES];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [commentLog import:^(){ [self updateComments]; }];
    
    self.commentObjects = commentLog.objects;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    numRows = (int)[self.commentObjects count];
    return numRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Comment" forIndexPath:indexPath];

    long nextCommentNumber = numRows - 1 - indexPath.row;
    Comment *nextComment = self.commentObjects[nextCommentNumber]; // sub from numRows to get reverse order
    [cell.textLabel setText:nextComment.text];
    return cell;
}

- (IBAction)sendNewComment:(id)sender {
    NSLog(@"send new comment");
    commentCount++;
    Comment *newComment = [[Comment alloc] init];
    
    NSString *commentText = self.textInput.text;
    newComment.text = commentText;
    self.textInput.text = @""; // reset input box to empty
    
    [commentLog persist:newComment withUpdate:^(){ [self updateComments]; }];
}


- (IBAction)sendComment:(id)sender {
    NSLog(@"new comment");
    commentCount++;
    Comment *newComment = [[Comment alloc] init];
    
    NSString *commentText = commentInput.text;
    newComment.text = commentText;
    commentInput.text = @""; // reset input box to empty
    
//    newComment.text = [NSString stringWithFormat:@"comment number %i", numRows];
    
    [commentLog persist:newComment withUpdate:^(){ [self updateComments]; }];
}

- (void) updateComments {
    [self.tableView reloadData];
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
