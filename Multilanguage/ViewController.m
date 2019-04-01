//
//  ViewController.m
//  Multilanguage
//
//  Created by Павел Нехорошкин on 01.04.2019.
//  Copyright © 2019 Павел Нехорошкин. All rights reserved.
//

#import "ViewController.h"
#import "Multilanguage-Swift.h"

@interface ViewController () <UITableViewDataSource>

@property (nonatomic,strong)  UITableView *tableView;

@property (nonatomic,strong)  LinkedList *list;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    
    
    //  строки для отображения в UITableView сохраним в импортированном из Swift LinkedList<NSString>
    self.list = [[LinkedList alloc] init:@"One"]; ;
    [self.list add:@"Two"];
    [self.list add:@"Tree"];
    [self.list add:@"Four"];
    [self.list add:@"Five"];
    
    for (int i = 0; i < 30 ; i += 1)
    {
        [self.list add: [self.list getByIndex:i] ];
    }
    
    [self.list print];
    
    [self.view addSubview:self.tableView];

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return  [self.list count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    if (!cell)
    {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil ];
        
    }
    
    cell.textLabel.text = [self.list getByIndex:indexPath.row];
    
    return cell;
}
@end
