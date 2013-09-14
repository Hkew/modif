//
//  RestAPI.m
//  Zero Gachis
//
//  Created by Tony Cois on 11/07/13.
//  Copyright (c) 2013 Zero Gachis. All rights reserved.
//

#import "RestAPI.h"
#import <RestKit/RestKit.h>
#import "Ville.h"
#import "Conf.h"
#import "Enseigne.h"
#import "Magasin.h"
#import "Partenaire.h"
#import "Vote.h"
#import "AppDelegate.h"
#import "Mail.h"
#import "Product.h"
#import <AsyncImageView/AsyncImageView.h>




@implementation RestAPI


@synthesize Delegate;

-(void)conf{

    Delegate = [[UIApplication sharedApplication]delegate];
  
    
    //On va définir notre app base
    manager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"https://zero-gachis.com/api/v1/"]];
    
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:Delegate.managedObjectModel];
    manager.managedObjectStore = managedObjectStore;
    
    
   
    
}

-(void)getVilles:(NSString *)ville{
  
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
    
    //On créé notre mapping
    RKObjectMapping* articleMapping = [RKObjectMapping mappingForClass:[Ville class]];
    [articleMapping addAttributeMappingsFromDictionary:@{
     @"agglomeration": @"agglomeration",
     @"code": @"code",
     @"departement": @"departement",
     @"id": @"idVille",
     @"latitude": @"latitude",
     @"longitude": @"longitude",
     @"nom": @"nom",
     @"pays": @"pays",
     @"precision": @"precision",
     @"region": @"region"
     }];

    
    //On définit la régle de récupération des données
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:articleMapping pathPattern:nil keyPath:@"objects" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    //On définit l'url
    NSURL *URL = [NSURL URLWithString:[[NSString alloc] initWithFormat:@"%@ville/%@/?format=json",baseURL,[ville stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[ responseDescriptor ]];
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        [Delegate.mainViewController setTabVilles:mappingResult.array];
        
        RKLogInfo(@"Load collection of Articles: %@", mappingResult.array);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
    }];
    
    [objectRequestOperation start];
    
   
   
}

-(void)getMagasins:(Ville *)ville
{
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
 
    
    /** On configure les différents mappings ***/
    
    RKObjectMapping* enseigneMapping = [RKObjectMapping mappingForClass:[Enseigne class]];
    [enseigneMapping addAttributeMappingsFromDictionary:@{
     @"logo": @"logo",
     @"logo_mobile": @"logo_mobile",
     @"nom": @"nom",
     @"resource_uri": @"resource_uri"
     }];

    
    RKObjectMapping* magasinMapping = [RKObjectMapping mappingForClass:[Magasin class]];
    [magasinMapping addAttributeMappingsFromDictionary:@{
     @"adresse1": @"adresse1",
     @"adresse2": @"adresse2",
     @"code_postal": @"code_postal",
     @"distance": @"distance",
     @"drive": @"drive",
     @"fax": @"fax",
     @"id": @"idMagasin",
     @"latitude": @"latitude",
     @"longitude": @"longitude",
     @"ouvert": @"ouvert",
     @"pays": @"pays",
     @"surface": @"surface",
     @"tel": @"tel",
     @"ville": @"ville",
     @"vote_client": @"vote_client",
     @"votes_contre": @"votes_contre",
     @"votes_pour": @"votes_pour"
     }];

    RKObjectMapping* partenaireMapping = [RKObjectMapping mappingForClass:[Partenaire class]];
    [partenaireMapping addAttributeMappingsFromDictionary:@{
     @"adresse1": @"adresse1",
     @"adresse2": @"adresse2",
     @"code_postal": @"code_postal",
     @"distance": @"distance",
     @"drive": @"drive",
     @"fax": @"fax",
     @"horaire_fermeture": @"horaire_fermeture",
     @"horaire_ouverture": @"horaire_ouverture",
     @"id": @"idPartenaire",
     @"latitude": @"latitude",
     @"longitude": @"longitude",
     @"ouvert": @"ouvert",
     @"pays": @"pays",
     @"surface": @"surface",
     @"tel": @"tel",
     @"ville": @"ville",
     @"reduction_moyenne": @"reduction_moyenne",
     @"somme_economies": @"somme_economies",
     @"somme_produits": @"somme_produits"
     }];

    /*** fin de la configuration des mappings ***/
    RKDynamicMapping *dynamicMapping = [RKDynamicMapping new];
    
    
    [magasinMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"enseigne"
                                                                                   toKeyPath:@"enseigne"
                                                                                 withMapping:enseigneMapping]];
    
    
    [partenaireMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"enseigne"
                                                                                   toKeyPath:@"enseigne"
                                                                                 withMapping:enseigneMapping]];

    
    
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:dynamicMapping pathPattern:nil keyPath:@"objects" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
    
    
    [dynamicMapping setObjectMappingForRepresentationBlock:^RKObjectMapping *(id representation) {
        if ([[representation valueForKey:@"partenaire"] isEqualToNumber:[[NSNumber alloc] initWithInt:0]]) {
            return magasinMapping;
        } else if ([[representation valueForKey:@"partenaire"] isEqualToNumber:[[NSNumber alloc] initWithInt:1]]) {
            return partenaireMapping;
        }
        
        return nil;
    }];
    
    NSLog(@"%@",[[NSString alloc] initWithFormat:@"%@magasins/%f/%f/ios/%@/?format=json",baseURL,[ville.latitude floatValue],[ville.longitude floatValue],[[NSUserDefaults standardUserDefaults] objectForKey:@"udid"]]);
    
    //On définit l'url
    NSURL *URL = [NSURL URLWithString:[[NSString alloc] initWithFormat:@"%@magasins/%f/%f/ios/%@/?format=json",baseURL,[ville.latitude floatValue],[ville.longitude floatValue],[[NSUserDefaults standardUserDefaults] objectForKey:@"udid"]]];
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[ responseDescriptor ]];
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        [Delegate.mainViewController setTabMagasins:mappingResult.array];
       
        RKLogInfo(@"Load collection of Articles: %@", mappingResult.array);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
        
        [Delegate.mainViewController getError];
    }];
    
    [objectRequestOperation start];
     
    
    
    
}

