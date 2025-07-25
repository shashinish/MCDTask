//
//  IncidentDetailViewController.swift
//  MCDTask
//
//  Created by Shashi Nishantha on 7/25/25.
//

import UIKit
import Foundation
import MapKit

class IncidentDetailViewController: UIViewController {
    
    var viewModel: InIncidentDetailViewModel!
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.isScrollEnabled = true
        mapView.isZoomEnabled = true
        mapView.isPitchEnabled = true
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.mapType = .satelliteFlyover
        return mapView
    }()
   
    private lazy var tableHeaderView: UIView = {
        var view = UIView(frame: .zero)
        //view.addSubview(mapView)
        return view
    }()
    
    lazy var incidentDetailTable: UITableView = {
        let tableView = UITableView.init(frame: .zero)
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.clipsToBounds = true
        tableView.layer.cornerRadius = 8
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setConstaints()
        registerTableCells()
        setMapPoint()
    }
    
    init(incident: Incident) {
        super.init(nibName: nil, bundle: nil)
        viewModel = InIncidentDetailViewModel(incident: incident)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func setupView(){
        self.title = viewModel.incident?.title
        
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "arrow.turn.up.right") , style: .plain, target: self, action: #selector(navigateToMap))
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        self.view.backgroundColor = .systemGroupedBackground
        self.view.addSubview(incidentDetailTable)
        
        mapView.frame = CGRect(x: 0, y: 0, width: incidentDetailTable.bounds.width, height: 250)
    }
    
    @objc func navigateToMap(){
        if let longitude = viewModel.incident?.longitude, let latitude = viewModel.incident?.latitude {
            guard let url = URL(string:"http://maps.apple.com/?daddr=\(latitude),\(longitude)") else { return }
            UIApplication.shared.open(url)
        }
    }
    
    func setConstaints() {
        incidentDetailTable.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(0)
        }
    }
       
    func registerTableCells(){
        incidentDetailTable.register(IncidentDetailViewCell.self, forCellReuseIdentifier: AppConstants.CellIdentifires.incidentDetailCellIdentifire)
    }
    
    func setMapPoint(){
        
        if let longitude = viewModel.incident?.longitude, let latitude = viewModel.incident?.latitude {
            
            let annotation = MKPointAnnotation()
            let centerCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            annotation.coordinate = centerCoordinate
            annotation.title = viewModel.incident?.title
            mapView.addAnnotation(annotation)
            
            
            let initialLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: initialLocation, span: span)
            mapView.setRegion(region, animated: true)
        }
        
        incidentDetailTable.tableHeaderView = mapView
        incidentDetailTable.reloadData()
    }
    
}


extension IncidentDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:IncidentDetailViewCell = (tableView.dequeueReusableCell(withIdentifier: AppConstants.CellIdentifires.incidentDetailCellIdentifire) as? IncidentDetailViewCell)!
        
        if indexPath.row == 0 {
            if let location = viewModel.incident?.location {
                cell.configureCell(title: "Location", description: location)
            }
        }else if indexPath.row == 1 {
            if let status = viewModel.incident?.status {
                cell.configureCell(title: "Status", description: status)
            }
        }else if indexPath.row == 2 {
            if let type = viewModel.incident?.type {
                cell.configureCell(title: "Type", description: type)
            }
        }else if indexPath.row == 3 {
            if let calltime = viewModel.incident?.callTimeDateString {
                cell.configureCell(title: "Call Time", description: calltime)
            }
        }else if indexPath.row == 4 {
            if let descption = viewModel.incident?.description {
                cell.configureCell(title: "Description", description: descption)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4 {
            UIPasteboard.general.string = viewModel.incident?.description
        }
    }
}
