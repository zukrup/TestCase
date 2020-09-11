//
//  RepoDetailViewController.swift
//  SoftCaseDemo
//
//  Created by musa fedakar on 18.08.2020.
//  Copyright © 2020 musa fedakar. All rights reserved.
//

import Foundation
import UIKit

class CountryDetailViewController : BaseViewController {
    
    
    @IBOutlet weak var lastUpdatedLabel: MyUILabeLField!
    @IBOutlet weak var countryNameLabel: MyUILabeLField!
    @IBOutlet weak var populationLabel: MyUILabeLField!
    
    @IBOutlet weak var deathsLabel: MyUILabeLField!
    
    @IBOutlet weak var cardView: UIView!
     
    @IBOutlet weak var casesLabel: MyUILabeLField!
    @IBOutlet weak var testsLabel: MyUILabeLField!
    
    
    @IBOutlet weak var progressAnchor: UIView!
    
    fileprivate var progressParent: ProgressParent {
        return self.progressAnchor as ProgressParent
    }
    
    let barParam: BarProgressorParameter = (.endless, BarProgressorSide.top, UIColor.sinRedLight(0.65), 3)
    
    
    var selectedCountry : String?
    
    override func viewDidLoad() {
       super.viewDidLoad()
       assignbackground()
       assignLayout()
       assignData()
    }
       
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //getCountryDetail()
    }

    func assignLayout() {
        
        
        self.cardView.layer.cornerRadius = 6.0
        self.cardView.layer.borderWidth = 0.86
        self.cardView.layer.borderColor = UIColor.whiteTintColor(1.0).cgColor
         self.cardView.roundCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 6.0, borderColor: UIColor.GrayTintColor(220, alpha: 0.7), borderWidth: 0.65)
    }
    
    func assignData() {
       
        if let countryname = self.selectedCountry, let dbCountry = CountryDAO(dbType: .realm).Get(id: countryname) {
            self.countryNameLabel.text = self.selectedCountry
            self.fillUIData(dbCountry)
        }
         
    }
     
    func  getCountryDetail() {
        dispatch_on_main {
            Prog.start(in: self.progressParent, .bar(self.barParam))
        }
        if let countryName = self.selectedCountry {
            sendApiRequest(buildGetCountryDetailCommand(countryName))
        }
        
    }
    
    func buildGetCountryDetailCommand(_ cname : String) -> ApiRequestCommand {
        let retval = ApiRequestCommand(ct: .get_country_detail)
        let queryobject = BaseRequest()
        queryobject.queryDictionary.updateValue(cname as AnyObject, forKey: "country")
        retval.queryObject = queryobject
        return retval
    }
    
    override func api_operation_completed(_ ApiRequestCommand: ApiRequestCommand?) {
        
        dispatch_on_main {
            Prog.end(in: self.progressParent)
            
        }
        if let apiRequestCommand = ApiRequestCommand {
            
            if (checkApiResponse(command: apiRequestCommand)) {
                return
            }
            
            switch apiRequestCommand.apiCommandType! {
            case ApiRequestCommandType.get_country_detail:
                getCountryDetailCallback(ApiRequestCommand?.returnObject as! ApiResponseObject<Country>)
                break
            default:
                break
            }
        }
    }
    
    fileprivate func getCountryDetailCallback(_ response : ApiResponseObject<Country>) {
                
        if let country = response.response.first {
             
            dispatch_on_main {
                let _  = CountryDAO(dbType: .realm).InsertOrUpdate(country)
                self.fillUIData(country)
            }
            //dao add or update
        }
           
    }
     
    fileprivate func fillUIData(_ country: Country) {
        self.countryNameLabel.text = country.country + " / " + country.continent
        //self.populationLabel.text = String(describing: country.population)
        self.populationLabel.text = Scully.sharedInstance.NumberToDecimalFormat(country.population)
        if let deathsToll = country.deaths?.total {
            self.deathsLabel.text = String(deathsToll)
        }
        else {
            self.deathsLabel.text = MyStrings.sharedInstance.NOT_AVAILABLE
        }
        if let testsTotal = country.tests?.total {
            self.testsLabel.text = String(testsTotal)
        }
        else {
            self.testsLabel.text = MyStrings.sharedInstance.NOT_AVAILABLE
        }
        if let casesTotal = country.cases?.total {
            self.casesLabel.text = String(casesTotal)
        }
        else {
            self.casesLabel.text = MyStrings.sharedInstance.NOT_AVAILABLE
        }
        self.lastUpdatedLabel.text = Scully.sharedInstance.DateToReadableString(country.day)
    }
}
