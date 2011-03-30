interactive("pin", "bookmark current page on pinboard.in",
            function (I) {
                check_buffer(I.buffer, content_buffer);
                var doc = I.buffer.document, desc;
                if (doc.getSelection) desc = "&description=" + encodeURIComponent(doc.getSelection())
                else desc = "";
                doc.location = "https://pinboard.in/add?next=same&url=" +
                    encodeURIComponent(doc.location) + "&title=" +
                    encodeURIComponent(doc.title) + desc
            });
define_key(content_buffer_normal_keymap, "C-d", "pin")
define_webjump("pinboard", "http://pinboard.in/search/?query=%s&mine=Search+Mine")