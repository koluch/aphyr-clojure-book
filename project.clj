(defproject aphyr-clojure-book "0.1.0-SNAPSHOT"
  :description "FIXME: write description"
  :url "http://example.com/FIXME"
  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :dependencies [[org.clojure/clojure "1.7.0"]
                 [clojure-saxon "0.9.4"]
                 [net.sourceforge.htmlcleaner/htmlcleaner "2.6.1"]]
  :main ^:skip-aot aphyr-clojure-book.core
  :target-path "target/%s"
  :profiles {:uberjar {:aot :all}})
