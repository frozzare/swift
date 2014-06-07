import Foundation

class Request : NSObject {

    var url : NSURL? = nil
    var request : NSMutableURLRequest? = nil
    var response : NSHTTPURLResponse? = nil
    
    var data: NSMutableData? = nil
    var done: (NSError?, NSData, NSString?) -> () = { (_, _, _) -> () in }

    init (method: String, url: String, done: (NSError?, NSData, NSString?) -> ()) {
        let _url = NSURL(string: url)
        self.request = NSMutableURLRequest(URL: _url)
        self.request!.HTTPMethod = method;
        self.done = done
        self.data = NSMutableData()
    }

    func start () {
        let connection = NSURLConnection(request: self.request, delegate: self, startImmediately: true)
    }
    
    class func get (url: String, done: (NSError?, NSData, NSString?) -> ()) -> Void {
        return Request(method: "GET", url: url, done: done).start();
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
        self.data!.appendData(data)
    }
    
    func connection(connection: NSURLConnection!, didReceiveResponse response: NSHTTPURLResponse!) {
        self.response = response
    }

    func connectionDidFinishLoading(connection: NSURLConnection!) {
        let text = NSString(data: self.data, encoding: NSUTF8StringEncoding)
        self.done(nil, self.data!, text)
    }
    
    func connection(connection: NSURLConnection!, didFailWithError error: NSError!) {
        self.done(error, nil!, nil)
    }
}

func waitFor (inout wait: Bool) {
    while (wait) {
        NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode,
            beforeDate: NSDate(timeIntervalSinceNow: 0.1))
    }
}

var wait: Bool = true

Request.get("http://svt.se", { (error: NSError?, data: NSData, text: NSString?) -> () in
    println(text)
    wait = false
})

waitFor(&wait)