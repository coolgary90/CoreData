//
//  SecondViewController.m
//  CoreData
//
//  Created by Amanpreet Singh on 30/01/17.
//  Copyright © 2017 Amanpreet Singh. All rights reserved.
//

#import "SecondViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@interface SecondViewController ()
{
    NSMutableArray *employeeDetails;
    NSManagedObject *updatedManagedObject;
    
    
}

@end

@implementation SecondViewController

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(persistentContainer)]) {
        context = [[delegate persistentContainer] viewContext];
    }
    return context;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabelView.delegate=self;
    self.tabelView.dataSource=self;
    self.updateView.hidden=YES;
    
    employeeDetails=[[NSMutableArray alloc]init];
    self.tabelView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    
    [self.tabelView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    NSManagedObjectContext *context=[self managedObjectContext];
    
    NSEntityDescription *description=[NSEntityDescription entityForName:@"Employee" inManagedObjectContext:context];
    NSFetchRequest *request=[[NSFetchRequest alloc]init];
    [request setEntity:description];
    NSError *error;
    employeeDetails=[[context executeFetchRequest:request error:&error] mutableCopy];
    //fouth commit
    

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [employeeDetails count];
    ;
    
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context=[self managedObjectContext];
    
    if(editingStyle==UITableViewCellEditingStyleDelete)
    {
    [context deleteObject:[employeeDetails objectAtIndex:indexPath.row]];
    }
    NSError *error=nil;
    if(![context save:&error])
    {
        NSLog(@"Error Occured");
        return;
        
    }
    [employeeDetails removeObjectAtIndex:indexPath.row];
    [self.tabelView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CELL"];
    
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CELL"];
        
    }
    NSManagedObject *employeeDetailsManagedObj=[employeeDetails objectAtIndex:indexPath.row];
    
    
    cell.textLabel.text=[NSString stringWithFormat:@"%@",[employeeDetailsManagedObj valueForKey:@"name"]];
    ;
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%@",[employeeDetailsManagedObj valueForKey:@"contactNo"]];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    NSInteger index=indexPath.row;
    
    [self OpenEmployeeDetailsUpdateView:index];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)updateClicked:(id)sender {
    NSManagedObjectContext *context=[self managedObjectContext];
    
    if(updatedManagedObject)
    {
        [updatedManagedObject setValue:self.updatedContactNo.text forKey:@"contactNo"];

    NSError *error=nil;
    
    if(![context save:&error])
    {
        NSLog(@"Can't save");
        
    }
    [self.tabelView reloadData];
    [UIView animateWithDuration:0.5 animations:^{
        self.updateView.hidden=YES;
        
        
    }
     ];
    
    
    }
    
    
}

-(void)OpenEmployeeDetailsUpdateView:(NSInteger)index

{
    NSManagedObject *selectedManagedObj=[employeeDetails objectAtIndex:index];
    self.name.text=[NSString stringWithFormat:@"%@",[selectedManagedObj valueForKey:@"name"]];
    
    updatedManagedObject=[employeeDetails objectAtIndex:index];
    
    

    [UIView animateWithDuration:0.5 animations:^{
        self.updateView.hidden=NO;

    }];
    
    
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
