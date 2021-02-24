//
//  Network.swift
//  SimplePhotoApp
//
//  Created by Malte Schoppe on 23.02.21.
//

import Foundation

class Network {
    
    static func getAlbumData(completionHandler: @escaping ([Album]?, NetworkError?) -> Void) {
        
        if let url = URL(string: "https://jsonplaceholder.typicode.com/albums") {
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) { (data, response, err) in
                
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 200
                
                if statusCode != 200 {
                    
                    completionHandler(nil, .requestError)
                    
                    return
                }
                
                if let error = err {
                    print("We have an error: \(error.localizedDescription)")
                    
                    completionHandler(nil, .requestError)
                } else {
                    if let data = data {

                        do {
                            let albums = try JSONDecoder().decode([Album].self, from: data)

                            completionHandler(albums, nil)
                        } catch {
                            
                            completionHandler(nil, .fetchError)
                        }
                    }
                }
            }.resume()
        }
    }
}
