{:user {:dependencies [[clj-stacktrace "0.2.5"]]
        :plugins [[lein-light "0.0.16"]
                  [lein-swank "1.4.5"]
                  [lein-pprint "1.1.1"]
                  [lein-clojars "0.9.1"]
                  [lein-ring "0.7.5"]
                  [lein-sub "0.2.4"]]}
         :injections [(let [orig (ns-resolve (doto 'clojure.stacktrace require)
                                             'print-cause-trace)
                            new (ns-resolve (doto 'clj-stacktrace.repl require)
                                            'pst)]
                        (alter-var-root orig (constantly @new)))]}
