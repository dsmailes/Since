//
//  Since_Widget.swift
//  Since Widget
//
//  Created by David Smailes on 26/10/2020.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct Since_WidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        SinceWidgetView(image: "sincelogo", text: "10")
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

struct Since_Widget_Previews: PreviewProvider {
    static var previews: some View {
        Since_WidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
            .previewDisplayName("Small, light")
            .environment(\.colorScheme, .light)
        Since_WidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
            .previewDisplayName("Small, dark")
            .environment(\.colorScheme, .dark)
        Since_WidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
            .previewDisplayName("Medium, light")
            .environment(\.colorScheme, .light)
        Since_WidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
            .previewDisplayName("Medium, dark")
            .environment(\.colorScheme, .dark)
        Since_WidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
            .previewDisplayName("Large, light")
            .environment(\.colorScheme, .light)
        Since_WidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
            .previewDisplayName("Large, dark")
            .environment(\.colorScheme, .dark)
    }
}
