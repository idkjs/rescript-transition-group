// ReactDOM.renderToElementWithId(<Component1 />, "index1")

// ReactDOM.renderToElementWithId(<Component2 />, "index2")

// ReactDOM.renderToElementWithId(<CssTransitionExample2 />, "index3")
let {render, querySelector} = module(ReactDOM)
switch querySelector("#index1") {
| None => ()
| Some(e) => render(<Component1 />, e)
}
switch querySelector("#index2") {
| None => ()
| Some(e) => render(<Component2 />, e)
}
switch querySelector("#index3") {
| None => ()
| Some(e) => render(<CssTransitionExample2 />, e)
}
