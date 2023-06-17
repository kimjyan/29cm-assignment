//
//  NetworkProvider.swift
//  assignment
//
//  Created by 쎄부킴 on 2023/06/14.
//

import Moya
import RxMoya
import RxSwift

final class NetworkProvider<Target: TargetType>: MoyaProvider<Target> {
    init(plugins: [PluginType] = []) {
        let session = MoyaProvider<Target>.defaultAlamofireSession()
        session.sessionConfiguration.timeoutIntervalForRequest = 10
        
        super.init(session: session)
    }
    
    func request(
        _ target: Target,
        file: StaticString = #file,
        function: StaticString = #function,
        line: UInt = #line
    ) -> Single<Response> {
        let requestString = "\(target.method.rawValue) \(target.path)"
        return self.rx.request(target)
            .filterSuccessfulStatusCodes()
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
