// dotjs implementation that doesn't need defunkt's original server
// really, why use a server for that?

add_hook('current_content_buffer_finished_loading_hook', function(I){
    var cont = I.window.content, scpt,
    doc = cont.wrappedJSObject.document, body = doc.body || doc.documentElement,
    url = 'file://' + getenv('HOME') + '/.js/' + cont.location.hostname + '.js',
    xhr = xhr2 = xml_http_request();
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4) {
            scpt = xhr.responseText;
            xhr2.open('GET', 'file://' + getenv('HOME') + '/.conkerorrc/jquery.js.noload', true);
            xhr2.send();
        }
    }
    xhr2.onreadystatechange = function() {
        if (xhr.readyState == 4) {
            s1 = doc.createElement('script');
            s1.innerHTML = scpt;
            body.appendChild(s1);
//            body.innerHTML += '<script>' + xhr.responseText + '</script><script>' + scpt + '</script>'
        }
    }
    xhr.open('GET', url, true);
    xhr.send();
//    cont.wrappedJSObject.eval('document.body.innerHTML += "cock"');
});
