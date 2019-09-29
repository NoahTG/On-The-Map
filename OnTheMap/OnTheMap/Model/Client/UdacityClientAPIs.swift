//
//  UdacityClientAPIs.swift
//  OnTheMap
//
//  Created by NTG on 9/1/19.
//  Copyright © 2019 NTG. All rights reserved.
//

import Foundation

class UdacityClientAPIs {
    
                struct Auth {
                    static var accountId = ""
                    static var sessionId = ""
                }

                enum Endpoints {
                    static let base = "https://onthemap-api.udacity.com/v1"
                    
                    case login
                    case getStudentLocations(Int)
                    case postStudentLocation
                    case getUserInfo
                    case updateStudentLocation
                    case logout
                    case udacitySignUp

                    
                    var stringValue: String {
                        switch self {
                        case .login: return Endpoints.base + "/session"
                        case .getStudentLocations(let amount): return Endpoints.base + "/StudentLocation?limit=\(amount)&order=-updatedAt"
                        case .postStudentLocation: return Endpoints.base + "/StudentLocation"
                        case .getUserInfo: return Endpoints.base + "/users/\(Auth.accountId)"
                        case .updateStudentLocation: return Endpoints.base + "/StudentLocation/<objectid>"
                        case .logout: return Endpoints.base + "/session"
                        case .udacitySignUp: return "https://auth.udacity.com/sign-up"
                        }
                        
                    }
                    
                    var url: URL {
                        return URL(string: stringValue)!
                    }
                    
                }

            class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionTask {
                
                let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                    guard let data = data else {
                        DispatchQueue.main.async {
                            completion(nil, error)
                        }
                        return
                    }
                    let range = 5..<data.count
                    let newData = data.subdata(in: range) /* subset response data! */
                    
