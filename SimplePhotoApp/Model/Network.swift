//
//  Network.swift
//  SimplePhotoApp
//
//  Created by Malte Schoppe on 23.02.21.
//

import Foundation

class Network {
    
    //MARK:- Album functions
    
    /// This function fetches albums from a website for pseudo JSON data.
    ///
    /// - Parameter completionHandler: Asynchrounious callback.
    ///
    /// - Returns: An Array of Album Objects or a NetworkError.
    static func getAlbumData(completionHandler: @escaping ([Album]?, NetworkError?) -> Void) {
        
        if let url = URL(string: "https://jsonplaceholder.typicode.com/albums") {
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) { (data, response, err) in
                
                // 200 is the status for a successfull request
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
    
    //MARK:- Photo functions
    
    /// This function fetches photos from a specified album within a website that presents pseudo JSON data.
    ///
    ///
    /// - Parameter albumId: The albumId of the top level album from which you want to get the photos.
    ///
    /// - Parameter completionHandler: Asynchrounious callback.
    ///
    ///
    /// - Returns: An Array of Photo Objects or a NetworkError.
    static func getPhotosForAlbum(albumId: Int, completionHandler: @escaping ([Photo]?, NetworkError?) -> Void) {
        
        if let url = URL(string: "https://jsonplaceholder.typicode.com/albums/\(albumId)/photos") {
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) { (data, response, err) in
                
                // 200 is the status for a successfull request
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
                            let photos = try JSONDecoder().decode([Photo].self, from: data)

                            completionHandler(photos, nil)
                        } catch {
                            
                            completionHandler(nil, .fetchError)
                        }
                    }
                }
            }.resume()
        }
    }
}
