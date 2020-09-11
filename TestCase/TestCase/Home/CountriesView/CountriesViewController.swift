//
//  ViewController.swift
//  SoftCaseDemo
//
//  Created by musa fedakar on 17.08.2020.
//  Copyright © 2020 musa fedakar. All rights reserved.
//

import UIKit

class CountriesViewsController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate {

    let searchController = UISearchController(searchResultsController: nil)
    
    
    fileprivate let cellIdentifier = "CountryViewCell"
    
    @IBOutlet weak var mTableView: UITableView!
    
    private let refreshControl = UIRefreshControl()
    
    fileprivate var mFinalDATASET : [String] = [String]()
    fileprivate var mCountriesList : [String] = [String]()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        assignbackground()
        
        assignTableView()
        assignLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func assignLayout() {
        let dbCountries = CountryDAO(dbType: .realm).List().map({ $0.country })
        self.mFinalDATASET = dbCountries
        self.mCountriesList = dbCountries
        if (!self.mFinalDATASET.isEmpty) {
            dispatch_on_main {
                self.mTableView.reloadData()
            }
           
        }
        getCountryList()
    }
    
    fileprivate func assignTableView() {
        
        self.refreshControl.addTarget(self, action: #selector(refreshAllItemData(_:)), for: .valueChanged)

        self.refreshControl.tintColor = UIColor.sinRedLight(1.0)

        if #available(iOS 10.0, *) {
            self.mTableView.refreshControl = refreshControl
        } else {
            self.mTableView.addSubview(refreshControl)
        }

        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.delegate = self
          

        searchController.searchBar.placeholder = MyStrings.sharedInstance.SEARCH_REPOSITORIES
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.mTableView.tableHeaderView = self.searchController.searchBar
        definesPresentationContext = true
        
        self.mTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
                 
        self.mTableView.dataSource = self
        self.mTableView.delegate = self
        
    }
    
    @IBOutlet weak var progressAnchor: UIView!
    
    fileprivate var progressParent: ProgressParent {
        return self.progressAnchor as ProgressParent
    }
    
    let barParam: BarProgressorParameter = (.endless, BarProgressorSide.top, UIColor.sinRedLight(0.65), 3)
    
    @objc private func refreshAllItemData(_ sender: Any) {
        
        self.searchController.searchBar.text = ""
        getCountryList()
         
    }

    func  getCountryList() {
        dispatch_on_main {
            Prog.start(in: self.progressParent, .bar(self.barParam))
        }
        sendApiRequest(buildGetCountryListCommand())
    }
     
    func buildGetCountryListCommand() -> ApiRequestCommand {
        let retval = ApiRequestCommand(ct: .get_countries)
        let queryobject = BaseRequest()
        retval.queryObject = queryobject
        return retval
    }
    
    override func api_operation_completed(_ ApiRequestCommand: ApiRequestCommand?) {
        
        dispatch_on_main {
            Prog.end(in: self.progressParent)
            self.refreshControl.endRefreshing()
        }
        if let apiRequestCommand = ApiRequestCommand {
            
            if (checkApiResponse(command: apiRequestCommand)) {
                return
            }
            
            switch apiRequestCommand.apiCommandType! {
            case ApiRequestCommandType.get_countries:
                getCountriesListCallback(ApiRequestCommand?.returnObject as! ApiResponseObject<String>)
                break
            default:
                break
            }
        }
    }
    
    fileprivate func getCountriesListCallback(_ response : ApiResponseObject<String>) {
                
        for countryName in response.response {
            self.mFinalDATASET.append(countryName)
            self.mCountriesList.append(countryName)
            
        }
    
        dispatch_on_main {
           self.mTableView.reloadData()
        }
           
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.mCountriesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let countryName = self.mCountriesList[indexPath.row]
        
        let cell = self.mTableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! CountryViewCell
        
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        cell.contentView.backgroundColor = UIColor.clear
        cell.layer.backgroundColor = UIColor.clear.cgColor
        cell.country = countryName
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard case _ as CountryViewCell = tableView.cellForRow(at: indexPath) else {
            return
        }
        let countryName = self.mCountriesList[indexPath.row]
        gotoCountryDetailViewController(data: countryName)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62.0
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.reload()

    }
     
    @objc func reload() {
         
        guard let query = self.searchController.searchBar.text else {
            return
        }
         
        if !query.isEmpty {
            self.mCountriesList = self.mFinalDATASET.filter { $0.range(of: query, options: .caseInsensitive) != nil}
        }
        else {
            self.mCountriesList = self.mFinalDATASET
        }
        self.mTableView.reloadData()
    }
      
    fileprivate func gotoCountryDetailViewController(data: String) {
        
         self.performSegue(withIdentifier: "show_country_detail_segue", sender: data)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "show_country_detail_segue":
            if let data = sender as? String, let vc = segue.destination as? CountryDetailViewController {
                vc.selectedCountry = data
            }
        default:
            break
        }
    }
    
}

