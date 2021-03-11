//
//  Network.swift
//  SimplePhotoApp
//
//  Created by Malte Schoppe on 23.02.21.
//

import Foundation

class Network {
    
    //MARK:- Get Album
    
    /// This function fetches albums from a website for pseudo JSON data.
    ///
    /// - Parameter completionHandler: Asynchrounious callback.
    ///
    /// - Returns: An Array of Album Objects or a NetworkError.
    static public func getAlbumData(completionHandler: @escaping ([Album]?, NetworkError?) -> Void) {
        
        getData(albumID: nil) { (data, networkError) in
            DispatchQueue.main.async {
                if let data = data {
                    
                    do {
                        let albums = try JSONDecoder().decode([Album].self, from: data)
                        
                        completionHandler(albums, nil)
                    } catch {
                        
                        completionHandler(nil, .fetchError)
                    }
                } else {
                    completionHandler(nil, networkError)
                }
            }
        }
    }
    
    //MARK:- Get Photos
    
    /// This function fetches photos from a specified album within a website that presents pseudo JSON data.
    ///
    ///
    /// - Parameter albumId: The albumId of the top level album from which you want to get the photos.
    ///
    /// - Parameter completionHandler: Asynchrounious callback.
    ///
    ///
    /// - Returns: An Array of Photo Objects or a NetworkError.
    static public func getPhotosForAlbum(albumId: Int, completionHandler: @escaping ([Photo]?, NetworkError?) -> Void) {
        
        getData(albumID: albumId) { (data, networkError) in
            if let data = data {

                do {
                    let photos = try JSONDecoder().decode([Photo].self, from: data)

                    completionHandler(photos, nil)
                } catch {
                    
                    completionHandler(nil, .fetchError)
                }
            } else {
                completionHandler(nil, networkError)
            }
        }
    }
    
    
    //MARK:- Get URL
    /// Construct the url for the URL Request and return it.
    /// If an albumID is set, the path is extended to lead to the photos of the specified album.
    static private func getURL(albumID: Int?) -> URL? {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "jsonplaceholder.typicode.com"
        if let id = albumID {
            urlComponents.path = "/albums/\(id)/photos"
        } else {
            urlComponents.path = "/albums"
        }
        
        return urlComponents.url
    }
    
    
    //MARK:- Get Data
    /// Fetch the JSON data through an URLSession
    static private func getData(albumID: Int?, completionHandler: @escaping (Data?, NetworkError?) -> Void) {
        
        if let url = getURL(albumID: albumID) {
            
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
                        //Successfully fetched data
                        
                        completionHandler(data, nil)
                    } else {
                        completionHandler(nil, .fetchError)
                    }
                }
            }.resume()
        }
    }
}
