//
//  UICandyTableViewCell.m
//  CandyStore
//
//  Created by Jordan on 9/19/14.
//  Copyright (c) 2014 Byjor. All rights reserved.
//

#import "UICandyTableViewCell.h"

@implementation UICandyTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    [self.candyThumbnail setClipsToBounds:YES];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
