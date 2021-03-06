open RescriptTransitionGroup

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
  let starExit = style(list{label("star-exit"), opacity(1.), transform(scale(1.25, 1.25))})
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
    <button onClick={_event => toggleShow(_ => !show)}> {"Toggle" |> React.string} </button>
    <CSSTransition _in=show unmountOnExit=true timeout=#int(300) classNames>
      {state => {
        let isIn = state === "entered"
        <div className="msg">
          {"Your name rocks!" |> React.string}
          <CSSTransition _in=isIn timeout=#int(300) classNames unmountOnExit=true>
            {_state => <div className=Styles.star> {"X" |> React.string} </div>}
          </CSSTransition>
        </div>
      }}
    </CSSTransition>
  </div>
}