                    do {
                        let responseObject = try JSONDecoder().decode(ResponseType.self, from: newData)
                        DispatchQueue.main.async {
                            completion(responseObject, nil)
                        }
                    }
                    catch {
                        do {
                            let errorMessage = try JSONDecoder().decode(UdacityErrorMessages.self, from:newData)
                            DispatchQueue.main.async {
                                completion(nil, errorMessage)
                            }
                        }
                        catch {
                            DispatchQueue.main.async{
                            completion(nil, error)
                            }
                        }
                    }
                }
            task.resume()
            return task
            }

            class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void){
                
                var request = URLRequest(url: url)
                
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = try! JSONEncoder().encode(body)
                
                let task = URLSession.shared.dataTask(with: request) {data, response, error in
                    guard let data = data else {
                        DispatchQueue.main.async {
                            completion(nil, error)
                        }
                        return
                    }
                    
                    let range = 5..<data.count
                    let newData = data.subdata(in: range) /* subset response data! */
                    
                    do {
                        let responseObject = try JSONDecoder().decode(ResponseType.self, from: newData)
                        DispatchQueue.main.async {
                            completion(responseObject, nil)
                        }
                    } catch {
                        do {
                            let errorMessage = try JSONDecoder().decode(UdacityErrorMessages.self, from:newData)
                            DispatchQueue.main.async {
                                completion(nil, errorMessage)
                            }
                        }
                        catch {
                            DispatchQueue.main.async{
                                completion(nil, error)
                            }
                        }
                    }
                }
                task.resume()
            }
                   
    
            class func taskForDELETERequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void){
                    
                var request = URLRequest(url: url)
                
                request.httpMethod = "DELETE"
                
                var xsrfCookie: HTTPCookie? = nil
                let sharedCookieStorage = HTTPCookieStorage.shared
                for cookie in sharedCookieStorage.cookies! {
                    if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
                }
                if let xsrfCookie = xsrfCookie {
                    request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
                }
                
                let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
                    guard let data = data else {
                        DispatchQueue.main.async {
                            completion(nil, error)
                        }
                        return
                    }
                    let range = 5..<data.count
                    let newData = data.subdata(in: range) /* subset response data! */
                    
                    do {
                        let responseObject = try JSONDecoder().decode(ResponseType.self, from:newData)
                        DispatchQueue.main.async {
                            completion(responseObject, nil)
                        }
                    } catch {
                        do {
                            let errorMessage = try JSONDecoder().decode(UdacityErrorMessages.self, from:newData)
                            DispatchQueue.main.async {
                                completion(nil, errorMessage)
                            }
                        }
                        catch {
                            DispatchQueue.main.async{
                                completion(nil, error)
                            }
                        }
                    }
                }
                task.resume()
            }
    
    
             class func taskForPUTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void){
            
                    var request = URLRequest(url: url)
        
                    request.httpMethod = "PUT"
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.httpBody = try! JSONEncoder().encode(body)
        
                    let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
                        guard let data = data else {
                            DispatchQueue.main.async {
                                completion(nil, error)
                            }
                            return
                        }
                        
                        let range = 5..<data.count
                        let newData = data.subdata(in: range) /* subset response data! */
                        
                        do {
                            let responseObject = try JSONDecoder().decode(ResponseType.self, from: newData)
                            DispatchQueue.main.async {
                                completion(responseObject, nil)
                            }
                        } catch {
                            do {
                                let errorMessage = try JSONDecoder().decode(UdacityErrorMessages.self, from:newData)
                                DispatchQueue.main.async {
                                    completion(nil, errorMessage)
                                }
                            }
                            catch {
                                DispatchQueue.main.async{
                                    completion(nil, error)
                                }
                            }
                        }
                }
                task.resume()
            }
    
                class func login(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
                   let body = LoginRequest(udacity: LoginCredentials(username: username, password: password))
                    taskForPOSTRequest(url: Endpoints.login.url, responseType: LoginResponse.self, body: body, completion: {(response, error) in
                        if let response = response {
                            Auth.sessionId = response.session.sessionId
                            Auth.accountId = response.account.key
                            completion(true, nil)
                        } else {
                            completion(false, error)
                        }
                    })
                }
    
                class func getStudentLocations(amount: Int,completion: @escaping ([StudentInformation], Error?) -> Void) {
                    taskForGETRequest(url: Endpoints.getStudentLocations(amount).url, responseType: StudentLocations.self, completion: {(response, error) in
                        if let response = response{
                            print(response.locations)
                            completion(response.locations, nil)
                        }else{
                            completion([], error)
                        }
                    })
                }
    
                class func postStudentLocation(studentLocation: StudentInformation, completion: @escaping (Bool, Error?) -> Void) {
                        let body = studentLocation
                    taskForPOSTRequest(url: Endpoints.postStudentLocation.url, responseType: PostStudentLocationResponse.self, body: body, completion: {(response, error) in
                        if let response = response {
                            PostStudentLocation.studentLocation.createdAt = response.createdAt
                            PostStudentLocation.studentLocation.objectId = response.objectId
                            completion(true, nil)
                        } else {
                            completion(false,error)
                        }
                    })
                }
    
                class func getUserInfo(completion: @escaping (UserInfoResponse?, Error?) -> Void ) {
                    taskForGETRequest(url: Endpoints.getUserInfo.url, responseType: UserInfoResponse.self, completion: {(response, error) in
                        if let response = response {
                            print(response)
                            completion(response, nil)
                        } else {
                            completion(nil, error)
                        }
                    })
                }
    
                class func updateStudentLocation (updateStudent: StudentLocations, completion: @escaping (Bool, Error?) -> Void) {
                        let body = updateStudent
                    
                    taskForPUTRequest(url: Endpoints.updateStudentLocation.url, responseType: UpdateStudentLocationResponse.self, body: body, completion: {(response, error) in
                        if let response = response {
                            UpdateStudentLocation.studentLocation.updatedAt = response.updatedAt
                            completion(true, nil)
                        } else {
                            completion(false,error)
                        }
                    })
                }
    
    
                class func logout(completion: @escaping (Bool, Error?) -> Void) {
                    taskForDELETERequest(url: Endpoints.logout.url, responseType: LogoutResponse.self, completion: {(response, error) in
                    if response != nil {
                        Auth.accountId = ""
                        Auth.sessionId = ""
                        completion(true, nil)
                        } else {
                            completion(false, error)
                        }
                    })
    
                }

}


