//
//  IncidentsView.swift
//  MCDTask
//
//  Created by Shashi Nishantha on 7/23/25.
//

import UIKit
import Combine

class IncidentsViewController: UIViewController {
    
    var viewModel = IncidentsViewModel()
    private var disposableBag = Set<AnyCancellable>()
    
    lazy var incidentListTable: UITableView = {
        let tableView = UITableView.init(frame: .zero)
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 0)
        tableView.clipsToBounds = true
        tableView.layer.cornerRadius = 8
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // arrow.turn.up.right
        setupView()
        setConstaints()
        registerTableCells()
        bind()
        viewModel.fetchIncidents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupView(){
        self.title = AppConstants.PageTitles.incidentListPageTitle
        
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down") , style: .plain, target: self, action: #selector(sortIncidents))
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        self.view.backgroundColor = .systemGroupedBackground
        self.view.addSubview(incidentListTable)
    }
       
    func setConstaints(){
        incidentListTable.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(0)
        }
    }
       
    func registerTableCells(){
        incidentListTable.register(IncidentsViewCell.self, forCellReuseIdentifier: AppConstants.CellIdentifires.incidentListCellIdentifire)
    }

    
    @objc func sortIncidents() {
        viewModel.sortListByDate()
        incidentListTable.reloadData()
    }
}

extension IncidentsViewController {
    
    private func bind(){
        viewModel.incidentsListPublisher
            .sink { [weak self] incidents in
                self?.incidentListTable.reloadData()
            }.store(in: &disposableBag)
        
        viewModel.errorPublisher
            .sink { [weak self] error in
                debugPrint(error.localizedDescription)
            }.store(in: &disposableBag)
    }
}

extension IncidentsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfIncidents
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:IncidentsViewCell = (tableView.dequeueReusableCell(withIdentifier: AppConstants.CellIdentifires.incidentListCellIdentifire) as? IncidentsViewCell)!
        
        if let currentIncident = viewModel.getIncident(index: indexPath.row) {
            cell.configureCell(incident: currentIncident)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedIncident = viewModel.getIncident(index: indexPath.row) {
            let vc = IncidentDetailViewController(incident: selectedIncident)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
