//
//  Since_Widget.swift
//  Since Widget
//
//  Created by David Smailes on 26/10/2020.
//

import WidgetKit
import SwiftUI
import Foundation

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SinceEventEntry {
        SinceEventEntry(title: "Since Event", details: "Your event", eventDate: Date(), image: "sincelogo", showYears: true, showDays: true, showHours: true, showMinutes: true, date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SinceEventEntry) -> ()) {
        let entry = SinceEventEntry(title: "Since Event", details: "Your event", eventDate: Date(), image: "sincelogo", showYears: true, showDays: true, showHours: true, showMinutes: true, date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SinceEventEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        
        let event = decodeEvent()
        
        let entry = SinceEventEntry(title: event.title, details: event.details, eventDate: event.date, image: event.image ?? "sincelogo", showYears: event.showYears, showDays: event.showDays, showHours: event.showHours, showMinutes: event.showMinutes, date: Date())

        entries.append(entry)
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SinceEventEntry: TimelineEntry {
    var title: String
    var details: String
    var eventDate: Date
    var image: String?
    var showYears: Bool
    var showDays: Bool
    var showHours: Bool
    var showMinutes: Bool
    var date: Date
}

struct Since_WidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        SinceWidgetView(image: entry.image ?? "sincelogo", text: entry.title)
    }
}

@main
struct Since_Widget: Widget {
    
    let kind: String = "Since_Widget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            Since_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Since")
        .description("Display your events using the Since widget.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
    
}

func decodeEvent() -> WidgetSinceEvent {
    let decoder = JSONDecoder()
    let url = AppGroup.since.containerURL.appendingPathComponent("widgetdata.json")
    var data: Data
    do {
        data = try Data(contentsOf: url)
    } catch {
        debugPrint(error)
        return WidgetSinceEvent(title: "Error 1", details: "Error", date: Date(), image: nil, showYears: true, showDays: true, showHours: true, showMinutes: true)
    }
    
    do {
        let decodedData = try decoder.decode(WidgetSinceEvent.self, from: data)
        print(decodedData)
        return decodedData
    } catch {
        debugPrint(error)
        return WidgetSinceEvent(title: "Error 2", details: "Error", date: Date(), image: nil, showYears: true, showDays: true, showHours: true, showMinutes: true)
    }

}

struct Since_Widget_Previews: PreviewProvider {
    static var previews: some View {
        Since_WidgetEntryView(entry: SinceEventEntry(title: "Since Event", details: "Your event", eventDate: Date(), image: "sincelogo", showYears: true, showDays: true, showHours: true, showMinutes: true, date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
            .previewDisplayName("Small, light")
            .environment(\.colorScheme, .light)
        Since_WidgetEntryView(entry: SinceEventEntry(title: "Since Event", details: "Your event", eventDate: Date(), image: "sincelogo", showYears: true, showDays: true, showHours: true, showMinutes: true, date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
            .previewDisplayName("Small, dark")
            .environment(\.colorScheme, .dark)
        Since_WidgetEntryView(entry: SinceEventEntry(title: "Since Event", details: "Your event", eventDate: Date(), image: "sincelogo", showYears: true, showDays: true, showHours: true, showMinutes: true, date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
            .previewDisplayName("Medium, light")
            .environment(\.colorScheme, .light)
        Since_WidgetEntryView(entry: SinceEventEntry(title: "Since Event", details: "Your event", eventDate: Date(), image: "sincelogo", showYears: true, showDays: true, showHours: true, showMinutes: true, date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
            .previewDisplayName("Medium, dark")
            .environment(\.colorScheme, .dark)
        Since_WidgetEntryView(entry: SinceEventEntry(title: "Since Event", details: "Your event", eventDate: Date(), image: "sincelogo", showYears: true, showDays: true, showHours: true, showMinutes: true, date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
            .previewDisplayName("Large, light")
            .environment(\.colorScheme, .light)
        Since_WidgetEntryView(entry: SinceEventEntry(title: "Since Event", details: "Your event", eventDate: Date(), image: "sincelogo", showYears: true, showDays: true, showHours: true, showMinutes: true, date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
            .previewDisplayName("Large, dark")
            .environment(\.colorScheme, .dark)
    }
}
