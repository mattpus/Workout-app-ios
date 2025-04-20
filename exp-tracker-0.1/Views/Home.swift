//
//  Home.swift
//  exp-tracker-0.1
//
//  Created by Pusiewicz, M. (Mateusz) on 26/09/2024.
//

import SwiftUI

struct Home: View {
    @State var progress: CGFloat = 0.5
    // MARK: Current Month
    @State var currentMonth: String = "Jan"
    @Environment(\.modelContext) private var modelContext
    @State private var showingAddTemplateSheet = false // State to control sheet presentation
//    @Namespace var animation
    
    var body: some View {
        VStack(spacing: 15){
            HStack{
                
                Button {
                    
                } label: {
                    Image(systemName: "arrow.left")
                        .frame(width: 40,height: 40)
                        .background{
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .stroke(.gray.opacity(0.4),lineWidth: 1)
                        }
                }

                Spacer()
                
                Button {
                    
                } label: {
                 
                    Image(systemName: "ellipsis")
                        .font(.title3)
                        .rotationEffect(.init(degrees: -90))
                }
            }
            .foregroundColor(.white)
            .padding(.horizontal)

            // Button to add new workout template
            Button {
                showingAddTemplateSheet = true // Set state to true to show the sheet
            } label: {
                Label("Add Workout Template", systemImage: "plus.circle.fill")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top) // Add some spacing above the button
            
            // MARK: Custom Gradient Card
            VStack{
                Text("Lifted this month")
                    .fontWeight(.semibold)
                    .foregroundColor(.black.opacity(0.7))
                
                AnimatedNumberText(value: progress * 1299, font: .system(size: 35, weight: .black),isCurrency: true)
                    .foregroundColor(Color("VeryLightGreen"))
                    .padding(.top,5)
                    .lineLimit(1)
                
                // MARK: SpeedoMeter
                SpeedoMeter(progress: $progress)
            }
            // i am making thidfsdfsdf change to see if it is tracked by gitsdf
            .padding(.top,50)
            .frame(maxWidth: .infinity)
            .frame(height: 340)
            // MARK: Custom Background
            .background{
                RoundedRectangle(cornerRadius: 45, style: .continuous)
                    .fill(
                        .linearGradient(colors: [
                            Color("LightGreen")
                                .opacity(0.4),
                            Color("LightGreen")
                                .opacity(0.2),
                            Color("LightGreen")
                                .opacity(0.1),
                        ] + Array(repeating: Color(.systemGray4), count: 5), startPoint: .topTrailing, endPoint: .bottomLeading)
                    )
            }
            .padding(.top,15)
            .padding(.horizontal,15)
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
        .padding(.top,15)
//        .background{
//            Color("BG")
//                .ignoresSafeArea()
//        }
        .onAppear{
            // Assuming progressArray exists elsewhere or needs definition
            // progress = progressArray[0] 
        }
        .sheet(isPresented: $showingAddTemplateSheet) {
            // Present AddWorkoutTemplateView when showingAddTemplateSheet is true
            AddWorkoutTemplateView(modelContext: modelContext)
        }
    }
    
    // MARK: Bottom Content
    @ViewBuilder
    func BottomContent()->some View{
        VStack(spacing: 15){
            ForEach(expenses){expense in
                HStack(spacing: 12){
                    
                    Image(expense.icon)
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35, height: 35)
                        .foregroundColor(.white)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(expense.title)
                            .fontWeight(.bold)
                        
                        Text(expense.subTitle)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity,alignment: .leading)
                    
                    Text(expense.amount)
                        .fontWeight(.bold)
                }
                .padding()
            }
        }
    }
    
    // MARK: Retreiving Index
    func getIndex(month: String)->Int{
        return months.firstIndex { value in
            return month == value
        } ?? 0
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
