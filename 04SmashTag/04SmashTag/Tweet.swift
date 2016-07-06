//
//  Tweet.swift
//  04SmashTag
//
//  Created by Julio Franco on 7/5/16.
//  Copyright © 2016 Julio Franco. All rights reserved.
//

import Foundation
import CoreData
import Twitter

class Tweet: NSManagedObject {

    // If tweet with unique id exists in DB then return it
    // Otherwise create it
    class func tweetWithTwitterInfo(twitterInfo: Twitter.Tweet, inManagedObjectContext context: NSManagedObjectContext) -> Tweet? {
        
        let request = NSFetchRequest(entityName: "Tweet")
        request.predicate = NSPredicate(format: "unique = %@", twitterInfo.id)
        
        if let tweet = (try? context.executeFetchRequest(request))?.first as? Tweet {
            return tweet
        } else if let tweet = NSEntityDescription.insertNewObjectForEntityForName("Tweet", inManagedObjectContext: context) as? Tweet {
            tweet.unique = twitterInfo.id
            tweet.text = twitterInfo.text
            tweet.posted = twitterInfo.created
            tweet.tweeter = TwitterUser.twitterUserWithTwitterInfo(twitterInfo.user, inManagedObjectContext: context)
            return tweet
        }        
        return nil
    }

}


