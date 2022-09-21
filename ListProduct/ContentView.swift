//
//  ContentView.swift
//  ListProduct
//
//  Created by Марк Горкій on 20.09.2022.
//

import SwiftUI

struct ContentView: View {
    @State var listItems = [Item]()

        @State var addItemName: String = ""

        @State var colorSelection: UIColor = UIColor.systemRed

        @State var addItem = false
    var body: some View {
        ZStack {
                   VStack {
                       NavigationView {
                           List {
                               ForEach(listItems, id: \.self) { item in
                                   Text(item.name).listRowBackground(Color(item.color))
                               }.onDelete(perform: delete)
                           }
                               .navigationBarTitle(Text("Products"))
                               .navigationBarItems(trailing:
                                   Button(action: {
                                       self.addItem.toggle()
                                   }, label: {
                                       Image(systemName: "plus")
                                   })
                           )
                             
                       }.sheet(isPresented: $addItem) {
                           VStack {
                               HStack {
                                   Text("Item Name: ")
                                   TextField("Type...", text: self.$addItemName)
                               }
                               Picker(selection: self.$colorSelection, label: Text("Select a Color")) {
                                   Text("Red").tag(UIColor.systemRed)
                                   Text("Blue").tag(UIColor.systemBlue)
                                   Text("Brown").tag(UIColor.systemBrown)
                               }
                               Spacer()
                                   .frame(height: 20.0)
                               Button(action: {
                                   self.listItems.append(Item(name: self.addItemName, color: self.colorSelection))

                                 
                                   self.addItem.toggle()
                                   self.addItemName = ""
                                   self.colorSelection = UIColor.systemRed
                               }, label: {
                                   Text("Add")
                                   . frame(minWidth: 0, maxWidth: . infinity)
                                   . font(. system(size: 15))
                                   . padding()
                                   . foregroundColor(. black)
                                   .overlay(
                                    RoundedRectangle(cornerRadius: 15) .stroke(Color.red, lineWidth: 2))
                                   .frame(width: 70.0, height: 20.0)
                                       
                                   
                               })
                           }.padding(100)
                       }

               }
           }
       }
    func delete(at offsets: IndexSet) {
        listItems.remove(atOffsets: offsets)
       }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
