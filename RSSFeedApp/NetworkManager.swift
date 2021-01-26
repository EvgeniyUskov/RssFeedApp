//
//  NetworkManager.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 25.01.2021.
//

import Foundation

//MARK: Protocols
public protocol NetworkManagerProtocol {
}

//MARK: NetworkManager
public class NetworkManager {
    //MARK: Properties
    
    //MARK: Init methods
    public init() {
    }
    
}

//MARK: NetworkManagerProtocol Implementation methods
extension NetworkManager: NetworkManagerProtocol {
//
//    public func fetchAlbums(searchTerm: String,
//                            completion: @escaping ([Album]?) -> ()) {
//        let searchUrl = FeatureList().featureFlag.musicUrl
//        let limit = FeatureList().featureFlag.itemsLimitCount
//        let suffix = "?entity=album&attribute=albumTerm&offset=0&limit=\(limit)&term=\(searchTerm.urlifySpaces())"
//        guard let url = URL(string: "\(searchUrl)\(suffix)") else { return }
//        
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if error != nil {
//                print(error!.localizedDescription)
//            }
//            if let data = data {
//                let objects = self.jsonManager?.parseAlbums(from: data)
//                if let objects = objects {
//                    completion(objects.results)
//                } else {
//                    print("Failed to decode JSON")
//                    completion(nil)
//                }
//            }
//        }.resume()
//    }
//    
//    public func fetchTracks(collectionId: Int,
//                            completion: @escaping ([Track]?) -> ()) {
//        let lookupUrl = FeatureList().featureFlag.lookupUrl
//        let suffix = "?entity=song&id=\(collectionId)"
//        guard let url = URL(string: "\(lookupUrl)\(suffix)") else { return }
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if error != nil {
//                print(error!.localizedDescription)
//            }
//            if let data = data {
//                let objects = self.jsonManager?.parseTracks(from: data)
//                if let objects = objects {
//                    let tracksOnly = objects.results.filter{ $0.trackName != nil && $0.trackNumber != nil}
//                    completion(tracksOnly)
//                } else {
//                    print("Failed to decode JSON")
//                    completion(nil)
//                }
//            }
//        }.resume()
//    }
   
}

