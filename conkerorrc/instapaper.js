/* from wiki */
interactive("instapaper", "Send the current page to Instapaper.",
            function (I) {
                check_buffer(I.buffer, content_buffer);
                let posturl = 'https://www.instapaper.com/api/add?' +
                    'username=' + get_pref("instapaper_username") + '&' +
                    'password=' + get_pref("instapaper_password") + '&url=' +
                    encodeURIComponent(I.window.content.location.href)
                    '&selection=' +
                    encodeURIComponent(
                        yield I.minibuffer.read(
                            $prompt = "Description (optional): "));
                try {
            var content = yield send_http_request(load_spec({uri: posturl}));
            if (content.responseText == "201") {
               I.window.minibuffer.message("Instapaper ok!");
            } else {
               I.window.minibuffer.message("Error.");
            }
                } catch (e) {
                    I.window.minibuffer.message("Error.");
        }
        });

interactive("instapaper-link", "Send the current link to Instapaper.",
            function (I) {
              bo = yield read_browser_object(I) ;
              mylink = load_spec_uri_string(load_spec(encodeURIComponent(bo)));
              check_buffer(I.buffer, content_buffer);
              let posturl = 'https://www.instapaper.com/api/add?' +
                    'username=' + get_pref("instapaper_username") + '&' +
                    'password=' + get_pref("instapaper_password") + '&url=' + mylink +
                '&title=' + encodeURIComponent(
                                  yield I.minibuffer.read(
                                  $prompt = "Title (optional): ",
                  $initial_value = bo.textContent)) +
                            '&selection=' + encodeURIComponent(
                                  yield I.minibuffer.read(
                                  $prompt = "Description (optional): ",
                  $initial_value = "From: "+ I.buffer.title +" ("+I.window.content.location.href+")"
));
                try {
            var content = yield send_http_request(load_spec({uri: posturl}));
            if (content.responseText == "201") {
               I.window.minibuffer.message("Instapaper ok!");
            } else {
               I.window.minibuffer.message("Error.");
            }
                } catch (e) {
                    I.window.minibuffer.message("Error.");
        }
            }, $browser_object = browser_object_links);

define_key(content_buffer_normal_keymap, "C-x i", "instapaper");
define_key(content_buffer_normal_keymap, "C-x I", "instapaper-link");