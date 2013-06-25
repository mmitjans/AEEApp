//
//  ZMBreakdownsTableViewCell.h
//  AEE
//
//  Created by Milton D. Mitjans on 6/12/13.
//  Copyright (c) 2013 Milton D. Mitjans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMBreakdownsTableViewCell : UITableViewCell

@property(nonatomic, weak) IBOutlet UILabel *myLabel;
@property(nonatomic, weak) IBOutlet UILabel *totalOfBreakdowns;
@property(nonatomic, strong) NSNumber *breakdowns;

@end
