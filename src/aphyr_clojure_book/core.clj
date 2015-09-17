(ns aphyr-clojure-book.core
  (:gen-class)
  (:require [saxon :as xml]
            [clojure.java.io :as io])
  (:import [org.htmlcleaner HtmlCleaner
                            CleanerProperties
                            PrettyXmlSerializer]))

(defn -main
  "I don't do a whole lot ... yet."
  [& args]
  (println "Hello, World!"))

(defn download 
    [uri to-file]
    (with-open [in (io/input-stream uri)
                out (io/output-stream to-file)]
        (io/copy in out)))

(defn clean
    [in out]
    (let [props (CleanerProperties.)]
        (doto props
            (.setTranslateSpecialEntities true)
            (.setTransResCharsToNCR true)
            (.setOmitComments true))
        (let [cleaner (HtmlCleaner. props)
              cleaned (.clean cleaner in)]
            (let [serializer (PrettyXmlSerializer. props)]
                (.writeToFile serializer cleaned (.getPath out) "utf-8")))))

(defn transform 
    [input xsl output]
    (let [comp-input (xml/compile-xml input)
          comp-xsl (xml/compile-xslt xsl)]
        (xml/serialize (comp-xsl comp-input) output)))

(do (download "https://aphyr.com/tags/Clojure-from-the-ground-up" (java.io.File. "target/input.html"))
    (clean (java.io.File. "target/input.html") (java.io.File. "target/input.xml"))
    (transform (new java.io.File "target/input.xml") 
               (new java.io.File "resources/style.xsl") 
               (new java.io.File "target/output.xml")))



