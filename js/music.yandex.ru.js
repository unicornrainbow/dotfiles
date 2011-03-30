// scrobbling yandex music to last.fm
// please change these to yours:
window.lastfm_api_key = '40e98792ad75dc44597487ca4d134f7a';
window.lastfm_api_secret = '8ea47ed360b4cb76b70438baecbcb82e';
// ---
// http://pajhome.org.uk/crypt/md5
(function(a){function s(a,b){return n(r(a,b))}function r(a,b){return m(o(a),o(b))}function q(a){return n(p(a))}function p(a){return l(o(a))}function o(a){return unescape(encodeURIComponent(a))}function n(a){var b="0123456789abcdef",c="",d,e;for(e=0;e<a.length;e+=1)d=a.charCodeAt(e),c+=b.charAt(d>>>4&15)+b.charAt(d&15);return c}function m(a,b){var c,d=k(a),e=[],f=[],g;e[15]=f[15]=undefined,d.length>16&&(d=i(d,a.length*8));for(c=0;c<16;c+=1)e[c]=d[c]^909522486,f[c]=d[c]^1549556828;g=i(e.concat(k(b)),512+b.length*8);return j(i(f.concat(g),640))}function l(a){return j(i(k(a),a.length*8))}function k(a){var b,c=[];c[(a.length>>2)-1]=undefined;for(b=0;b<c.length;b+=1)c[b]=0;for(b=0;b<a.length*8;b+=8)c[b>>5]|=(a.charCodeAt(b/8)&255)<<b%32;return c}function j(a){var b,c="";for(b=0;b<a.length*32;b+=8)c+=String.fromCharCode(a[b>>5]>>>b%32&255);return c}function i(a,c){a[c>>5]|=128<<c%32,a[(c+64>>>9<<4)+14]=c;var d,i,j,k,l,m=1732584193,n=-271733879,o=-1732584194,p=271733878;for(d=0;d<a.length;d+=16)i=m,j=n,k=o,l=p,m=e(m,n,o,p,a[d+0],7,-680876936),p=e(p,m,n,o,a[d+1],12,-389564586),o=e(o,p,m,n,a[d+2],17,606105819),n=e(n,o,p,m,a[d+3],22,-1044525330),m=e(m,n,o,p,a[d+4],7,-176418897),p=e(p,m,n,o,a[d+5],12,1200080426),o=e(o,p,m,n,a[d+6],17,-1473231341),n=e(n,o,p,m,a[d+7],22,-45705983),m=e(m,n,o,p,a[d+8],7,1770035416),p=e(p,m,n,o,a[d+9],12,-1958414417),o=e(o,p,m,n,a[d+10],17,-42063),n=e(n,o,p,m,a[d+11],22,-1990404162),m=e(m,n,o,p,a[d+12],7,1804603682),p=e(p,m,n,o,a[d+13],12,-40341101),o=e(o,p,m,n,a[d+14],17,-1502002290),n=e(n,o,p,m,a[d+15],22,1236535329),m=f(m,n,o,p,a[d+1],5,-165796510),p=f(p,m,n,o,a[d+6],9,-1069501632),o=f(o,p,m,n,a[d+11],14,643717713),n=f(n,o,p,m,a[d+0],20,-373897302),m=f(m,n,o,p,a[d+5],5,-701558691),p=f(p,m,n,o,a[d+10],9,38016083),o=f(o,p,m,n,a[d+15],14,-660478335),n=f(n,o,p,m,a[d+4],20,-405537848),m=f(m,n,o,p,a[d+9],5,568446438),p=f(p,m,n,o,a[d+14],9,-1019803690),o=f(o,p,m,n,a[d+3],14,-187363961),n=f(n,o,p,m,a[d+8],20,1163531501),m=f(m,n,o,p,a[d+13],5,-1444681467),p=f(p,m,n,o,a[d+2],9,-51403784),o=f(o,p,m,n,a[d+7],14,1735328473),n=f(n,o,p,m,a[d+12],20,-1926607734),m=g(m,n,o,p,a[d+5],4,-378558),p=g(p,m,n,o,a[d+8],11,-2022574463),o=g(o,p,m,n,a[d+11],16,1839030562),n=g(n,o,p,m,a[d+14],23,-35309556),m=g(m,n,o,p,a[d+1],4,-1530992060),p=g(p,m,n,o,a[d+4],11,1272893353),o=g(o,p,m,n,a[d+7],16,-155497632),n=g(n,o,p,m,a[d+10],23,-1094730640),m=g(m,n,o,p,a[d+13],4,681279174),p=g(p,m,n,o,a[d+0],11,-358537222),o=g(o,p,m,n,a[d+3],16,-722521979),n=g(n,o,p,m,a[d+6],23,76029189),m=g(m,n,o,p,a[d+9],4,-640364487),p=g(p,m,n,o,a[d+12],11,-421815835),o=g(o,p,m,n,a[d+15],16,530742520),n=g(n,o,p,m,a[d+2],23,-995338651),m=h(m,n,o,p,a[d+0],6,-198630844),p=h(p,m,n,o,a[d+7],10,1126891415),o=h(o,p,m,n,a[d+14],15,-1416354905),n=h(n,o,p,m,a[d+5],21,-57434055),m=h(m,n,o,p,a[d+12],6,1700485571),p=h(p,m,n,o,a[d+3],10,-1894986606),o=h(o,p,m,n,a[d+10],15,-1051523),n=h(n,o,p,m,a[d+1],21,-2054922799),m=h(m,n,o,p,a[d+8],6,1873313359),p=h(p,m,n,o,a[d+15],10,-30611744),o=h(o,p,m,n,a[d+6],15,-1560198380),n=h(n,o,p,m,a[d+13],21,1309151649),m=h(m,n,o,p,a[d+4],6,-145523070),p=h(p,m,n,o,a[d+11],10,-1120210379),o=h(o,p,m,n,a[d+2],15,718787259),n=h(n,o,p,m,a[d+9],21,-343485551),m=b(m,i),n=b(n,j),o=b(o,k),p=b(p,l);return[m,n,o,p]}function h(a,b,c,e,f,g,h){return d(c^(b|~e),a,b,f,g,h)}function g(a,b,c,e,f,g,h){return d(b^c^e,a,b,f,g,h)}function f(a,b,c,e,f,g,h){return d(b&e|c&~e,a,b,f,g,h)}function e(a,b,c,e,f,g,h){return d(b&c|~b&e,a,b,f,g,h)}function d(a,d,e,f,g,h){return b(c(b(b(d,a),b(f,h)),g),e)}function c(a,b){return a<<b|a>>>32-b}function b(a,b){var c=(a&65535)+(b&65535),d=(a>>16)+(b>>16)+(c>>16);return d<<16|c&65535}a.extend({md5:function(a,b,c){if(!b)return c?p(a):q(a);return c?r(b,a):s(b,a)}})})(jQuery)
// ---

