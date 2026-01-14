import SwiftUI
import Combine
import WebKit

class WebViewWrapper: ObservableObject {
    @Published var canGoBack = false
    @Published var canGoForward = false
    var webView = WKWebView()
    private var canGoBackObserver: NSKeyValueObservation?
    private var canGoForwardObserver: NSKeyValueObservation?
    
    init() {
        canGoBackObserver = webView.observe(\.canGoBack, options: [.new]) { [weak self] webView, _ in
            self?.canGoBack = webView.canGoBack
        }
        
        canGoForwardObserver = webView.observe(\.canGoForward, options: [.new]) { [weak self] webView, _ in
            self?.canGoForward = webView.canGoForward
        }
    }
    
    func goBack() {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    func goForward() {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    func reload() {
        webView.reload()
    }
}
