{:user {:dependencies [[clj-stacktrace "0.2.5"]
                       [slamhound "1.3.1"]]
        :plugins [[lein-light "0.0.16"]
                  [lein-swank "1.4.5"]
                  [lein-pprint "1.1.1"]
                  [lein-clojars "0.9.1"]
                  [lein-localrepo "0.4.1"]
                  [lein-sub "0.2.4"]
                  [lein-kibit "0.0.8"]
                  [lein-immutant "0.17.1"]]
         :aliases {"slamhound" ["run" "-m" "slam.hound"]}}
         :injections [(let [orig (ns-resolve (doto 'clojure.stacktrace require)
                                             'print-cause-trace)
                            new (ns-resolve (doto 'clj-stacktrace.repl require)
                                            'pst)]
                        (alter-var-root orig (constantly @new)))]}