function get_track() {
    var player = $('.js-player-playing');
    return {artist: player.find('.js-player-artist').text(), title: player.find('.js-player-title').text()}
}

function scrobble(track) {
    if (typeof localStorage.last_fm_sk == 'undefined') {
        $('<div><a style="color:white" href="http://www.last.fm/api/auth/?api_key='+lastfm_api_key+'&cb='+document.location.href.replace(/#!.*/, '')+'">Log in with Last.fm!</a></div>')
        .css({background: 'rgba(20,20,20,0.8)', font: '34px Helvetica', position: 'absolute',
        top: '20%', 'text-align': 'center', width: '40%', left: '30%', 'z-index': '100500', padding: '10px'}).appendTo('body');
    }
    else {
        // https://github.com/fxb/javascript-last.fm-api/blob/master/lastfm.api.js
		var iframe = document.createElement('iframe'), doc;
        iframe.style.visibility = 'hidden';
        $(iframe).appendTo('body');
        if (typeof(iframe.contentWindow) != 'undefined') doc = iframe.contentWindow.document;
        else if (typeof(iframe.contentDocument.document) != 'undefined') doc = iframe.contentDocument.document.document;
        else doc = iframe.contentDocument.document;
        doc.open();
        doc.clear();
        doc.write('<form method="post" action="http://ws.audioscrobbler.com/2.0/" id="form">');
        var params = {api_key: lastfm_api_key, artist: track.artist, method: 'track.scrobble',
        sk: localStorage.last_fm_sk, timestamp: Math.round((new Date()).getTime() / 1000), track: track.title}, sig='';
        $.each(params, function(key, val) {
            sig += key+val;
            doc.write('<input type="text" name="'+key+'" value="'+val+'">');
        });
        sig += lastfm_api_secret;
        doc.write('<input type="text" name="api_sig" value="'+$.md5(sig)+'">');
        doc.write('</form><script>document.getElementById("form").submit();</script>');
        doc.close();
    }
}

setInterval(function() {
    var track = get_track();
    if (track.artist != '' &&
        (typeof localStorage.last_played_artist == 'undefined' || typeof localStorage.last_played_title == 'undefined' ||
         localStorage.last_played_artist != track.artist || localStorage.last_played_title != track.title)) {
        try {
            scrobble(track);
            localStorage.last_played_artist = track.artist;
            localStorage.last_played_title = track.title;
        }
        catch(e) {console.log(e)}
    }
}, 10000);

if (/token=/.test(document.location.search)) {
    var token = document.location.search.split('token=').slice(-1, 2)[0],
    props = {api_key: lastfm_api_key, method: 'auth.getSession', token: token},
    sig = '', params = '';
    $.each(props, function(key, val) {
        sig += key+val;
        params += encodeURIComponent(key)+'='+encodeURIComponent(val)+'&';
    });
    sig += lastfm_api_secret;
    params = (params+'format=json&callback=?&api_sig='+encodeURIComponent($.md5(sig))).replace(/%20/g, '+');
    $('<scr'+'ipt>jQuery.getJSON("http://ws.audioscrobbler.com/2.0/?'+params+'",function(data){localStorage.last_fm_sk=data.session.key})</script>').appendTo('head');
}
