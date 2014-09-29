//
//  CandyPictureViewController.h
//  CandyStore
//
//  Created by Jordan on 9/17/14.
//  Copyright (c) 2014 Byjor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Candy;

@interface CandyPictureViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) Candy *candy;

@end
