# Hello World in Saxon JS 2

This project contains (almost) the simplest possible “hello world”
example using Saxon JS 2.

## Prerequisites

This goal of this project is to show you how to get a simple Saxon JS
project up and running. It makes a few assumptions about your system.

By default, the project uses Python to run a simple web server, so you
need to have Python installed. If you don’t want to use Python, that’s
fine, you can use any web server that you want, just configure it to
serve up the files in `build/website` and ignore the `server` build
target.

If you want to use the free “XX” compiler, we have to install a couple
of NodeJS modules. We assume that the `npm` command is available and
that it will install its modules into `node_modules`.

## TL;DR

Run `./gradlew server` and point your web browser at
[http://localhost:9000/](http://localhost:9000/).

(If you’re not prepared to use the Python web server, run
`./gradlew publish` and point your web browser at whatever you
configured to serve up `build/website`.)

## What is it?

This application is a single web page that displays some “Hello,
World” text and a button. If you push the button, it tells you that
you’ve pushed the button.

That’s pretty dull to look at, but the cool part is what it does
behind the scenes.

## What does it do?

The initial HTML page contains a single `div` that displays the text
“Loading…”. The browser’s `Window.onLoad` callback is changed so that
it calls a XSLT transformation using Saxon JS when the page is loaded.

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

## How does it work?

There are a few moving pieces. They aren’t all strictly part of the
Saxon JS transformation, but they are intended to give you a sense of
how the pieces might fit together in a more realistic application.

### The sources

All of the sources are under `src/main`:

* `html` contains the initial HTML page.
* `js` contains the JavaScript code that updates the `Window.onLoad` method.
* `xml` contains the XML source that will be transformed.
* `xslt` contains the XSLT *source* file. This file must be compiled.
* `css` contains a simple CSS stylesheet that applies to the rendered page.

### The compiler

There are two ways to compile the XSLT stylesheet so that it’s ready
to be used in the browser, and there are three ways to use this
project.

1. If you want to use the free Saxon JS compiler, change the
   `xsltCompiler` property in `gradle.properties` to `XX`. Using this
   option requires that you have NodeJS installed and configured on
   your system.
2. If you want to use the Saxon EE Java compiler, you may have to
   change the `saxonLicenseDir` property to point to the directory
   where you store your `saxon-license.lic` file.
3. If you just want to try it out, you can ignore both of the
   preceding options. The project comes with a precompiled version of
   the stylesheet that will work “out of the box”. Of course, if you
   choose this option, you won’t be able to see any changes if you
   edit the XSLT stylesheet.

## The build

This project uses [Gradle](https://gradle.org/) as a build tool.
There’s nothing about Saxon JS that depends on or requires Gradle,
it’s just a convenient way to collect the build dependencies (Saxon
EE, for example), configure, and build the project. You could equally
use Make or Ant or a shell script or a batch file or just run the
commands by hand if you want to.

There are three interesting “top level” build targets:

* `publish` copies the HTML, CSS, and JavaScript resources into the
  website directory and compiles the XSLT stylesheet.
* `server` runs the publish step then uses Python to setup a simple
   web server for testing. Saxon JS works best if it’s served over
   HTTP. This has nothing to do with Saxon JS in particular, it’s just
   that web browsers are finicky about what they’ll do with `file://`
   URIs and JavaScript.
* `clean` deletes all the downloaded and built artifacts.

## Configuration

There are several configuration properties you can change. These allow
you to select the compiler and configure versions and so forth. See
the comments in `gradle.properties` for more details.

# Next steps

Once you have it running, you can start playing around. Make changes
to the files under `src/main`, run `gradle publish` again, and see
what happens!

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
