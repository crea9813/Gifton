//
//  Network.swift
//  NetworkPlatform
//
//  Created by SuperMove on 2023/01/10.
//

import Foundation
import Domain
import RxSwift
import Moya

final class Network<Target: TargetType>: MoyaProvider<Target> {
    
    init(plugins: [PluginType] = [/*NetworkLoggerPlugin()*/]) {
        let session = MoyaProvider<Target>.defaultAlamofireSession()
        session.sessionConfiguration.timeoutIntervalForRequest = 10
        session.sessionConfiguration.timeoutIntervalForResource = 10
        super.init(session: session, plugins: plugins)
    }
    
    func request(
        _ target: Target,
        _ timeout : Int = 8,
        file: StaticString = #file,
        function: StaticString = #function,
        line: UInt = #line
    ) -> Single<Response> {
        let requestString = "\(target.method.rawValue) \(target.path)"
        
        return self.rx.request(target)
            .catchError()
            .do(
                onSuccess: { value in
                    let message = "SUCCESS: \(requestString) (\(value.statusCode))"
                    print(message)
                },
                onError: { error in
                    if let response = (error as? MoyaError)?.response {
                        if let jsonObject = try? response.mapJSON(failsOnEmptyData: false) {
                            let message = "FAILURE: \(requestString) (\(response.statusCode))\n\(jsonObject)"
                            print(message)
                        } else if let rawString = String(data: response.data, encoding: .utf8) {
                            let message = "FAILURE: \(requestString) (\(response.statusCode))\n\(rawString)"
                            print(message)
                        } else {
                            let message = "FAILURE: \(requestString) (\(response.statusCode))"
                            print(message)
                        }
                    } else {
                        let message = "FAILURE: \(requestString)\n\(error)"
                        print(message)
                    }
                },
                onSubscribed: {
                    let message = "REQUEST: \(requestString)"
                    print(message)
                }
            )
    }
}

extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    
    func catchError() -> Single<Element> {
        return flatMap { response in
            guard (200...299).contains(response.statusCode) else {
                do {
                    let apiErrorResponse = try response.map(ErrorResponse.self)
                    throw GiftError(message: apiErrorResponse.message)
                } catch {
                    throw error
                }
            }
            
            do {
                let decoded = try JSONDecoder().decode(BaseResponse<AnyDecodable>.self, from: response.data)
                
                if let error = decoded.error { throw GiftError(message: error.message) }
                
                return .just(response)
            } catch {
                throw GiftError(message: "decoding_failed")
            }
        }
    }
}
