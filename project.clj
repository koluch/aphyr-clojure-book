(defproject aphyr-clojure-book "0.1.0-SNAPSHOT"
  :description "FIXME: write description"
  :url "http://example.com/FIXME"
  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :dependencies [[org.clojure/clojure "1.7.0"]
                 [clojure-saxon "0.9.4"]
                 [net.sourceforge.htmlcleaner/htmlcleaner "2.6.1"]
                 [log4j/log4j "1.2.17"]
                 [org.apache.xmlgraphics/fop "2.0"]
                 [org.eclipse.jgit/org.eclipse.jgit "4.0.2.201509141540-r"]]
  :aliases {"download" ["run" "-m" "aphyr-clojure-book.core/-download"]
            "convert" ["run" "-m" "aphyr-clojure-book.core/-convert"]}
  :main ^:skip-aot aphyr-clojure-book.core
  :target-path "target/%s"
  :profiles {:uberjar {:aot :all}})