-(void)getProducts:(NSNumber*)idPartenaire
{
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
    
    //On créé notre mapping
    RKObjectMapping* productMapping = [RKObjectMapping mappingForClass:[Product class]];
    [productMapping addAttributeMappingsFromDictionary:@{
     @"date_derniere_maj": @"date_derniere_maj",
     @"derniere_maj_h": @"derniere_maj_h",
     @"derniere_maj_j": @"derniere_maj_j",
     @"dlc": @"dlc",
     @"jours_restants": @"jours_restants",
     @"lot": @"lot",
     @"marque": @"marque",
     @"nom": @"nom",
     @"photo": @"photo",
     @"poids": @"poids",
     @"prix_final": @"prix_final",
     @"prix_initial": @"prix_initial",
     @"quantite_restante": @"quantite_restante",
     @"reduction": @"reduction",
     @"unite": @"unite"
     }];
    
    
    //On définit la régle de récupération des données
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:productMapping pathPattern:nil keyPath:@"objects" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    //On définit l'url
    NSURL *URL = [NSURL URLWithString:[[NSString alloc] initWithFormat:@"%@references/%d/?format=json",baseURL,[idPartenaire integerValue]]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[ responseDescriptor ]];
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        [Delegate.listingViewController setTabProducts:mappingResult.array];
        
        RKLogInfo(@"Load collection of Articles: %@", mappingResult.array);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
        [Delegate.listingViewController getError];
    }];
    
    [objectRequestOperation start];
    

    
}

