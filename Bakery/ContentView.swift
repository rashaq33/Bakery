//
//  ContentView.swift
//  Bakery
//
//  Created by رشا القرني on 27/07/1446 AH.
//


import SwiftUI

struct ContentView: View {
  
   
    @StateObject private var object = BaseClass(isActive: false, size: 0.8, op: 0.5)
            
            var body: some View {
                // سويت اوبجكت واستعيت معرف مناسب للسبلاش
                

                if object.isActive {
                    //لو صفحه اشتغلت روح بعدها للصفحه ثانيه
                    HomeView()

                }
                else{
                    ZStack{
                      
                        VStack{
                            Image("bakery")
                                .resizable()
                                .frame(width: 202,height: 168)
                               
                            
                            
                            Text("Home Bakery")
                                .font(.system(size: 50))
                                .fontWeight(.bold)
                                .foregroundColor(Color.browny)
                            Text("")
                            Text("Baked to Perfection")
                                .foregroundColor(Color.browny)
                                .font(.system(size: 30))
                        }
                        //  ذا كود علشان يتحرك لوغو والكلام لقدام شوي
                        .scaleEffect(object.size)
                        .opacity(object.op)
                        .onAppear{
                            //مده التحرك
                            withAnimation(.easeIn(duration: 3)){
                                object.size = 0.9
                                object.op = 1.0
                                
                            }
                        }
                    }
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                            withAnimation {
                                //اخليه ترو علشان لما فوق قلت لوصار ترو روح للصفه الرئسيه
                                object.isActive = true
                            }
                            
                        }
                    }
                  
                   
                }
            }
    

        }
                
        
#Preview {
    ContentView()
}
