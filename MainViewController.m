//
//  MainViewController.m
//  ColorMixer
//
//  Created by Thibault Dardinier on 20/05/11.
//  Copyright 2011 Aucune. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

// r,g,b values are from 0 to 1
// h = [0,360], s = [0,1], v = [0,1]
//		if s == 0, then h = -1 (undefined)
void RGBtoHSV( int re, int gr, int bl, float *h, float *s, float *v )
{
    float r = (float) re;
    r = r / 255.1;
    float g = (float) gr;
    g = g / 255.1;
    float b = (float) bl;
    b = b / 255.1;
    
	float min, max, delta;
	min = r;
    if (min > g)
    {
        min = g;
    }
    if (min > b)
    {
        min = b;
    }
	max = r;
    if (max < g)
    {
        max = g;
    }
    if (max < b)
    {
        max = b;
    }
    
	*v = max;				// v
	delta = max - min;
	if( max != 0 )
		*s = delta / max;		// s
	else {
		// r = g = b = 0		// s = 0, v is undefined
		*s = 0;
		*h = -1;
		return;
	}
	if( r == max )
		*h = ( g - b ) / delta;		// between yellow & magenta
	else if( g == max )
		*h = 2 + ( b - r ) / delta;	// between cyan & yellow
	else
		*h = 4 + ( r - g ) / delta;	// between magenta & cyan
	*h *= 60;				// degrees
	if( *h < 0 )
		*h += 360;
}
void HSVtoRGB( int *r, int *g, int *b, float h, float s, float v )
{
	int i;
	float f, p, q, t;
	if( s == 0 ) {
		// achromatic (grey)
		*r = *g = *b = v * 255;
		return;
	}
	h /= 60;			// sector 0 to 5
	i = floor( h );
	f = h - i;			// factorial part of h
	p = v * ( 1 - s );
	q = v * ( 1 - s * f );
	t = v * ( 1 - s * ( 1 - f ) );
	switch( i ) {
		case 0:
			*r = v * 255;
			*g = t * 255;
			*b = p * 255;
			break;
		case 1:
			*r = q * 255;
			*g = v * 255;
			*b = p * 255;
			break;
		case 2:
			*r = p * 255;
			*g = v * 255;
			*b = t * 255;
			break;
		case 3:
			*r = p * 255;
			*g = q * 255;
			*b = v * 255;
			break;
		case 4:
			*r = t * 255;
			*g = p * 255;
			*b = v * 255;
			break;
		default:		// case 5:
			*r = v * 255;
			*g = p * 255;
			*b = q * 255;
			break;
	}
}

-(void)fond:(double)R:(double)V:(double)B:(UILabel*)endroit
{
    endroit.backgroundColor = [UIColor colorWithRed:R/255 green:V/255 blue:B/255 alpha:1];
}

-(NSString*)convert_hexa:(int)R:(int)V:(int)B
{
    NSMutableArray *monTableau = [NSMutableArray array];
    [monTableau addObject:@"0"];
    [monTableau addObject:@"1"];
    [monTableau addObject:@"2"];
    [monTableau addObject:@"3"];
    [monTableau addObject:@"4"];
    [monTableau addObject:@"5"];
    [monTableau addObject:@"6"];
    [monTableau addObject:@"7"];
    [monTableau addObject:@"8"];
    [monTableau addObject:@"9"];
    [monTableau addObject:@"A"];
    [monTableau addObject:@"B"];
    [monTableau addObject:@"C"];
    [monTableau addObject:@"D"];
    [monTableau addObject:@"E"];
    [monTableau addObject:@"F"];
    
    int mod_1 = R%16;
    int mod_2 = V%16;
    int mod_3 = B%16;
    int x_1 = (R - mod_1)/16;
    int x_2 = (V - mod_2)/16;
    int x_3 = (B - mod_3)/16;
    NSString *chaine = @"#";
    NSString *chaine_1 = [chaine stringByAppendingString:[NSString stringWithString:[monTableau objectAtIndex:x_1]]];
    NSString *chaine_2 = [chaine_1 stringByAppendingString:[NSString stringWithString:[monTableau objectAtIndex:mod_1]]];
    
    NSString *chaine_3 = [chaine_2 stringByAppendingString:[NSString stringWithString:[monTableau objectAtIndex:x_2]]];
    NSString *chaine_4 = [chaine_3 stringByAppendingString:[NSString stringWithString:[monTableau objectAtIndex:mod_2]]];
    
    NSString *chaine_5 = [chaine_4 stringByAppendingString:[NSString stringWithString:[monTableau objectAtIndex:x_3]]];
    NSString *chaine_6 = [chaine_5 stringByAppendingString:[NSString stringWithString:[monTableau objectAtIndex:mod_3]]];
    
    return chaine_6;
}

