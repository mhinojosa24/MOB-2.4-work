//
//  PhotoFetchService.swift
//  PhotoMatic
//
//  Created by Student Loaner 3 on 6/28/19.
//  Copyright © 2019 Make School. All rights reserved.
//

import UIKit

struct PhotoFetchService {
    
    //TODO: Insert your API Key here
    private let APIKey = "6340e1114cbf7b562a126cb67c3f91e1"
    private let baseURLString = "https://api.flickr.com/services/rest"
    private let flickrMethod = "flickr.interestingness.getList"
    
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    
    
    public enum PhotoFetchResult {
        case success([Photo])
        case failure(Error)
    }
    
    public enum ImageFetchResult {
        case success(UIImage)
        case failure(Error)
    }
    
    public enum FlickrAPIError: Error {
        case invalidJSONData
    }
    
    public enum ImageRequestError: Error {
        case imageCreationError
    }
    
    
    
    //MARK: Network calls and JSON processing functions
    
    
    
    func processImageRequest(data: Data?, url: URL?, imageCache:  NSCache<AnyObject, AnyObject>, error: Error?) -> ImageFetchResult {
        
        if let cachedImage = imageCache.object(forKey: url as AnyObject) as? UIImage {
            return .success(cachedImage)
        } else {
            guard let imageData = data, let imageToCache = UIImage(data: imageData) else {
                    // Could not create an image from data
                    if data == nil {
                        return .failure(error!)
                    } else {
                        return .failure(ImageRequestError.imageCreationError)
                    }
            }
            imageCache.setObject(imageToCache, forKey: url as AnyObject)
            return .success(imageToCache)
        }
       
    }
        
    func fetchImage(for photo: Photo, imageCache: NSCache<AnyObject, AnyObject>, completion: @escaping (ImageFetchResult) -> Void) {
        
        guard let photoURL = photo.remoteURL else {
            preconditionFailure("Photo expected to have a remote URL.")
        }
        
        let request = URLRequest(url: photoURL)
        let task = self.session.dataTask(with: request) {(data, response, error) -> Void in
            
            let result = self.processImageRequest(data: data, url: photoURL, imageCache: imageCache, error: error)
            
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    
    func urlBuilder(parameters: [String:String]?) -> URL {
        var components = URLComponents(string: baseURLString)!
        
        var queryItems = [URLQueryItem]()
        
        let baseParams = [
            "method": flickrMethod,
            "format": "json",
            "nojsoncallback": "1",
            "api_key": APIKey
        ]
        
        for (key, value) in baseParams {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        if let additionalParams = parameters {
            for (key, value) in additionalParams {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        components.queryItems = queryItems
        
        return components.url!
    }
    
    func fetchPhotos(completion: @escaping (PhotoFetchResult) -> Void) {
        
        let url = urlBuilder(parameters: ["extras": "url_h,date_taken"])
        
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request, completionHandler: {
            (data, response, error) -> Void in
            
            let result = self.processPhotoFetchRequest(data: data, error: error)
            
            OperationQueue.main.addOperation {
                completion(result)
            }
        })
        task.resume()
    }
    
    func processPhotoFetchRequest(data: Data?, error: Error?) -> PhotoFetchResult {
        
        guard let jsonData = data else {
            return .failure(error!)
        }
        return self.photoItems(fromJSON: jsonData)
    }
    
    func photoItems(fromJSON data: Data) -> PhotoFetchResult {
        
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard
                let jsonDict = jsonObject as? [AnyHashable:Any],
                let photos = jsonDict["photos"] as? [String:Any],
                let photosArray = photos["photo"] as? [[String:Any]] else {
                    
                    // The JSON structure is not correct
                    return .failure(FlickrAPIError.invalidJSONData)
            }
            
            var processedPhotos = [Photo]()
            
            for jsonPhoto in photosArray {
                if let photo = createPhotoItem(fromJSON: jsonPhoto ) {
                    processedPhotos.append(photo)
                }
            }
            
            if processedPhotos.isEmpty && !photosArray.isEmpty {
                // unable to parse Photo items. Maybe the JSON formatting has changed
                return .failure(FlickrAPIError.invalidJSONData)
            }
            return .success(processedPhotos)
        } catch let error {
            return .failure(error)
        }
    }
    
    func createPhotoItem(fromJSON json: [String : Any]) -> Photo? {
        guard
            let title = json["title"] as? String,
            let dateAsString = json["datetaken"] as? String,
            let photoID  = json["id"] as? String,
            let photoUrlAsString = json["url_h"] as? String,
            let url = URL(string: photoUrlAsString),
            let dateTaken = dateFormatter.date(from: dateAsString) else {
                // Not enough info to construct a PhotoItem
                return nil
        }
        return Photo(title: title, dateTaken: dateTaken as NSDate, photoID: photoID, remoteURL: url)
    }
}
