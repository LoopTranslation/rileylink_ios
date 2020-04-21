//
//  LoopEnacted.swift
//  RileyLink
//
//  Created by Pete Schwamb on 7/28/16.
//  Copyright © 2016 Pete Schwamb. All rights reserved.
//

import Foundation

public struct LoopEnacted {
    typealias RawValue = [String: Any]

    let rate: Double
    let duration: TimeInterval
    let timestamp: Date
    let received: Bool

    public init(rate: Double, duration: TimeInterval, timestamp: Date, received: Bool) {
        self.rate = rate
        self.duration = duration
        self.timestamp = timestamp
        self.received = received
    }
    
    public var dictionaryRepresentation: [String: Any] {

        var rval = [String: Any]()

        rval["rate"] = rate
        rval["duration"] = duration / 60.0
        rval["timestamp"] = TimeFormat.timestampStrFromDate(timestamp)
        rval["received"] = received
        return rval
    }
    
    init?(rawValue: RawValue) {
        guard
            let rate = rawValue["rate"] as? Double,
            let durationMinutes = rawValue["duration"] as? Double,
            let timestampStr = rawValue["timestamp"] as? String,
            let timestamp = TimeFormat.dateFromTimestamp(timestampStr),
            let received = rawValue["received"] as? Bool
        else {
            return nil
        }
        
        self.rate = rate
        self.duration = TimeInterval(minutes: durationMinutes)
        self.timestamp = timestamp
        self.received = received
    }
}
