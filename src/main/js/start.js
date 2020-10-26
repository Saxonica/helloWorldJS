window.onload = function() {
  SaxonJS.transform({
    stylesheetLocation: "xslt/stylesheet.sef.json",
    sourceLocation: "xml/home.xml?x=2"
  }, "async");
}
