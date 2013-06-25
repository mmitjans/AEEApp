//
//  ZMViewController.m
//  AEE
//
//  Created by Milton D. Mitjans on 6/11/13.
//  Copyright (c) 2013 Milton D. Mitjans. All rights reserved.
//

#import "ZMViewController.h"

#import "BreakdownReportSvc.h"
#import "ZMClientProcessor.h"

@interface ZMViewController () <UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *shareButton;

@property (nonatomic, strong, readwrite) UILabel *titleLabel;

@end

@implementation ZMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"FlickrCell"];
    
    self.breakDowns = [[NSMutableArray alloc] init];
    
    [self processBreakdowns];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)shareButtonTapped:(id)sender {
    // TODO
}
-(void) processBreakdowns
{
    
    ZMClientProcessor *client = [[ZMClientProcessor alloc] init];
    self.breakDowns = [client getBreakdowns];
}

#pragma mark - UITextFieldDelegate methods
- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    return YES;
}

#pragma mark - UICollectionView Datasource
// 1
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    
    if ( [self.breakDowns count] > 0 ) {
        return 1;
    } else {
        return 0;
    }
    
}
// 2
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return [self.breakDowns count];
}
// 3
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"FlickrCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleHeight;
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:13.0f];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.3f];
    self.titleLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    
    ax22_BreakdownSummary *summary = [self.breakDowns objectAtIndex:indexPath.row];
    
    self.titleLabel.text = summary.r1TownOrCity;
    
    [cell addSubview:self.titleLabel];
    
    return cell;
}
// 4
/*- (UICollectionReusableView *)collectionView:
 (UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
 {
 return [[UICollectionReusableView alloc] init];
 }*/

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Select Item
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}

// 1
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    // self.searchResults[searchTerm][indexPath.row];
    // 2
    CGSize retval = CGSizeMake(100, 100);
    retval.height += 35;
    retval.width += 35;
    
    return retval;
}

// 3
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(50, 20, 50, 20);
}

@end
