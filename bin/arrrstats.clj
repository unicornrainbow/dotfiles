#!/Users/myfreeweb/.cljr/bin/cljr run
(use 'somnium.congomongo,
     ['clojure.contrib.string :only '[substring?]]
     '(incanter core datasets charts mongodb))

(set-connection! (make-connection "code-stat"))
(def ds (fetch-dataset :stat))

(with-data (->> ($map #(. % getHours) :time ds)
                (conj-cols ds)
                (conj-cols ($map #(if (substring? "Code/private" %) "Private code" "TextExpander config") :path ds))
                ($rollup :count :count [:col-0 :col-5])
                ($order :col-5 :asc))
           (view (line-chart :col-5 :count
                             :group-by :col-0
                             :legend true
                             :title "Writes by hour and place"
                             :x-label "hour"
                             :y-label "writes")))
