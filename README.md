# Hello World in Saxon JS 2

This project contains (almost) the simplest possible “hello world”
example using Saxon JS 2.

## Quick start!

Don’t feel like reading anything? Just run `gradle server` and point
your web browser at `http://localhost:9000/`.

## What is it?

This application is a single web page that displays some “Hello,
World” text and a button. If you push the button, it tells you you’ve
pushed the button.

That’s pretty dull, but the cool part is what it does.

# What does it do?

The initial HTML page contains a single `div` that displays the text
“Loading…”. When the page is actually loaded the browsers’s
`Window.onLoad` callback is changed so that it calls a XSLT
transformation using Saxon JS.

That stylesheet transforms a simple “Hello, World” XML document:

```
<doc>
<title>Hello, World</title>
<para>This is my first Saxon JS experiment.</para>
</doc>
```

into XHTML and updates the web page (this replaces the loading message).

The stylesheet also adds a button to the page and creates an
`ixsl:onclick` template that responds when that button is pressed.
Clicking on the button causes another XSLT template to fire which
counts the number of times the button has been pressed and outputs a
message.

# How does it work?

There are a few moving pieces. They aren’t all strictly part of the
Saxon JS transformation, but they are intended to give you a sense of
how the pieces might fit together in a more realistic application.

## The sources

All of the sources are under `src/main`:

* `html` contains the initial HTML page.
* `js` contains the JavaScript code that updates the `Window.onLoad` method.
* `xml` contains the XML source that will be transformed.
* `xslt` contains the XSLT *source* file. This file must be compiled.
* `css` contains a simple CSS stylesheet that applies to the rendered page.

### The non-sources

If you are interested in trying out this project but you don’t have a
Saxon EE license, that’s ok! The project includes a pre-compiled
version of the stylesheet in `precompiled`. You can also compile
stylesheets with the Saxon JS compiler; we’ll add support for that to
this project in the future.

## The build

This project uses [Gradle](https://gradle.org/) as a build tool.
There’s nothing about Saxon JS that depends on or requires Gradle,
it’s just a convenient way to collect the build dependencies (Saxon
EE, for example), configure, and build the project. You could equally
use Make or Ant or a shell script or a batch file or just run the
commands by hand if you want to.

There are four interesting build targets:

* `copyResources` copies the source files into the build directory.
  This target will automatically download the Saxon JS release.
* `compileXslt` compiles the source stylesheet into a SEF file.
* `publish` runs the `copyResources` and `compileXslt` steps to
  publish a complete application.
* `server` uses Python to setup a simple web server for testing. If
  you don’t have Python, you can use any web server you want, but
  Saxon JS works best if it’s served over HTTP. This has nothing to do
  with Saxon JS in particular, it’s just that web browsers are finicky
  about what they’ll do with `file://` URIs and JavaScript.

In order to use the Saxon EE compiler, you have to have a Saxon EE
license. The build system attempts to determine if you have a license.
It will fall back to the precompiled stylesheet if it failes to find
one.

## Configuration

There are four configuration properties in `gradle.properties`:

* `saxonVersion` determines what version of Saxon to use. You’re
  limited to 10.2 at the moment because the Saxonica Maven repository
  is still under construction.
* `saxonJsVersion` determines what version of Saxon JS to use.
* `saxonLicenseDir` tells the build where you have stored your Saxon
  license. If it’s not in `~/java`, update this setting.
* `serverPort` tells the Python server what port to use.

# Next steps

Once you have it running, you can start playing around. Make changes
to the files under `src/main`, run `gradle publish` again, and see what happens!

# Random observations

1. When Saxon JS adds elements to an HTML page, if they aren’t in a
   namespace, it automatically puts them in the HTML namespace. That’s handy.
2. The browser caches things and sometimes that means “reload” doesn’t
   do what you want. Using the “pointless query string” trick can
   help. For example, I sometimes write `sourceLocation:
   "xml/home.xml?x=2"` in my call to the transform function from
   JavaScript. If the browser caches that in a way that I find
   annoying, I change the URI to `x=3`. That makes it different from
   the browsers perspective but doesn’t change the results.
