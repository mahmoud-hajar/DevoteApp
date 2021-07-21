//
//  DevoteWidegt.swift
//  DevoteWidegt
//
//  Created by mahmoud hajar on 19/07/2021.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}
//Change Widget UI
struct DevoteWidegtEntryView : View {
    var entry: Provider.Entry
        
    @Environment(\.widgetFamily) var widgetFamily

    var fontStyle: Font {
      if widgetFamily == .systemSmall {
        return .system(.footnote, design: .rounded)
      } else {
        return .system(.headline, design: .rounded)
      }
    }
    
    var body: some View {
       // Text(entry.date, style: .time)
        
        GeometryReader { geometry in
          ZStack {
            backgroundGradient
            Image("rocket-small")
              .resizable()
              .scaledToFit()
            
            Image("logo")
              .resizable()
              .frame(
                width: widgetFamily != .systemSmall ? 56 : 36,
                height: widgetFamily != .systemSmall ? 56 : 36
              )
              .offset(
                x: (geometry.size.width / 2) - 20,
                y: (geometry.size.height / -2) + 20
              )
              .padding(.top, widgetFamily != .systemSmall ? 32 : 12)
              .padding(.trailing, widgetFamily != .systemSmall ? 32 : 12)
            
            HStack {
              Text("Just Do It")
                .foregroundColor(.white)
                .font(fontStyle)
                .fontWeight(.bold)
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .background(
                  Color(red: 0, green: 0, blue: 0, opacity: 0.5)
                    .blendMode(.overlay)
                )
                .clipShape(Capsule())
              
              if widgetFamily != .systemSmall {
                Spacer()
              }
            } //: HSTACK
            .padding()
            .offset(y: (geometry.size.height / 2) - 24)
          } //: ZSTACK
        } //: GEOMETRY
        
        
        
    }
}

@main
struct DevoteWidegt: Widget {
    let kind: String = "DevoteWidegt"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            DevoteWidegtEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct DevoteWidegt_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DevoteWidegtEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            DevoteWidegtEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            DevoteWidegtEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}
