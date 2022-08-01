//
//  APIEndpoints.swift
//  Git-Trendo
//
//  Created by Ammad Akhtar on 29/07/2022.
//

import Foundation

struct APIEndpoints {

    static func getTrendingRepositories(with trendingRequestDTO: TrendingRequestDTO) -> Endpoint<TrendingResponseDTO> {

        return Endpoint(path: "search/repositories",
                        method: .get,
                        headerParameters: [ // recommended on github docs 
                            "Accept": "application/vnd.github.v3+json",
                            "Content-Type": "application/json;charset=utf-8"
                        ],
                        queryParametersEncodable: trendingRequestDTO)
    }
}
