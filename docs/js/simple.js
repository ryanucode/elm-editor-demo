function addSyntaxHighlighting() {
  for (elem in document.querySelectorAll("pre.highlight")) {
    hljs.highlightBlock(elem)
  }
}

// this function attempts 
function addCodeMirror(app) {
  return () => {
    textarea = document.getElementById("codemirror")
    codemirror = CodeMirror.fromTextArea(textarea, {
      name: "simple",
      lineNumbers: true,
      mode: "htmlmixed"
    })
    codemirror.on("change", (codemirror, change) => {
      //console.log(codemirror.doc.getValue())
      app.ports.codeMirrorChange.send(codemirror.doc.getValue())
    })
  }
}

document.addEventListener("DOMContentLoaded", (event) => {
  app = Elm.Simple.fullscreen()

  // code mirror and highlight.js are bound by the elm app to make sure our elm
  // app has had the chance to render its dom before these 2 elements try to
  // bind

  // had to comment this out. adding both codemirror and highlight.js look like
  // they break ports?

  //app.ports.addSyntaxHighlighting.subscribe(addSyntaxHighlighting)
  app.ports.addCodeMirror.subscribe(addCodeMirror(app))
})
