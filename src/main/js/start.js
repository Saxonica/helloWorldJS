"use strict";

// Assumes we will have loaded Saxon JS 2 and the Showdown markdown
// converter (https://github.com/showdownjs/showdown) before we call
// these functions.

let helloWorld = function() {
  function transformXml() {
    let options = { stylesheetLocation: "xslt/stylesheet.sef.json" };
    SaxonJS.transform(options, "async");
  }

  function transformMarkdown(text) {
    let converter = new showdown.Converter();
    return converter.makeHtml(text);
  }

  return {
    "transformXml": transformXml,
    "transformMarkdown": transformMarkdown
  };
}();

window.onload = helloWorld.transformXml;

// This needs to be a global function to be callable from SaxonJS
function saxonTransformMarkdown(text) {
  return helloWorld.transformMarkdown(text);
}
