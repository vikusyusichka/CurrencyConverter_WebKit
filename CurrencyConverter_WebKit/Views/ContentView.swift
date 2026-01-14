import SwiftUI
import WebKit

struct ContentView: View {
    @State private var isLoading = true
    @StateObject var webWrapper = WebViewWrapper()
    
    var body: some View {
        ZStack {
            WebView(wrapper: webWrapper, isLoading: $isLoading)
                .edgesIgnoringSafeArea(.bottom)
            
            if isLoading {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .padding()
                    .cornerRadius(10)
            }
            VStack{
                Spacer()
                
                if !isLoading {
                        HStack {
                            HStack(spacing: 15) {
                                Button(action: { webWrapper.goBack() }) {
                                    Image(systemName: "chevron.left")
                                        .font(.system(size: 24, weight: .semibold))
                                        .frame(width: 45, height: 45)
                                        .background(webWrapper.canGoBack ? Color.black.opacity(0.4) : Color.gray.opacity(0.3))
                                        .foregroundColor(.white)
                                        .clipShape(Circle())
                                }
                                .disabled(!webWrapper.canGoBack)
                                
                                Button(action: { webWrapper.goForward() }) {
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 24, weight: .semibold))
                                        .frame(width: 45, height: 45)
                                        .background(webWrapper.canGoForward ? Color.black.opacity(0.4) : Color.gray.opacity(0.3))
                                        .foregroundColor(.white)
                                        .clipShape(Circle())
                                }
                                .disabled(!webWrapper.canGoForward)
                            }
                            
                            Spacer()
                            
                            Button(action: { webWrapper.reload() }) {
                                Image(systemName: "arrow.clockwise")
                                    .font(.system(size: 24, weight: .semibold))
                                    .frame(width: 45, height: 45)
                                    .background(Color.black.opacity(0.4))
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                            }
                        }
                        .padding(.horizontal, 20)
                        }
            }
        }
    }
}
#Preview {
    ContentView()
}
