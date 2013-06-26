//
//  ZMBDownsDetailedTableViewController.h
//  AEE
//
//  Created by Milton D. Mitjans on 6/12/13.
//  Copyright (c) 2013 Milton D. Mitjans. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZMMapViewController;

@interface ZMBDownsDetailedTableViewController : UITableViewController {
    ZMMapViewController* myView;
}

@property (nonatomic, strong) NSMutableDictionary *townName;


@end
