//
//  NetworkService.swift
//  VK-Launcher
//
//  Created by Kirill on 03.04.2022.
//

import Foundation
import RealmSwift
import SwiftyJSON
import PromiseKit

class NetworkService {
    
    let error = Error.self
    let accessToken = Session.shared.token
    let userId = Session.shared.userId
    
    //promise
    //создаем url для запроса
    
    func getUrl() -> Promise<URL> {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/friends.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "v", value: "5.131"),
            URLQueryItem(name: "access_token", value: self.accessToken),
            URLQueryItem(name: "order", value: "hints"),
            URLQueryItem(name: "count", value: "20"),
            URLQueryItem(name: "fields", value: "nickname"),
            URLQueryItem(name: "fields", value: "photo_50")
        ]
        
        return Promise { resolver in
            guard let url = urlComponents.url else {
                resolver.reject(error as! Error)  //AppError.notCorrectUrl
                return
            }
            resolver.fulfill(url)
        }
    }
    
    // создаем запрос
    
    func getData(_ url: URL) -> Promise<Data> {
        return Promise { resolver in
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else {
                    resolver.reject(error as! Error) //AppError.errorTask
                    return
                }
                resolver.fulfill(data)
            }.resume()
        }
    }
    
    // парсим данные
    func getParsedData(_ data: Data) -> Promise<[Friend]> {
        return Promise { resolver in
            do {
                let json = JSON(data)
                let friends = json["response"]["items"].arrayValue.compactMap { Friend($0) }
                resolver.fulfill(friends)
            } catch {
                resolver.reject(error) //AppError.failedToDecode
            }
        }
    }
    
//    func getFriendsList(completion: @escaping ([Friend]) -> Void) {
//        var urlComponents = URLComponents()
//        urlComponents.scheme = "https"
//        urlComponents.host = "api.vk.com"
//        urlComponents.path = "/method/friends.get"
//        urlComponents.queryItems = [
//            URLQueryItem(name: "v", value: "5.131"),
//            URLQueryItem(name: "access_token", value: self.accessToken),
//            URLQueryItem(name: "order", value: "hints"),
//            URLQueryItem(name: "count", value: "10"),
//            URLQueryItem(name: "fields", value: "nickname"),
//            URLQueryItem(name: "fields", value: "photo_50")
//        ]
//        guard let url = urlComponents.url else { return }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        
//        let session = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data else { return }
//            let json = JSON(data)
//            let friends = json["response"]["items"].arrayValue.compactMap { Friend($0) }
//            completion(friends)
//        }
//        session.resume()
//    }
    
    func getGroupsList(completion: @escaping ([Group]) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "v", value: "5.131"),
            URLQueryItem(name: "access_token", value: accessToken),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "count", value: "20")
        ]
        
        guard let url = urlComponents.url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            let json = JSON(data)
            let groups = json["response"]["items"].arrayValue.compactMap { Group($0) }
            DispatchQueue.main.async {
                completion(groups)
            }
        }
        session.resume()
    }
    
    func getNews(completion: @escaping ([News]) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/newsfeed.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "v", value: "5.131"),
            URLQueryItem(name: "access_token", value: accessToken),
            URLQueryItem(name: "filters", value: "post")
        ]
        
        guard let url = urlComponents.url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            let json = JSON(data)
            let news = json["response"]["items"].arrayValue.compactMap { News($0) }
            completion(news)
        }
        session.resume()
    }
    
    func getPhotos(for id: Int, completion: @escaping ([Gallery]) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/photos.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "v", value: "5.131"),
            URLQueryItem(name: "access_token", value: accessToken),
            URLQueryItem(name: "owner_id", value: String(id)),
            URLQueryItem(name: "album_id", value: "profile"),
            URLQueryItem(name: "photo_sizes", value: "1")
        ]
        
        guard let url = urlComponents.url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            
            let json = JSON(data)
            print(json)
            let photo = json["response"]["items"][0]["sizes"].arrayValue.compactMap { Gallery($0) }
            completion(photo)
        }
        session.resume()
    }
    
    func getSearchGroups() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.search"
        urlComponents.queryItems = [
            URLQueryItem(name: "v", value: "5.131"),
            URLQueryItem(name: "access_token", value: accessToken),
            URLQueryItem(name: "q", value: "юмор")
        ]
        
        guard let url = urlComponents.url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
            guard let json = json else { return }
            print("Искомые группы - \(json)")
        }
        session.resume()
    }
}
