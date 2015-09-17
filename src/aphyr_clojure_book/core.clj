(ns aphyr-clojure-book.core
  (:gen-class)
  (:require [saxon :as xml]))

(defn -main
  "I don't do a whole lot ... yet."
  [& args]
  (println "Hello, World!"))

(defn transform 
    [input xsl output]
    
    (let [comp-input (xml/compile-xml input)
          comp-xsl (xml/compile-xslt xsl)]
        (xml/serialize (comp-xsl comp-input) output)))

(-> (transform (new java.io.File "resources/input.xml") 
               (new java.io.File "resources/style.xsl") 
               (new java.io.File "resources/output.xml"))
    (pprint))




