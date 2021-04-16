# rescript-transition-group

This is [Rescript & React](https://rescript-lang.org/docs/react/latest/introduction) bindings for [react-transition-group](https://github.com/reactjs/react-transition-group).


# Install, [npm](https://www.npmjs.com/package/rescript-transition-group)

```
yarn add rescript-transition-group
```

# Setup

Add rescript-transition-group to `bs-depenencies` in your `bsconfig.json`!

```js
{
  /* ... */
  "bs-dependencies": [
    "rescript-transition-group"
  ],
  /* ... */
}
```

# Usage

Folow official docs of [React Transition Group](https://reactcommunity.org/react-transition-group/).

```rescript
open ReasonTransitionGroup

/* ... */
<Transition _in={inState} timeout=`int(500)>
{state => <div>{state |> ReasonReact.string}</div>}
</Transiton>
/* ... */

/* ... */
<CSSTransition _in={inState} timeout=`obj(CSSTransition.timeoutFull(~enter: 500, ~exit:0, ())) classNames=`string(myClassName)>
{state => <div>{state |> ReasonReact.string}</div>}
</CSSTransiton>
/* ... */


/* ... */
<CSSTransition _in={inState} timeout=`obj(CSSTransition.timeoutFull(~enter: int, ~exit:int, ())) classNames=`obj(CSSTransition.classFull(~appear: str, ~exit: str, ()))>
{state => <div>{state |> ReasonReact.string}</div>}
</CSSTransiton>
/* ... */

```

Also check react-transition-group examples translated to rescript [here](./EXAMPLE.md).

Feel free to post issues.
