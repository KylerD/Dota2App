//
//  PrefetchManager.m
//  Dota2App
//
//  Created by Systems Kainos on 03/03/2013.
//
//

#import "FetchManager.h"
#import "StackMob.h"
#import "AppDelegate.h"
#import "Hero+DAO.h"

@implementation FetchManager
@synthesize fetchQueue=_fetchQueue;


-(NSManagedObjectContext*)moc{
    AppDelegate *del = [[UIApplication sharedApplication] delegate];
    return [del.coreDataStore contextForCurrentThread];
}


-(SMDataStore*)SMDataStore{
    AppDelegate *del = [[UIApplication sharedApplication] delegate];
    return [del.client dataStore];
}


-(dispatch_queue_t)getFetchQueue{
    
    if(!_fetchQueue){
        
        //dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        _fetchQueue = dispatch_queue_create("fetchQueue",NULL);
    }
    
    return _fetchQueue;
}

#pragma mark fetched requests

#define heroFetchEntiy @"Hero"
-(NSFetchRequest*)heroFetchRequest{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity;
    entity = [NSEntityDescription entityForName:heroFetchEntiy inManagedObjectContext:[self moc]];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"primaryAttribute" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    
    NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor2, sortDescriptor1, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    return fetchRequest;
    
}

#define abilityFetchEntiy @"Ability"
-(NSFetchRequest*)abilitiesFetchRequest{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity;
    entity = [NSEntityDescription entityForName:abilityFetchEntiy inManagedObjectContext:[self moc]];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor1, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    return fetchRequest;
    
}

#define roleFetchEntiy @"Roles"
-(NSFetchRequest*)rolesFetchRequest{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity;
    entity = [NSEntityDescription entityForName:roleFetchEntiy inManagedObjectContext:[self moc]];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor1, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    return fetchRequest;
    
}

#define nicknameFetchEntiy @"Nickname"
-(NSFetchRequest*)nicknamesFetchRequest{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity;
    entity = [NSEntityDescription entityForName:nicknameFetchEntiy inManagedObjectContext:[self moc]];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor1, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    return fetchRequest;
    
}


#pragma prefetch functions

-(void)fetchAll{
    
    dispatch_async([self getFetchQueue], ^{
        // Perform long running process
        [self fetchHeroes];
        //[self fetchAbilities];
    });
    
    
    
    //[self fetchRoles];
    //[self fetchNicknames];
}


-(void)fetchNicknames{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),^{
        
        NSFetchRequest * allHeroesRequest = [self rolesFetchRequest];
        
        [[self moc] executeFetchRequest:allHeroesRequest onSuccess:^(NSArray* a){
            
        } onFailure:^(NSError*e){
            
        }];
        
    });
}

-(void)fetchRoles{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),^{
        
        NSFetchRequest * allHeroesRequest = [self rolesFetchRequest];
        
        [[self moc] executeFetchRequest:allHeroesRequest onSuccess:^(NSArray* a){
            
        } onFailure:^(NSError*e){
            
        }];
        
    });
}

-(void)fetchAbilities{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),^{
        
        NSFetchRequest * allHeroesRequest = [self abilitiesFetchRequest];
        
        [[self moc] executeFetchRequest:allHeroesRequest onSuccess:^(NSArray* a){
            
        } onFailure:^(NSError*e){
            
        }];
        
    });
}

-(void)fetchHeroes{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),^{
        
        //NSFetchRequest * allHeroesRequest = [self heroFetchRequest];
         NSEntityDescription *entity = [NSEntityDescription entityForName:@"Hero" inManagedObjectContext:[self moc]];
        SMQuery * allHeroes = [[SMQuery alloc] initWithEntity:entity];
        
        SMRequestOptions * depthOptions = [SMRequestOptions optionsWithExpandDepth:3];
        
        
        [[self SMDataStore] performQuery:allHeroes options:depthOptions onSuccess:^(NSArray* results){
            NSLog(@"RESULTS:\n%@",results);
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),^{
                for (NSDictionary * heroDictionary in results) {
                    [Hero heroFromSMDictionary:heroDictionary];
                }
                [Hero saveDatabase];
                
                [[NSNotificationCenter defaultCenter]
                 postNotificationName:@"HeroFetchComplete"
                 object:nil];
            });
            
            
        } onFailure:^(NSError* error){
            
        }];
        
//        [[self SMDataStore] performQuery:allHeroes onSuccess:^(NSArray* results){
//           NSLog(@"RESULTS:\n%@",results);
//            
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),^{
//                for (NSDictionary * heroDictionary in results) {
//                    [Hero heroFromSMDictionary:heroDictionary];
//                }
//                [Hero saveDatabase];
//            });
//            
//            
//        } onFailure:^(NSError* error){
//            
//        }];
        
    });
}

@end