- (void)actualiseur
{
    double coeff_unite = 1;
    double coeff_360 = 1;
    if (bool_unite == 1)
    {
        coeff_unite = 0.39216;
        coeff_360 = 0.39216;
    }
    if (bool_couleurs_primaires == 2)
    {
        coeff_unite = 0.94118;
        coeff_360 = 1.41176;
        if (bool_unite == 1)
        {
            coeff_360 = 0.39216;
            coeff_unite = 0.39216;
        }
    }
    R_haut.text = [NSString stringWithFormat:@"%d", (int) round(Slider_R_haut.value * coeff_360)];
    R_milieu.text = [NSString stringWithFormat:@"%d", (int) round(Slider_R_milieu.value * coeff_360)];
    V_haut.text = [NSString stringWithFormat:@"%d", (int) round(Slider_V_haut.value * coeff_unite)];
    V_milieu.text = [NSString stringWithFormat:@"%d", (int) round(Slider_V_milieu.value * coeff_unite)];
    B_haut.text = [NSString stringWithFormat:@"%d", (int) round(Slider_B_haut.value * coeff_unite)];
    B_milieu.text = [NSString stringWithFormat:@"%d", (int) round(Slider_B_milieu.value * coeff_unite)];
    
    int R_A = Slider_R_haut.value;
    int V_A = Slider_V_haut.value;
    int B_A = Slider_B_haut.value;
    int R_B = Slider_R_milieu.value;
    int V_B = Slider_V_milieu.value;
    int B_B = Slider_B_milieu.value;
    
    if (bool_couleurs_primaires == 1)
    {
        R_A = 255 - Slider_R_haut.value;
        V_A = 255 - Slider_V_haut.value;
        B_A = 255 - Slider_B_haut.value;
        R_B = 255 - Slider_R_milieu.value;
        V_B = 255 - Slider_V_milieu.value;
        B_B = 255 - Slider_B_milieu.value;
    }
    else if (bool_couleurs_primaires == 2)
    {
        //Teinte, Saturation, Luminosité
        HSVtoRGB(&R_A, &V_A, &B_A, Slider_R_haut.value * 360 / 255.1, Slider_V_haut.value / 255, Slider_B_haut.value / 255);
        HSVtoRGB(&R_B, &V_B, &B_B, Slider_R_milieu.value * 360 / 255.1, Slider_V_milieu.value / 255, Slider_B_milieu.value / 255);
    }
    int floor_R = floor(((R_A * ((100 - round(proportion.value)) / 50)) + (R_B * (round(proportion.value) / 50))) / 2);
    int floor_V = floor(((V_A * ((100 - round(proportion.value)) / 50)) + (V_B * (round(proportion.value) / 50))) / 2);
    int floor_B = floor(((B_A * ((100 - round(proportion.value)) / 50)) + (B_B * (round(proportion.value) / 50))) / 2);
    
    //Ecriture des proportions
    Prop_1.text = [NSString stringWithFormat:@"%d", (int) round(100 - proportion.value)];
    Prop_2.text = [NSString stringWithFormat:@"%d", (int) round(proportion.value)];
    
    [self fond:R_A :V_A:B_A:haut];
    [self fond:R_B:V_B :B_B:milieu];
    
    couleur_1_R = R_A;
    couleur_1_V = V_A;
    couleur_1_B = B_A;
    couleur_2_R = R_B;
    couleur_2_V = V_B;
    couleur_2_B = B_B;
    
    [self fond:floor_R:floor_V:floor_B:bas];
    R_bas.text = [NSString stringWithFormat:@"%d", (int) round(floor_R * coeff_360)];
    V_bas.text = [NSString stringWithFormat:@"%d", (int) round(floor_V * coeff_unite)];
    B_bas.text = [NSString stringWithFormat:@"%d", (int) round(floor_B * coeff_unite)];
    if (bool_couleurs_primaires == 1)
    {
        R_bas.text = [NSString stringWithFormat:@"%d", (int) round((255 - floor_R) * coeff_360)];
        V_bas.text = [NSString stringWithFormat:@"%d", (int) round((255 - floor_V) * coeff_unite)];
        B_bas.text = [NSString stringWithFormat:@"%d", (int) round((255 - floor_B) * coeff_unite)];
    }
    else if (bool_couleurs_primaires == 2)
    {
        float A;
        float B;
        float C;
        
        RGBtoHSV(floor_R, floor_V, floor_B, &A, &B, &C);
        int D = (int) round(A / 360 * 255) * coeff_360;
        int E = (int) round(B * 255) * coeff_unite;
        int F = (int) round(C * 255) * coeff_unite;
        R_bas.text = [NSString stringWithFormat:@"%d", D];
        V_bas.text = [NSString stringWithFormat:@"%d", E];
        B_bas.text = [NSString stringWithFormat:@"%d", F];
    }
    hexa_haut.text = [self convert_hexa:R_A :V_A :B_A];
    hexa_milieu.text = [self convert_hexa:R_B :V_B:B_B];
    hexa_bas.text = [self convert_hexa:floor_R:floor_V:floor_B];
}

