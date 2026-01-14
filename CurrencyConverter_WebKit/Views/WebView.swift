import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    @ObservedObject var wrapper: WebViewWrapper
    @Binding var isLoading: Bool
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = wrapper.webView
        webView.navigationDelegate = context.coordinator
        if let url = URL(string: "https://www.oanda.com/currency-converter/en/?from=EUR&to=USD&amount=1") {
            webView.load(URLRequest(url: url))
        }
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(isLoading: $isLoading, wrapper: wrapper)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        @Binding var isLoading: Bool
        var wrapper: WebViewWrapper

        init(isLoading: Binding<Bool>, wrapper: WebViewWrapper) {
            _isLoading = isLoading
            self.wrapper = wrapper
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            isLoading = true
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            isLoading = false
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            isLoading = false
        }

        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            isLoading = false
        }
    }
}



