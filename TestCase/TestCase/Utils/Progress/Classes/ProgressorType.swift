//
//  ProgressorType.swift
//  Pods
//
//  Created by Chang, Hao on 21/05/2017.
//
//

import Foundation

public enum ProgressorType {
    case
    sync([ProgressorType]),
    color(ColorProgressorParameter?),
    blur(BlurProgressorParameter?),
    activityIndicator,
    bar(BarProgressorParameter?),
    ring(RingProgressorParameter?),
    label(LabelProgressorParameter?),
    dismissable
    
    
    var identifier: String {
        switch self {
            case .sync: return "sync"
            case .color: return "color"
            case .blur: return "blur"
            case .activityIndicator: return "activityIndicator"
            case .bar: return "bar"
            case .ring: return "ring"
            case .label: return "label"
            case .dismissable: return "dismissable"
         
        }
    }
    
    var parameter: Any? {
        switch self {
            case .sync(let types): return types
            case .color(let param): return param
            case .blur(let param): return param
            case .bar(let param): return param
            case .ring(let param): return param
            case .label(let param): return param
                
            default: return nil
        }
    }
}