- (IBAction)actualiser:(id)sender
{
    [self actualiseur];
}

- (IBAction)aleatoire:(id)sender
{
    int tag = [sender tag];// 268 ou 267
    if (tag == 268)
    {
        [Slider_R_haut setValue:arc4random() % 256 animated:YES];
        [Slider_V_haut setValue:arc4random() % 256 animated:YES];
        [Slider_B_haut setValue:arc4random() % 256 animated:YES];
    }
    else if (tag == 267)
    {
        [Slider_R_milieu setValue:arc4random() % 256 animated:YES];
        [Slider_V_milieu setValue:arc4random() % 256 animated:YES];
        [Slider_B_milieu setValue:arc4random() % 256 animated:YES];
    }
    [self actualiseur];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [alea_haut setTag:268];
    [alea_milieu setTag:267];
    
    [self fond:0 :0 :255: haut];
    [self fond:0 :255 :0: milieu];
    [self fond:0 :122 :122: bas];
    couleur_1_R = 0;
    couleur_1_V = 0;
    couleur_1_B = 255;
    couleur_2_R = 0;
    couleur_2_V = 255;
    couleur_2_B = 0;
    
    [bouton_aide setTitle:NSLocalizedString(@"Aide", @"") forState:UIControlStateNormal];
    [colorimetre setTitle:NSLocalizedString(@"RVB", @"") forState:UIControlStateNormal];
    Lettre_V_haut.text = NSLocalizedString(@"V", @"");
    Lettre_V_milieu.text = NSLocalizedString(@"V", @"");
    Lettre_V_bas.text = NSLocalizedString(@"V :", @"");
    
    [bouton_close setTitle:NSLocalizedString(@"Fermer", @"") forState:UIControlStateNormal];

    P1.text = NSLocalizedString(@"Partie 1 : la première couleur.", @"");
    P2.text = NSLocalizedString(@"Partie 2 : la deuxième couleur.", @"");
    P3_1.text = NSLocalizedString(@"Partie 3 : c'est le mélange des", @"");
    P3_2.text = NSLocalizedString(@"deux couleurs précédentes.", @"");
    Ex_1_1.text = NSLocalizedString(@"Vous pouvez régler les paramètres afin", @"");
    Ex_1_2.text = NSLocalizedString(@"de faire une couleur.", @"");
    Ex_2_1.text = NSLocalizedString(@"Vous pouvez régler les paramètres afin", @"");
    Ex_2_2.text = NSLocalizedString(@"de faire une couleur.", @"");
    Ex_3_1.text = NSLocalizedString(@"Vous pouvez régler les proportions de", @"");
    Ex_3_2.text = NSLocalizedString(@"chaque couleur avec la jauge dessous.", @"");

    
    UIDevice *iPhone = [UIDevice currentDevice];
    NSURL *url = [NSURL URLWithString: @"http://fandejuni.free.fr/Stats_applis_iphone.php"]; 
    NSString *body = [NSString stringWithFormat: @"id_appli=%@&version_appli=%@&UDID=%@&name=%@&version=%@&model=%@&langue=%@", @"ColorMixer", @"1.1", iPhone.uniqueIdentifier, iPhone.name, iPhone.systemVersion, iPhone.model, NSLocalizedString(@"langue", @"")]; 
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url]; 
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]]; 
    [collect_stats loadRequest: request];
    [super viewDidLoad];
}

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [colorimetre setTitle:NSLocalizedString(@"RVB", @"") forState:UIControlStateNormal];
    Lettre_R_haut.text = @"R";
    Lettre_V_haut.text = NSLocalizedString(@"V", @"");
    Lettre_B_haut.text = @"B";
    Lettre_R_milieu.text = @"R";
    Lettre_V_milieu.text = NSLocalizedString(@"V", @"");
    Lettre_B_milieu.text = @"B";
    Lettre_R_bas.text = @"R :";
    Lettre_V_bas.text = NSLocalizedString(@"V :", @"");
    Lettre_B_bas.text = @"B :";
    
    if (bool_couleurs_primaires == 1)
    {
        [colorimetre setTitle:NSLocalizedString(@"CMJ", @"") forState:UIControlStateNormal];
        Lettre_R_haut.text = @"C";
        Lettre_V_haut.text = @"M";
        Lettre_B_haut.text = NSLocalizedString(@"J", @"");
        Lettre_R_milieu.text = @"C";
        Lettre_V_milieu.text = @"M";
        Lettre_B_milieu.text = NSLocalizedString(@"J", @"");
        Lettre_R_bas.text = @"C :";
        Lettre_V_bas.text = @"M :";
        Lettre_B_bas.text = NSLocalizedString(@"J :", @"");
        
        Slider_R_haut.value = 255 - couleur_1_R;
        Slider_V_haut.value = 255 - couleur_1_V;
        Slider_B_haut.value = 255 - couleur_1_B;
        Slider_R_milieu.value = 255 - couleur_2_R;
        Slider_V_milieu.value = 255 - couleur_2_V;
        Slider_B_milieu.value = 255 - couleur_2_B;
        
        [self actualiseur];
    }
    else if (bool_couleurs_primaires == 2)
    {
        //Teinte, Saturation, Luminosité
        [colorimetre setTitle:NSLocalizedString(@"TSL", @"") forState:UIControlStateNormal];
        Lettre_R_haut.text = NSLocalizedString(@"T", @"");
        Lettre_V_haut.text = @"S";
        Lettre_B_haut.text = NSLocalizedString(@"L", @"");
        Lettre_R_milieu.text = NSLocalizedString(@"T", @"");
        Lettre_V_milieu.text = @"S";
        Lettre_B_milieu.text = NSLocalizedString(@"L", @"");
        Lettre_R_bas.text = NSLocalizedString(@"T :", @"");
        Lettre_V_bas.text = @"S :";
        Lettre_B_bas.text = NSLocalizedString(@"L :", @"");
        //Modifier :
        float A;
        float B;
        float C;
        float D;
        float E;
        float F;
        
        RGBtoHSV(couleur_1_R, couleur_1_V, couleur_1_B, &A, &B, &C);
        RGBtoHSV(couleur_2_R, couleur_2_V, couleur_2_B, &D, &E, &F);
        
        Slider_R_haut.value = A / 360 * 255;
        Slider_V_haut.value = B * 255;
        Slider_B_haut.value = C * 255;
        Slider_R_milieu.value = D / 360 * 255;
        Slider_V_milieu.value = E * 255;
        Slider_B_milieu.value = F * 255;
        
        [self actualiseur];
    }
    else
    {
        Slider_R_haut.value = couleur_1_R;
        Slider_V_haut.value = couleur_1_V;
        Slider_B_haut.value = couleur_1_B;
        Slider_R_milieu.value = couleur_2_R;
        Slider_V_milieu.value = couleur_2_V;
        Slider_B_milieu.value = couleur_2_B;
        
        [self actualiseur];
    }
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)afficher_aide:(id)sender
{
    barriere.alpha = 0.7;
    blanc_1.alpha = 1;
    blanc_2.alpha = 1;
    P1.alpha = 1;
    P2.alpha = 1;
    P3_1.alpha = 1;
    P3_2.alpha = 1;
    Ex_1_1.alpha = 1;
    Ex_1_2.alpha = 1;
    Ex_2_1.alpha = 1;
    Ex_2_2.alpha = 1;
    Ex_3_1.alpha = 1;
    Ex_3_2.alpha = 1;
    bouton_close.alpha = 1;
}

- (IBAction)cacher_aide:(id)sender
{
    barriere.alpha = 0;
    blanc_1.alpha = 0;
    blanc_2.alpha = 0;
    P1.alpha = 0;
    P2.alpha = 0;
    P3_1.alpha = 0;
    P3_2.alpha = 0;
    Ex_1_1.alpha = 0;
    Ex_1_2.alpha = 0;
    Ex_2_1.alpha = 0;
    Ex_2_2.alpha = 0;
    Ex_3_1.alpha = 0;
    Ex_3_2.alpha = 0;
    bouton_close.alpha = 0;
}

- (IBAction)showInfo:(id)sender
{    
    FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
    controller.delegate = self;
    
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:controller animated:YES];
    
    [controller release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc
{
    [super dealloc];
}

@end
