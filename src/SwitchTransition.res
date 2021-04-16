type state = string
type node = Dom.element
type isAppearing = bool
type enterMethod = (node, isAppearing) => unit
type exitMethod = node => unit

@deriving(abstract)
type timeoutFull = {
  @optional
  enter: int,
  @optional
  exit: int,
}
type transition = [#UNMOUNTED | #EXITED | #ENTERING | #ENTERED | #EXITING ]


// #UNMOUNTED = 'unmounted'
// #EXITED = 'exited'
// #ENTERING = 'entering'
// #ENTERED = 'entered'
// #EXITING = 'exiting'


type modes = [#out | #\"in"]

  @module("react-transition-group/cjs/index") @react.component
  external make: (
    ~modes: option<modes>,

    ~children: state => React.element,
  ) => React.element = "SwitchTransition"
