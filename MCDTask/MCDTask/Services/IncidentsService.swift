//
//  IncidentsService.swift
//  MCDTask
//
//  Created by Shashi Nishantha on 7/23/25.
//

import Foundation

class IncidentsService {
    private var client:APIClient?
        
    init(apiClient: APIClient = APIClient()){
        client = apiClient
    }
    
    func getIncidentsList() async throws -> [Incident]? {
        
        let url = Endpoints.incidents.getPath()
        let result = try await client?.get(url: url)
        print(result ?? "")
        if let data = result?.data {
            let userResponse = try? JSONDecoder().decode([Incident].self, from: data)
            return userResponse
        }
        return nil
    }
}
