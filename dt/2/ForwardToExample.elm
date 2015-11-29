--from https://github.com/elm-guides/elm-for-js/blob/master/Mailboxes%2C%20Messages%2C%20and%20Addresses.md
module ForwardToExample where

import Graphics.Input exposing (checkbox)
import Graphics.Element exposing (flow, down, right, show, Element)

type Side = Forward | Rear
type Action = NoOp | Shield Side Bool


type alias Model = {forward: Bool, rear: Bool}

fwd0 = True
rear0 = False
model0 : Model
model0 = Model fwd0 rear0

myMailbox = Signal.mailbox NoOp

cbForward =
    checkbox
    (\b -> Signal.message myMailbox.address (Shield Forward b))
    fwd0

cbRear =
    checkbox
    (Signal.message (Signal.forwardTo myMailbox.address (Shield Rear)))
    rear0

step : Action -> Model -> Model
step a m =
    case a of
        NoOp -> m
        Shield Forward b -> {m | forward = b}
        Shield Rear b -> {m | rear = b}

model : Signal Model
model = Signal.foldp step model0 myMailbox.signal

view : Model -> Element
view model =
    flow down 
    [ flow right [cbForward, cbRear]    
    , show model
    ]

main : Signal Element
main =
    Signal.map view model
