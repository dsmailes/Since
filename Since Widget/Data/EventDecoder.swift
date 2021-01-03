//
//  EventDecoder.swift
//  Since
//
//  Created by David Smailes on 03/01/2021.
//

import Foundation

public class EventDecoder {
    
    static let sharedInstance = EventDecoder()
    
    func decodeEvent(number: Int) -> WidgetSinceEvent {
        let decoder = JSONDecoder()
        let url = AppGroup.since.containerURL.appendingPathComponent("widgetdata.json")
        var data: Data
        do {
            data = try Data(contentsOf: url)
        } catch {
            debugPrint(error)
            return WidgetSinceEvent(title: "Add an event in the app first", date: Date(), image: nil, showYears: true, showDays: true, showHours: true, showMinutes: true)
        }
        do {
            let decodedData = try decoder.decode(WidgetSinceEvent.self, from: data)
            print(decodedData)
            return decodedData
        } catch {
            debugPrint(error)
            return WidgetSinceEvent(title: "Add an event in the app first", date: Date(), image: nil, showYears: true, showDays: true, showHours: true, showMinutes: true)
        }

    }
    
}
