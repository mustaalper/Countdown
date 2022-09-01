//
//  ContentView.swift
//  Countdown
//
//  Created by MAA on 31.08.2022.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date/*, order: .reverse*/)]) var activity: FetchedResults<Activity>
    
    @State private var showingAddView = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("\(Int(totalActivityToday())) Activity Today")
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                List {
                    ForEach(activity) { activity in
                        NavigationLink(destination: EditActivityView(activity: activity)) {
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(activity.name!)
                                        .bold()
                                    Text(activity.title!)
                                }
                                Spacer()
                                Text(calcTimeSince(date: activity.date!))
                                    .foregroundColor(.gray)
                                    .italic()
                            }
                        }
                    }
                    .onDelete(perform: deleteActivity)
                }
                .listStyle(.plain)
            }
            .navigationTitle("Countdown")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddView.toggle()
                    } label: {
                        Label("Add Activity", systemImage: "plus.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddActivityView()
            }
        }
        .navigationViewStyle(.stack)
    }
    
    private func deleteActivity(offsets: IndexSet) {
        withAnimation {
            offsets.map { activity[$0] }.forEach(managedObjContext.delete)
            
            DataController().save(context: managedObjContext)
        }
    }
    
    private func totalActivityToday() -> Double {
        var activityTotal: Double = 0
        for item in activity {
            if Calendar.current.isDateInToday(item.date!) {
                activityTotal += 1
            }
        }
        return activityTotal
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
