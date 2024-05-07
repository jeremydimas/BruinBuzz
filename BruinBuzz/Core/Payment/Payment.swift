//
//  Payment.swift
//  BruinBuzz
//
//  Created by Jeremy Dimas on 5/3/24.
//

import SwiftUI
import Stripe

struct Payment: View {
    @State private var showingBottomSheet = false
    @State private var isButtonTapped = false
    @State private var isActive: Bool = false
    //    @EnvironmentObject private var cart: Cart
    
    private func startCheckout(completion: @escaping (String?) -> Void)
    {
        let url = URL(string: "https://coconut-better-anemone.glitch.me/create-payment-intent")!
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //        request.httpBody = try? JSONEncoder().encode(cart.items)
        
        URLSession.shared.dataTask(with: request){
            data, response, error in guard let data = data, error == nil, (response as? HTTPURLResponse)?.statusCode == 200
            else{
                completion(nil)
                
                return
            }
            let checkoutIntentResponse = try?
            JSONDecoder().decode(CheckoutIntentResponse.self, from: data)
            completion(checkoutIntentResponse?.clientSecret)
        }.resume()
    }
    
    var body: some View
    {
        HStack
        {
            Button("RSVP"){}
                .foregroundColor(.white)
                .padding() // Add padding to the content
                .frame(width: 110, height: 50)
                .background(Color(.black)) // Add a background color to the button
                .cornerRadius(8) // Add corner radius to the button
            
            
            
            
            
            
            
            
            Button(action: {
                isButtonTapped.toggle()
                showingBottomSheet.toggle()
            }) {
                HStack {
                    Image(systemName: "creditcard.fill")
                        .resizable()
                        .frame(width: 35, height: 30)
                        .foregroundColor(.white) // Customize image color if needed
                    
                    Text("Pay")
                        .foregroundColor(.white) // Customize text color if needed
                }
                .padding() // Add padding to the content
                .frame(width: 110, height: 50)
                .background(Color(.systemBlue)) // Add a background color to the button
                .cornerRadius(8) // Add corner radius to the button
            }
            .sheet(isPresented: $showingBottomSheet) {
                // Content of the bottom sheet
                BottomSheetView()
                    .presentationDetents([.height(250)])
                    .presentationDragIndicator(.visible)
            }
        }
    }
    
    // Checkout View
    struct BottomSheetView: View
    {
        @State private var paymentMethodParams: STPPaymentMethodParams?
        @State private var message: String = ""
        @State private var isSuccess: Bool = false
        
        let paymentGatewayController = PaymentGatewayController()
        
        private func pay()
        {
            guard let clientSecret = PaymentConfig.shared.paymentIntentClientSecret
            else{
                return
            }
            let paymentIntentParams = STPPaymentIntentParams(clientSecret: clientSecret)
            paymentIntentParams.paymentMethodParams = paymentMethodParams
            
            paymentGatewayController.submitPayment(intent: paymentIntentParams)
            {
                status, intent, error in
                switch status
                {
                case.failed:
                    message = "Failed"
                case.canceled:
                    message = "Cancelled"
                case.succeeded:
                    message = "Your payment has been successfully completed!"
                }
            }
        }
        
        var body: some View
        {
            Section
            {
                STPPaymentCardTextField.Representable
                    .init(paymentMethodParams: $paymentMethodParams)
                    .frame(width:300)
            }
        header:{
            Text("Checkout")
                .font(.title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .padding(.leading,-150)
                .padding(.bottom,5)
            Text("PAYMENT INFORMATION")
                .padding(.leading,-145)
                .font(.system(size: 13))
                .foregroundColor(.gray)
        }
            
            Button("Complete Payment")
            {
                pay()
            }
            .padding() // Add padding to the content
            .frame(width: 300, height: 50)
            .background(Color(.systemBlue)) // Add a background color to the button
            .foregroundColor(.white)
            .cornerRadius(8) // Add corner radius to the button
            }
        }
    }

struct Payment_Previews: PreviewProvider {
    static var previews: some View {
        Payment()
    }
}


