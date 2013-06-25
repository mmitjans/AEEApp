//
//  ZMBreakdownsTableViewCell.m
//  AEE
//
//  Created by Milton D. Mitjans on 6/12/13.
//  Copyright (c) 2013 Milton D. Mitjans. All rights reserved.
//

#import "ZMBreakdownsTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@interface ZMBreakdownsTableViewCell()
{
}
@end

static const NSInteger MAX_NUMBER_BREAKDOWNS = 4;
@implementation ZMBreakdownsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    self.layer.cornerRadius = 5.0;
    
    if (self.breakdowns.intValue > MAX_NUMBER_BREAKDOWNS) {
        self.backgroundColor = [UIColor redColor];
    }
    
    // Configure the view for the selected state
}

@end
