//
//  IncidentsViewModel.swift
//  MCDTask
//
//  Created by Shashi Nishantha on 7/23/25.
//

import Foundation
import Combine

class IncidentsViewModel {
    
    @Published private(set) var listOfIncidents: [Incident]?
    @Published private(set) var error: String?
        
    private var userFetchTask: Task<Void, Never>? = nil
    private var errorSubject: PassthroughSubject<Error, Never> = .init()
    
    private var service: IncidentsService?
    private var sortingOrder: SortOrder = .ascending
        
    init(incidentService: IncidentsService = IncidentsService()) {
        service = incidentService
    }
    
    deinit{
        userFetchTask?.cancel()
    }
    
    var numberOfIncidents: Int {
        listOfIncidents?.count ?? 0
    }
        
    func getIncident(index: Int) -> Incident? {
        return listOfIncidents?[index]
    }
    
    @discardableResult
    func fetchIncidents() -> Task<Void, Never>? {
        userFetchTask?.cancel()
        
        let task = Task {
            do{
                try Task.checkCancellation()
                let incidents = try await service?.getIncidentsList()
                self.listOfIncidents = incidents
            }catch{
                self.errorSubject.send(error)
            }
        }
        
        userFetchTask = task
        return task
    }
    
    func sortListByDate(){
        if sortingOrder == .ascending {
            sortingOrder = .descending
            listOfIncidents?.sort{ $0.lastUpdatedDate > $1.lastUpdatedDate }
        }else {
            sortingOrder = .ascending
            listOfIncidents?.sort{ $0.lastUpdatedDate < $1.lastUpdatedDate }
        }
        
    }
    
}

extension IncidentsViewModel{
    var incidentsListPublisher: AnyPublisher<[Incident], Never> {
        $listOfIncidents.compactMap{ $0 }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
       
    var errorPublisher: AnyPublisher<Error, Never>{
        errorSubject.eraseToAnyPublisher()
    }
}
