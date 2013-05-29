{:user {:dependencies [[clj-stacktrace "0.2.5"]
                       [org.clojure/tools.namespace "0.2.3"]
                       [spyscope "0.1.3"]
                       [javert "0.2.0-SNAPSHOT"]
                       [ritz/ritz-nrepl-middleware "0.7.0"]
                       [slamhound "1.3.1"]]
        :plugins [[lein-light "0.0.16"]
                  [lein-swank "1.4.5"]
                  [lein-pprint "1.1.1"]
                  [lein-clojars "0.9.1"]
                  [lein-localrepo "0.4.1"]
                  [lein-sub "0.2.4"]
                  [lein-kibit "0.0.8"]
                  [lein-create-template "0.1.1"]
                  [lein-deps-tree "0.1.2"]
                  [lein-ritz "0.7.0"]
                  [lein-immutant "0.17.1"]]
         :aliases {"slamhound" ["run" "-m" "slam.hound"]}}
         :injections [(require '(clojure.tools.namespace repl find))
                      ; try/catch to workaround an issue where `lein repl` outside a project dir
                      ; will not load reader literal definitions correctly:
                      (try (require 'spyscope.core)
                        (catch RuntimeException e))
                      (let [orig (ns-resolve (doto 'clojure.stacktrace require)
                                             'print-cause-trace)
                            new (ns-resolve (doto 'clj-stacktrace.repl require)
                                            'pst)]
                        (alter-var-root orig (constantly @new)))]
         :repl-options {:nrepl-middleware [inspector.middleware/wrap-inspect
                                           ritz.nrepl.middleware.javadoc/wrap-javadoc
                                           ritz.nrepl.middleware.apropos/wrap-apropos]}}
