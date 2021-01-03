//
//  Since_Widget.swift
//  Since Widget
//
//  Created by David Smailes on 26/10/2020.
//

import WidgetKit
import SwiftUI
import Foundation

struct SinceEventEntry: TimelineEntry {
    var title: String
    var eventDate: Date
    var image: String?
    var showYears: Bool
    var showDays: Bool
    var showHours: Bool
    var showMinutes: Bool
    var date: Date
}

struct Provider: TimelineProvider {
    
    var widgetNumber: Int
    
    func placeholder(in context: Context) -> SinceEventEntry {
        SinceEventEntry(title: "Since Event", eventDate: Date(), image: "sincelogo", showYears: true, showDays: true, showHours: true, showMinutes: true, date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SinceEventEntry) -> ()) {
        let entry = SinceEventEntry(title: "Since Event", eventDate: Date(), image: "sincelogo", showYears: true, showDays: true, showHours: true, showMinutes: true, date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SinceEventEntry] = []

        let event = EventDecoder.sharedInstance.decodeEvent(number: widgetNumber)
        
        let entry = SinceEventEntry(title: event.title, eventDate: event.date, image: event.image ?? "sincelogo", showYears: event.showYears, showDays: event.showDays, showHours: event.showHours, showMinutes: event.showMinutes, date: Date())

        entries.append(entry)
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct Since_WidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        SinceWidgetView(event: WidgetSinceEvent(title: entry.title, date: entry.eventDate, image: entry.image ?? "sincelogo", showYears: entry.showYears, showDays: entry.showDays, showHours: entry.showHours, showMinutes: entry.showMinutes))
    }
}

@main
struct SinceWidgetsBundle: WidgetBundle {
    var body: some Widget {
        Since_Widget()
        Since_Widget_1()
        Since_Widget_2()
        Since_Widget_3()
        Since_Widget_4()
    }
    
}

struct Since_Widget: Widget {
    
    let kind: String = "Since_Widget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider(widgetNumber: 0)) { entry in
            Since_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Since")
        .description("Default Since Widget.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
    
}

struct Since_Widget_1 : Widget {
    
    let kind: String = "Since_Widget_1"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider(widgetNumber: 1)) { entry in
            Since_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Since")
        .description("Since Widget 2.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
    
}

struct Since_Widget_2: Widget {
    
    let kind: String = "Since_Widget_2"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider(widgetNumber: 2)) { entry in
            Since_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Since")
        .description("Since Widget 3.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
    
}

struct Since_Widget_3: Widget {
    
    let kind: String = "Since_Widget_3"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider(widgetNumber: 3)) { entry in
            Since_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Since")
        .description("Since Widget 4.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
    
}

struct Since_Widget_4: Widget {
    
    let kind: String = "Since_Widget_4"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider(widgetNumber: 4)) { entry in
            Since_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Since")
        .description("Since Widget 5.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
    
}


struct Since_Widget_Previews: PreviewProvider {
    static var previews: some View {
        Since_WidgetEntryView(entry: SinceEventEntry(title: "Since Event", eventDate: Date(), image: "sincelogo", showYears: true, showDays: true, showHours: true, showMinutes: true, date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
            .previewDisplayName("Small, light")
            .environment(\.colorScheme, .light)
        Since_WidgetEntryView(entry: SinceEventEntry(title: "Since Event", eventDate: Date(), image: "sincelogo", showYears: true, showDays: true, showHours: true, showMinutes: true, date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
            .previewDisplayName("Small, dark")
            .environment(\.colorScheme, .dark)
        Since_WidgetEntryView(entry: SinceEventEntry(title: "Since Event", eventDate: Date(), image: "sincelogo", showYears: true, showDays: true, showHours: true, showMinutes: true, date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
            .previewDisplayName("Medium, light")
            .environment(\.colorScheme, .light)
        Since_WidgetEntryView(entry: SinceEventEntry(title: "Since Event", eventDate: Date(), image: "sincelogo", showYears: true, showDays: true, showHours: true, showMinutes: true, date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
            .previewDisplayName("Medium, dark")
            .environment(\.colorScheme, .dark)
        Since_WidgetEntryView(entry: SinceEventEntry(title: "Since Event", eventDate: Date(), image: "sincelogo", showYears: true, showDays: true, showHours: true, showMinutes: true, date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
            .previewDisplayName("Large, light")
            .environment(\.colorScheme, .light)
        Since_WidgetEntryView(entry: SinceEventEntry(title: "Since Event", eventDate: Date(), image: "sincelogo", showYears: true, showDays: true, showHours: true, showMinutes: true, date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
            .previewDisplayName("Large, dark")
            .environment(\.colorScheme, .dark)
    }
}
