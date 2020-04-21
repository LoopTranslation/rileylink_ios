//
//  TempBasalNightscoutTreatment.swift
//  RileyLink
//
//  Created by Pete Schwamb on 4/18/16.
//  Copyright © 2016 Pete Schwamb. All rights reserved.
//

import Foundation

public class TempBasalNightscoutTreatment: NightscoutTreatment {
    
    public enum RateType: String {
        case Absolute = "absolute"
        case Percentage = "percentage"
    }
    
    
    public let rate: Double
    public let amount: Double?
    public let absolute: Double?
    public let temp: RateType
    public let duration: TimeInterval
    
    public init(timestamp: Date, enteredBy: String, temp: RateType, rate: Double, absolute: Double?, duration: TimeInterval, amount: Double? = nil, id: String? = nil) {
        self.rate = rate
        self.absolute = absolute
        self.temp = temp
        self.duration = duration
        self.amount = amount
        
        // Commenting out usage of surrogate ID until supported by Nightscout
        super.init(timestamp: timestamp, enteredBy: enteredBy, /*id: id,*/ eventType: .tempBasal)
    }
    
    required public init?(_ entry: [String : Any]) {
        guard
            let rate = entry["rate"] as? Double,
            let rateTypeRaw = entry["temp"] as? String,
            let rateType = RateType(rawValue: rateTypeRaw),
            let durationMinutes = entry["duration"] as? Double
        else {
            return nil
        }
        
        self.rate = rate
        self.temp = rateType
        self.duration = TimeInterval(minutes: durationMinutes)
        self.amount = entry["amount"] as? Double
        self.absolute = entry["absolute"] as? Double
        
        super.init(entry)
    }
    
    override public var dictionaryRepresentation: [String: Any] {
        var rval = super.dictionaryRepresentation
        rval["temp"] = temp.rawValue
        rval["rate"] = rate
        rval["absolute"] = absolute
        rval["duration"] = duration.minutes
        rval["amount"] = amount
        return rval
    }
}
