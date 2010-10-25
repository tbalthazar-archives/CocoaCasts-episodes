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

@synthesize place, delegate, textView;

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

	// get the current location
	TBCoreLocationController *locationController = [TBCoreLocationController sharedInstance];
	if ([TBCoreLocationController locationServicesEnabled]) {
		locationController.delegate = self;
		[locationController startUpdatingLocation];
	}
	else {
		NSLog(@"Location services are disabled");
	}
	
	self.title = NSLocalizedString(@"New Place", @"Title used for the new place screen");

	[self.textView becomeFirstResponder];

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
	
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	[nc addObserver:self 
		   selector:@selector(keyboardWillShow:) 
			   name:UIKeyboardWillShowNotification 
			 object:nil];		
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark -
#pragma mark save and cancel

- (void)cancel {
	if ([self.delegate respondsToSelector:@selector(placeNewViewController:didCancelPlace:)]) {
		[self.delegate placeNewViewController:self didCancelPlace:self.place];
	}
}

- (void)save {
	self.place.name = self.textView.text;
	self.place.createdAt = [NSDate date];

	if ([self.delegate respondsToSelector:@selector(placeNewViewController:didSavePlace:)]) {
		[self.delegate placeNewViewController:self didSavePlace:self.place];
	}
}


#pragma mark -
#pragma mark TBCoreLocationControllerDelegate protocol

- (void)didReceiveLocation:(CLLocation *)location {
	NSLog(@"location received : %@", location);
	[[TBCoreLocationController sharedInstance] startReverseGeocoderWithLocation:location];
}

- (void)didReceivePlacemark:(MKPlacemark *)placemark {
	NSLog(@"placemark received : %@", placemark);
}



#pragma mark -
#pragma mark Keyboard notifications

- (void)keyboardWillShow:(NSNotification *)notification {
	CGRect keyboardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] 
							CGRectValue];
	keyboardFrame = [self.view convertRect:keyboardFrame fromView:nil];
	CGRect textViewFrame = self.textView.frame;
	
	textViewFrame.size.height-=keyboardFrame.size.height;
	self.textView.frame = textViewFrame;	
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
	self.delegate = nil;
	[textView release];

    [super dealloc];
}


@end
