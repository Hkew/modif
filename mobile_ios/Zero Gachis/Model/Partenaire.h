//
//  Partenaire.h
//  Zero Gachis
//
//  Created by Tony Cois on 12/07/13.
//  Copyright (c) 2013 Zero Gachis. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Enseigne;

@interface Partenaire : NSObject



@property (nonatomic, retain) NSString * adresse1;
@property (nonatomic, retain) NSString * adresse2;
@property (nonatomic, retain) NSString * code_postal;
@property (nonatomic, retain) NSString * date_ouverture;
@property (nonatomic, retain) NSString * distance;
@property (nonatomic, retain) NSNumber * drive;
@property (nonatomic, retain) Enseigne * enseigne;
@property (nonatomic, retain) NSString * fax;
@property (nonatomic, retain) NSString * horaire_fermeture;
@property (nonatomic, retain) NSString * horaire_ouverture;
@property (nonatomic, retain) NSNumber * idPartenaire;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSNumber * ouvert;
@property (nonatomic, retain) NSString * pays;
@property (nonatomic, retain) NSNumber * somme_economies;
@property (nonatomic, retain) NSNumber * somme_produits;
@property (nonatomic, retain) NSNumber * reduction_moyenne;
@property (nonatomic, retain) NSNumber * surface;
@property (nonatomic, retain) NSString * tel;
@property (nonatomic, retain) NSString * ville;




@end
