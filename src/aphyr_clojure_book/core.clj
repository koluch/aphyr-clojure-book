(ns aphyr-clojure-book.core
  (:gen-class)
  (:require [saxon :as xml]))

(defn -main
  "I don't do a whole lot ... yet."
  [& args]
  (println "Hello, World!"))

(def input (xml/compile-xml "<html><body/></html>"))

(def xsl (xml/compile-xslt (new java.io.File "/Users/koluch/Dropbox/dev/clojure/aphyr-clojure-book/resources")))

