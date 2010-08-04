//
//  PlaceNewViewController.m
//  TapPlace
//
//  Created by Thomas Balthazar on 24/07/10.
//  Copyright 2010 Suit My Mind SPRL. All rights reserved.
//

#import "PlaceNewViewController.h"
#import "Place.h"


@implementation PlaceNewViewController

@synthesize place, textView;

#pragma mark -
#pragma mark Override the designated initializer

- (id)init {
	if (self = [super initWithNibName:@"PlaceNewViewController" bundle:nil]) {
		// init code here
	}
	
	return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	return [self init];
}


- (void)viewDidLoad {
    [super viewDidLoad];
	
	UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
																				  target:self
																				  action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    [cancelButton release];

	UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
																				target:self
																				action:@selector(save)];
    self.navigationItem.rightBarButtonItem = saveButton;
    [saveButton release];	
}

#pragma mark -
#pragma mark save and cancel

- (void)cancel {
    [self.place.managedObjectContext deleteObject:self.place];
	[self dismissModalViewControllerAnimated:YES];
}

- (void)save {
	self.place.name = self.textView.text;
	self.place.createdAt = [NSDate date];

	NSError *error; 
    if (![self.place.managedObjectContext save:&error]) { 
        NSLog(@"Error while saving the place : %@", error);
    }   

	[self dismissModalViewControllerAnimated:YES];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[place release];
	[textView release];

    [super dealloc];
}


@end
