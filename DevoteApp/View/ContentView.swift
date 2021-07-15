//
//  ContentView.swift
//  DevoteApp
//
//  Created by mahmoud hajar on 29/06/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    // MARK: - PROPERTY
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @State var task: String = ""
    @State private var showNewTaskItem: Bool = false
    
    //MARK:- FETCHING DATA
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    //MARK:- BODY
    var body: some View {
        NavigationView {
            ZStack {
                //MARK:- Main View
                VStack {
                    //MARK:- Header
                    HStack(spacing:10) {
                         
                        Text("DEVOTE")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.heavy)
                            .padding(.leading,4)
                        
                        Spacer()
                        
                    EditButton()
                      .font(.system(size: 16,weight: .semibold , design: .rounded))
                          .padding()
                          .frame(minWidth:70, minHeight: 24)
                          .background(
                            Capsule().stroke(Color.white,lineWidth: 2)
                        )
                        
                        Button(action: {
                            isDarkMode.toggle()
                        }, label: {
                            Image(systemName: isDarkMode ? "moon.circle.fill" : "moon.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width:24, height: 24)
                    })

                        
                    }// HSTACK
                    .padding()
                    .foregroundColor(.white)
                  
                    Spacer(minLength: 18)
                    
                    //MARK:- New Task Button
                    Button(action: {
                        showNewTaskItem = true
                    }, label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                        Text("New Task")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                    })
                    .foregroundColor(.white)
                    .padding(.horizontal,20)
                    .padding(.vertical,15)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), startPoint: .leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing)
                            .clipShape(Capsule())
                    )
                    .shadow(color: Color(red:0, green:0, blue:0, opacity: 0.25), radius: 8, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 4.0)
                    //MARK:- Tasks

                    
                    List {
                        ForEach(items) { item in
                         ListRowItemView(item: item)
                        }
                        .onDelete(perform: deleteItems)
                    }//: List
                    .listStyle(InsetGroupedListStyle())
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3) , radius: 12)
                    .padding(.vertical,0)
                    .frame(maxWidth:640)
                }//: VSTACK
                .navigationBarTitle("Daily Tasks",displayMode: .large)
                .navigationBarHidden(true)
                .background(BackgroundImageView())
                .background(backgroundGradient.ignoresSafeArea(.all))

                //MARK:- New Task Item
                if showNewTaskItem {
                    BlankView()
                        .onTapGesture {
                            withAnimation() {
                                showNewTaskItem = false
                     }}
                    NewTaskItemView(isShowing: $showNewTaskItem)
                }
                
                
            }//: ZSTACK
            .onAppear() {
                UITableView.appearance().backgroundColor = .clear
            }
        }//:NAVIGATION
        .navigationViewStyle(StackNavigationViewStyle())
    }

   

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

//.toolbar {
//    #if os(iOS)
//    ToolbarItem(placement: .navigationBarTrailing) {
//        EditButton()
//    }
//    #endif
////                ToolbarItem(placement: .navigationBarTrailing) {
////                    Button(action: addItem) {
////                        Label("Add Item", systemImage: "plus")
////                    }
////                }
//} //: TOOLBAR
