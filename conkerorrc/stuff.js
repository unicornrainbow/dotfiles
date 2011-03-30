xkcd_add_title = true;
homepage = "http://start.io/myfreeweb";

define_key(content_buffer_normal_keymap, "n", "follow-new-buffer");

add_hook("window_before_close_hook",
         function () {
             var w = get_recent_conkeror_window();
             var result = (w == null) ||
                 "y" == (yield w.minibuffer.read_single_character_option(
                     $prompt = "Quit Conkeror? (y/n)",
                     $options = ["y", "n"]));
             yield co_return(result);
         });

interactive("microformats", "Get microformatted data from this page", function(I) {
    check_buffer(I.buffer, content_buffer);
    I.buffer.document.location.href = "javascript:(function(){function%20l(u,i,t,b){var%20d=document;if(!d.getElementById(i)){var%20s=d.createElement('script');s.src=u;s.id=i;d.body.appendChild(s)}s=setInterval(function(){u=0;try{u=t.call()}catch(i){}if(u){clearInterval(s);b.call()}},200)}l('http://leftlogic.com/js/microformats.js','MF_loader',function(){return!!(typeof%20MicroformatsBookmarklet=='function')},%20function(){MicroformatsBookmarklet()})})();"
});

define_key(content_buffer_normal_keymap, "m", "microformats");
