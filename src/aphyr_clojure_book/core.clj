(ns aphyr-clojure-book.core
  (:gen-class)
  (:require [saxon :as xml]
            [clojure.java.io :as io])
  (:import [org.htmlcleaner HtmlCleaner
                            CleanerProperties
                            SimpleXmlSerializer]))

; Steps functions
(defn download
  [uri to-file]
  (with-open [in (io/input-stream uri)
              out (io/output-stream to-file)]
    (io/copy in out)))

(defn clean
  [^java.io.File in ^java.io.File out]
  (let [props (CleanerProperties.)]
    (doto props
      (.setTranslateSpecialEntities false)
      (.setTransResCharsToNCR false)
      (.setOmitComments false))
    (let [cleaner (HtmlCleaner. props)
          cleaned (.clean cleaner in)]
      (let [serializer (SimpleXmlSerializer. props)]
        (.writeToFile serializer cleaned (.getPath out) "utf-8")))))

(defn transform
  [input xsl output]
  (let [comp-input (xml/compile-xml input)
        comp-xsl (xml/compile-xslt xsl)]
    (xml/serialize (comp-xsl comp-input) output [[:method "xml"]])))




(defn make-pdf
  [input output]
  (with-open [out (io/output-stream output)]
    (let [fop-conf-parser (org.apache.fop.apps.FopConfParser. (java.io.File. "resources/fop.xconf"))
          fop-factory-builder (.getFopFactoryBuilder fop-conf-parser)
          fop-factory (.build fop-factory-builder)
          fop (.newFop fop-factory org.apache.fop.apps.MimeConstants/MIME_PDF out)
          transformer-factory (javax.xml.transform.TransformerFactory/newInstance)
          transformer (.newTransformer transformer-factory)
          src (javax.xml.transform.stream.StreamSource. input)
          res (javax.xml.transform.sax.SAXResult. (.getDefaultHandler fop))]
      (.transform transformer src res))))


; Interface
(defn -download
  "Update resources/input.html from aphyr.com"
  [& args]
  (do
    (download "https://aphyr.com/tags/Clojure-from-the-ground-up" (java.io.File. "resources/input.html"))))

              
(defn -convert
  "Make pdf"
  [& args]
  (do
    (clean (java.io.File. "resources/input.html") (java.io.File. "target/cleaned.xml"))
    (transform (new java.io.File "target/cleaned.xml")
               (new java.io.File "resources/restructure.xsl")
               (new java.io.File "target/restructured.xml"))
    (transform (new java.io.File "target/restructured.xml")
               (new java.io.File "resources/html-to-fo.xsl")
               (new java.io.File "target/fo.xml"))
    (.mkdir (new java.io.File "pdf"))
    (make-pdf (new java.io.File "target/fo.xml")
              (new java.io.File "pdf/Kyle Kingsbury - Clojure from the ground up.pdf"))))

(defn -main
  "Fully rebuild project"
  [& args]
  (do
    (-download)
    (-convert)))