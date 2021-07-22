//
//  UserModel.swift
//  TheNewFlickr
//
//  Created by Ahmed Elmemy on 19/07/2021.
//
import Foundation
import SwiftyJSON


// MARK: - UserModel
struct UserModel: Codable {
    let cartCount: Int?
    let user: User
    let cityID: Int?
    let token: String?
    
    enum CodingKeys: String, CodingKey {
        case cartCount, user
        case cityID = "city_id"
        case token
    }
    
    
    static func getUser() -> UserModel?{
        
        let defaults = UserDefaults.standard
        
        if let data = defaults.object(forKey: "user") as? Data {
            
            
            do {
                
                let user = try JSONDecoder().decode(UserModel.self, from: data)
                
                return user
                
            }catch{
                print(error)
                return nil
            }
            
            
            
        }else{
            print("no user found")
            return nil
        }
        
        
        
    }
    
    
    func save () {
        
        do{
            
            let data = try JSONEncoder().encode(self)
            let defaults = UserDefaults.standard
            defaults.set(data, forKey: "user")
            
        }catch {
            print(error)
        }
        
        
    }
    
    
}

// MARK: - User
struct User: Codable {
    let id: Int
    let avatar: String
    let name, email, phone, address: String
    let cityID: Int?
    let cityName, lat, lng, lang: String?
    let online, active: Int
    let userType: String
    let rate:String?
    
    enum CodingKeys: String, CodingKey {
        case id, avatar, name, email, phone, address
        case cityID = "city_id"
        case cityName = "city_name"
        case lat, lng, lang, online, active,rate
        case userType = "user_type"
    }
}
