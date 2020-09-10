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
     
    
    @IBOutlet weak var descriptionLabel: MyUILabeLField!
    
    var selectedCountry : String?
    
    override func viewDidLoad() {
       super.viewDidLoad()
       assignbackground()
       assignLayout()
           
    }
       
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        assignData()
        getCountryDetail()
    }

    func assignLayout() {
        
        
        self.cardView.layer.cornerRadius = 6.0
        self.cardView.layer.borderWidth = 0.86
        self.cardView.layer.borderColor = UIColor.whiteTintColor(1.0).cgColor
         self.cardView.roundCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 6.0, borderColor: UIColor.GrayTintColor(220, alpha: 0.7), borderWidth: 0.65)
    }
    
    func assignData() {
        self.countryNameLabel.text = self.selectedCountry
        
        ///todo: dao'dan country cek
    }
     
    func  getCountryDetail() {
        dispatch_on_main {
            //TODO: Progress
           //Prog.start(in: self.progressParent, .bar(self.barParam))
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
            ///TOdo : progress end
            //Prog.end(in: self.progressParent)
            
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
                self.countryNameLabel.text = country.country + " / " + country.continent
                self.populationLabel.text = String(describing: country.population)
                if let deathsToll = country.deaths?.total {
                    self.deathsLabel.text = String(deathsToll)
                }
                else {
                    self.deathsLabel.text = MyStrings.sharedInstance.NOT_AVAILABLE
                }
                
                self.lastUpdatedLabel.text = Scully.sharedInstance.DateToReadableString(country.day)
            }
            //dao add or update
        }
           
    }
     
}
