//
//  FlipsideViewController.m
//  ColorMixer
//
//  Created by Thibault Dardinier on 20/05/11.
//  Copyright 2011 Aucune. All rights reserved.
//

#import "FlipsideViewController.h"


@implementation FlipsideViewController

@synthesize delegate=_delegate;

-(IBAction)set_valeur_colori
{
    bool_couleurs_primaires = couleurs_primaires.selectedSegmentIndex;
}

-(IBAction)set_valeur_unite
{
    bool_unite = unite.selectedSegmentIndex;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    couleurs_primaires.selectedSegmentIndex = bool_couleurs_primaires;
    unite.selectedSegmentIndex = bool_unite;
    
    [couleurs_primaires setTitle:NSLocalizedString(@"RVB", @"") forSegmentAtIndex:0];
    [couleurs_primaires setTitle:NSLocalizedString(@"CMJ", @"") forSegmentAtIndex:1];
    [couleurs_primaires setTitle:NSLocalizedString(@"TSL", @"") forSegmentAtIndex:2];

    [unite setTitle:NSLocalizedString(@"Usuelle", @"") forSegmentAtIndex:0];
    [unite setTitle:NSLocalizedString(@"Pourcentage", @"") forSegmentAtIndex:1];
        
    lab_profil.text = NSLocalizedString(@"Profil colorimétrique :", @"");
    lab_unite.text = NSLocalizedString(@"Unité :", @"");
    lab_RVB.text = NSLocalizedString(@"RVB : Rouge, Vert, Bleu", @"");
    lab_CMJ.text = NSLocalizedString(@"CMJ : Cyan, Magenta, Jaune", @"");
    lab_TSL.text = NSLocalizedString(@"TSL : Teinte, Saturation, Luminance", @"");
    lab_result.text = NSLocalizedString(@"Le résultat peut ne pas refléter la réalité.", @"");


    [super viewDidLoad];
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];  
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end
