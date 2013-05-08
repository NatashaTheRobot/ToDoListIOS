//
//  ViewController.m
//  ToDoList
//
//  Created by Natasha Murashev on 5/8/13.
//  Copyright (c) 2013 Natasha Murashev. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)addTodoItem:(id)sender;

@property (strong, nonatomic) NSMutableArray *todoLists;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.todoLists = [[NSMutableArray alloc] initWithObjects:[NSMutableArray array], [NSMutableArray array], nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - Action Methods

- (IBAction)addTodoItem:(id)sender
{
    if (![self.textField.text isEqualToString:@""]) {
        
        [self.todoLists[0] addObject:self.textField.text];
        
        self.textField.text = @"";
        
        NSIndexPath *path = [NSIndexPath indexPathForRow:([self.todoLists[0] count] - 1) inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - Data Source Delegate Methods 

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"todoItem";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = self.todoLists[indexPath.section][indexPath.row];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.todoLists count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.todoLists[section] count];
}

#pragma mark - Table View Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