-(void)sendVote:(NSNumber*)vote forMag:(NSNumber*)idMagasin
{
    NSDictionary *dictionary = @{ @"shop_id":idMagasin, @"client": @"ios",@"udid": [[NSUserDefaults standardUserDefaults] objectForKey:@"udid"], @"vote":vote};
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:nil];
    
    if (!jsonData)
    {
        NSAssert(FALSE, @"Unable to serialize JSON from NSDict to NSData");
    }
    else
    {
        
        RKObjectMapping *postObjectMapping = [RKObjectMapping requestMapping];
        [postObjectMapping addAttributeMappingsFromDictionary:@{
         @"shop_id" : @"shop_id",
         @"client" : @"client",
         @"udid" : @"udid",
         @"vote" :  @"vote" }];
        
        RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:postObjectMapping objectClass:[Vote class] rootKeyPath:nil];
        
        RKObjectMapping *returnedObjectMapping = [RKObjectMapping mappingForClass:[Vote class]];
        [returnedObjectMapping addAttributeMappingsFromDictionary:@{
         @"client" : @"client",
         @"shop_id": @"shop_id",
         @"udid": @"udid",
         @"vote": @"vote",
         @"votes_contre": @"votes_contre",
         @"votes_pour": @"votes_pour"}];
        
        NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
        [indexSet addIndex:201];
        [indexSet addIndex:202];
        
        
        
        RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:returnedObjectMapping pathPattern:nil keyPath:nil statusCodes:indexSet];
        
       

          Vote *objectToBePosted = [Vote new];
        [objectToBePosted setClient:@"ios"];
        [objectToBePosted setVote:vote];
        [objectToBePosted setShop_id:idMagasin];
        [objectToBePosted setUdid:[[NSUserDefaults standardUserDefaults] objectForKey:@"udid"]];

        
        RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"https://zero-gachis.com/"]];
        objectManager.requestSerializationMIMEType=RKMIMETypeJSON;
        [objectManager addRequestDescriptor:requestDescriptor];
        [objectManager addResponseDescriptor:responseDescriptor];
      
        
        NSMutableURLRequest *request = [objectManager requestWithObject:objectToBePosted method:RKRequestMethodPOST path:@"api/v1/vote/?format=json" parameters:nil];
        
        RKObjectRequestOperation *operation = [objectManager objectRequestOperationWithRequest:request success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                 NSLog(@"Success block: %@", mappingResult.array);
            [Delegate.noPartnerViewController setVote:[mappingResult.array objectAtIndex:0]];
            
            } failure: ^(RKObjectRequestOperation *operation, NSError *error) {
                NSLog(@"Failed with error: %@", [error localizedDescription]);
                [Delegate.noPartnerViewController getError];
                
        }];
        
        [objectManager enqueueObjectRequestOperation:operation];
         
        

    }
    
       
    
}


- (void)sendMail:(NSString *)mail forMag:(NSNumber *)idMagasin
{
    NSDictionary *dictionary = @{ @"shop_id":idMagasin, @"client": @"ios",@"udid": [[NSUserDefaults standardUserDefaults] objectForKey:@"udid"], @"email":mail};
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:nil];
    
    if (!jsonData)
    {
        NSAssert(FALSE, @"Unable to serialize JSON from NSDict to NSData");
    }
    else
    {
        
        RKObjectMapping *postObjectMapping = [RKObjectMapping requestMapping];
        [postObjectMapping addAttributeMappingsFromDictionary:@{
         @"shop_id" : @"shop_id",
         @"client" : @"client",
         @"udid" : @"udid",
         @"email" :  @"email" }];
        
        RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:postObjectMapping objectClass:[Mail class] rootKeyPath:nil];
        
        RKObjectMapping *returnedObjectMapping = [RKObjectMapping mappingForClass:[Mail class]];
        [returnedObjectMapping addAttributeMappingsFromDictionary:@{
         @"client" : @"client",
         @"shop_id": @"shop_id",
         @"udid": @"udid",
         @"email": @"email"}];
        
        NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
        [indexSet addIndex:201];
        [indexSet addIndex:202];
        
        RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:returnedObjectMapping pathPattern:nil keyPath:nil statusCodes:indexSet];
        
        
        
        Mail *objectToBePosted = [Mail new];
        [objectToBePosted setClient:@"ios"];
        [objectToBePosted setEmail:mail];
        [objectToBePosted setShop_id:idMagasin];
        [objectToBePosted setUdid:[[NSUserDefaults standardUserDefaults] objectForKey:@"udid"]];
        
        
        RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"https://zero-gachis.com/"]];
        objectManager.requestSerializationMIMEType=RKMIMETypeJSON;
        [objectManager addRequestDescriptor:requestDescriptor];
        [objectManager addResponseDescriptor:responseDescriptor];
        
        
        NSMutableURLRequest *request = [objectManager requestWithObject:objectToBePosted method:RKRequestMethodPOST path:@"api/v1/star/?format=json" parameters:nil];
        
        RKObjectRequestOperation *operation = [objectManager objectRequestOperationWithRequest:request success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
          
            [Delegate.noPartnerViewController setMerci];
            
        } failure: ^(RKObjectRequestOperation *operation, NSError *error) {
            NSLog(@"Failed with error: %@", [error localizedDescription]);
            [Delegate.noPartnerViewController getError];
        }];
        
        [objectManager enqueueObjectRequestOperation:operation];
        
        
        
    }
    
    

    
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"didReceiveResponse");
    [responseData setLength:0];
}



@end
