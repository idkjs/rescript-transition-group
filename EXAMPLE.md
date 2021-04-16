Examples from [official docs](https://reactcommunity.org/react-transition-group) translated to [Rescript && React](https://rescript-lang.org/docs/react/latest/introduction) using [bs-css && bs-css-emotion](https://github.com/SentiaAnalytics/bs-css).

## Transition

```reason
open ReasonTransitionGroup

type state = {show: bool}
type action = Toggle

@react.component
let make = () => {
  let (show, toggleShow) = React.useState(() => false)
  <div
    style={ReactDOMRe.Style.make(~display="flex", ~flexDirection="column", ())}>
    <button onClick={_event => toggleShow(_ => !show)}>
      {"Toggle" |> React.string}
    </button>
    <Transition
      _in=show
      unmountOnExit=true
      timeout=#obj(Transition.timeoutFull(~enter=500, ~exit=1500, ()))
    />
  </div>
}
```

## CSSTransition

```reason
open ReasonTransitionGroup

type state = {show: bool}
type action = Toggle

module Styles = {
  open Css

  let wrapper = style(list{display(#flex), flexDirection(#column)})

  let messageEnter = style(list{
    opacity(0.1),
    label("msg-enter"),
    transforms(list{scale(0.9, 0.9), translateY(#percent(50.))}),
  })
  let messageEnterActive = style(list{
    opacity(1.),
    label("msg-enter-active"),
    transforms(list{scale(1., 1.), translateY(#percent(0.))}),
    transition(~duration=300, ~timingFunction=#easeOut, "all"),
  })
  let messageExit = style(list{
    opacity(1.),
    label("msg-exit"),
    transforms(list{scale(1., 1.), translateY(#percent(0.))}),
  })
  let messageExitActive = style(list{
    opacity(0.01),
    label("msg-exit-active"),
    transforms(list{scale(0.9, 0.9), translateY(#percent(50.))}),
    transition(~duration=300, ~timingFunction=#easeOut, "all"),
  })
  let star = style(list{
    label("star"),
    display(#inlineBlock),
    marginLeft(#rem(0.5)),
    transform(#scale(1.25, 1.25)),
  })
  let starEnter = style(list{
    label("star-enter-active"),
    opacity(0.1),
    transforms(list{translateY(#percent(-100.)), scale(0.75, 0.75)}),
  })
  let starEnterActive = style(list{
    label("star-enter-active"),
    opacity(1.),
    transforms(list{translateY(#percent(0.)), scale(1.25, 1.25)}),
    transition(~duration=300, ~timingFunction=#easeOut, "all"),
  })
  let starExit = style(list{
    label("star-exit"),
    opacity(1.),
    transform(scale(1.25, 1.25)),
  })
  let starExitActive = style(list{
    opacity(0.),
    transform(scale(4., 4.)),
    transition(~duration=300, ~timingFunction=#easeOut, "all"),
  })
}

let classNames = #obj(
  CSSTransition.classFull(
    ~enter=Styles.starEnter,
    ~enterActive=Styles.starEnterActive,
    ~exit=Styles.starExit,
    ~exitActive=Styles.starExitActive,
    (),
  ),
)

@react.component
let make = () => {
  let (show, toggleShow) = React.useState(() => false)
  <div className=Styles.wrapper>
    <button onClick={_event => toggleShow(_ => !show)}>
      {"Toggle" |> React.string}
    </button>
    <CSSTransition _in=show unmountOnExit=true timeout=#int(300) classNames>
      {state => {
        let isIn = state === "entered"
        <div className="msg">
          {"Your name rocks!" |> React.string}
          <CSSTransition
            _in=isIn timeout=#int(300) classNames unmountOnExit=true>
            {_state => <div className=Styles.star> {"X" |> React.string} </div>}
          </CSSTransition>
        </div>
      }}
    </CSSTransition>
  </div>
}
```

## CSSTransition 2

```reason
open ReasonTransitionGroup

module Styles = {
  open Css
  let alertEnter = style(list{
    opacity(0.),
    transform(#scale(0.9, 0.9)),
    label("alert-enter"),
  })
  let alertEnterActive = style(list{
    opacity(1.),
    transform(#translateX(#zero)),
    transition(~duration=300, "all"),
    label("alert-enter-active"),
  })
  let alertExit = style(list{opacity(1.0), label("alert-exit")})
  let alertExitActive = style(list{
    opacity(0.),
    transform(#scale(0.9, 0.9)),
    transition(~duration=300, "all"),
    label("alert-exit-active"),
  })
  let btn = style(list{
    color(#hex("fff")),
    background(#hex("007bff")),
    borderColor(#hex("007bff")),
    borderRadius(#rem(0.3)),
    fontSize(#rem(1.25)),
    padding2(~v=#rem(0.5), ~h=#rem(1.0)),
  })
  let modal = style(list{
    height(#px(150)),
    width(#px(200)),
    color(#hex("004085")),
    background(#hex("cce5ff")),
    padding(#px(25)),
  })
  let modalHead = style(list{
    display(#flex),
    justifyContent(#spaceBetween),
    paddingBottom(#px(20)),
    label("alert"),
  })
  let modalTitle = style(list{fontSize(#px(18)), fontWeight(#bold)})
}

let classNames = #obj(
  CSSTransition.classFull(
    ~enter=Styles.alertEnter,
    ~enterActive=Styles.alertEnterActive,
    ~exit=Styles.alertExit,
    ~exitActive=Styles.alertExitActive,
    (),
  ),
)

@react.component
let make = () => {
  let (showButton, setShowButton) = React.useState(() => true)
  let (showMessage, setShowMessage) = React.useState(() => false)
  <div>
    {switch showButton {
    | true =>
      <button className=Styles.btn onClick={_ => setShowMessage(_ => true)}>
        {"Show Message" |> React.string}
      </button>
    | _ => React.null
    }}
    <CSSTransition
      _in=showMessage
      timeout=#int(300)
      classNames
      unmountOnExit=true
      onEnter={(_, _) => setShowButton(_ => false)}
      onExited={_ => setShowButton(_ => true)}>
      {_state =>
        <div className=Styles.modal>
          <div className=Styles.modalHead>
            <span className=Styles.modalTitle>
              {"Animated alert message" |> React.string}
            </span>
            <div onClick={_ => setShowMessage(_ => false)}>
              {"x" |> React.string}
            </div>
          </div>
          <span>
            {"This alert message is being transitioned in and out of the DOM." |> React.string}
          </span>
        </div>}
    </CSSTransition>
  </div>
}
```
