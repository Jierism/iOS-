//
//  ViewController.m
//  Tabel Cells
//
//  Created by  Jierism on 16/7/20.
//  Copyright © 2016年  Jierism. All rights reserved.
//

#import "ViewController.h"
#import "NameAndColorCellTableViewCell.h"

static NSString *CellTableIdentifier = @"CellTableIdentifier";

@interface ViewController ()

@property (copy,nonatomic) NSArray *computers;
@property (weak,nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.computers = @[@{@"Name" : @"MacBook Air",@"Color" : @"Sliver"},
                       @{@"Name" : @"MacBook Pro",@"Color" : @"Sliver"},
                       @{@"Name" : @"iMac",@"Color" : @"Sliver"},
                       @{@"Name" : @"Mac Mini",@"Color" : @"Sliver"},
                       @{@"Name" : @"Mac Pro",@"Color" : @"Black"},];
    
    UINib *nib = [UINib nibWithNibName:@"NameAndColorCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.computers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NameAndColorCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier forIndexPath:indexPath];
    
    NSDictionary *rowData = self.computers[indexPath.row];
    cell.name = rowData[@"Name"];
    cell.color = rowData[@"Color"];
    
    return cell;
}

@end
