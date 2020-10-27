window.onload = function() {
  SaxonJS.transform({
    stylesheetLocation: "xslt/stylesheet.sef.json",
  }, "async");
}
